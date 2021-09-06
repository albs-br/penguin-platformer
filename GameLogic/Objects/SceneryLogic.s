Scenery_Logic:
    ; Return if enemy is dead
    ; ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ; ld      a, (hl)
    ; or      a
    ; ret     z


    ; call    .enemiesCounterRoutine


.copySceneryPropertiesToTempVars:


    ; Copy scenery properties to temp variables
    ld      hl, (UpdateBgObjects_Enemy_Return_Addr)             ; source
    ld      de, SCENERY_STRUCT_SIZE                             ; destiny
    ld      bc, SCENERY_STRUCT_SIZE                             ; size
    ldir                                                        ; Copy BC bytes from HL to DE



    ; Setup local variables/pointers
    ld      hl, (UpdateBgObjects_CurrentAddr_State)

    inc     hl
    ld      (UpdateBgObjects_CurrentAddr_X_Offset), hl
    ld      a, (hl)
    ld      (UpdateBgObjects_X_Offset_Value), a
    ld      (UpdateBgObjects_X_Offset_Value_Adjusted), a

    inc     hl
    ld      (UpdateBgObjects_CurrentAddr_EnemyType), hl



    ; Check if enemy is dying (show animation and not move)
    ; ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ; ld      a, (hl)
    ; cp      2
    ; jp      nc, .animateEnemyDying        ; a >= n



.showEnemySprites:
	exx
        ; Switch scenery type
        ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
        ld      a, (hl)
        
        cp      SCENERY_TYPE_BUSH
        jp      z, .sceneryBush

        ; cp      SCENERY_OTHER
        ; jp      z, .scenery????

.sceneryBush:
        ld      a, ARMADILLO_1ST_SPRITE_LEFT ; TODO
        ld      (UpdateBgObjects_Enemy_TypeB_n_1st_Sprite_Pattern), a
        ld      a, ARMADILLO_2ND_SPRITE_LEFT ; TODO
        ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Pattern), a
        ld      a, ARMADILLO_3RD_SPRITE_LEFT
        ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Pattern), a

        call    .loadSceneryBushSprite

        jp      .continue

.continue:
    exx
    
    ; Place enemy sprite

    ; Get x coord in pixels
    ld      hl, (UpdateBgObjects_PosObjOnBG)
    call    Convert_BgPosition_X_To_X_In_Pixels    
    dec     a                                       ; fix x position (not sure why)
        
        ; No offset for objects
        
        ; adjust for x offset
        ; EnemyX = EnemyX - xOffset
        ; ld      c, a
        ; ld      a, (UpdateBgObjects_X_Offset_Value)
        ; ld      b, a
        ; ld      a, c
        ; sub     b

ld a, 128; //[debug]
    ld      (UpdateBgObjects_Enemy_TypeB_n_X), a


    ; Get Y position (already stored in pixels)
    ld      hl, (UpdateBgObjects_CurrentAddr)
    inc     hl
    inc     hl
    ld      a, (hl)
    dec     a               ; adjust for the Y - 1 TMS 9918 bug/feature

ld a, 128; //[debug]
    ld      (UpdateBgObjects_Enemy_TypeB_n_Y), a
    inc     hl
    inc     hl
    inc     hl
    inc     hl
    ld      a, (hl)
    dec     a               ; adjust for the Y - 1 TMS 9918 bug/feature
    ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Y), a
    inc     hl
    ld      a, (hl)
    dec     a               ; adjust for the Y - 1 TMS 9918 bug/feature
    ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Y), a

.skipCopyPattern:

    ; ; Move enemy / check collision only if enemy is alive (it may be on dying animation)
    ; ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ; ld      a, (hl)
    ; cp      2
    ; jp      nc, .return     ; if (a >= n)



; -------------------- Object movement
    ; Change x offset and save it back
    
    ; ; Don't move if player is in death animation state
    ; ld      a, (Player_DeathAnimation)
    ; or      a
    ; jp      nz, .continue_xoffset_1

    ; Move object only at each 4 frames
    ; ld      a, (BIOS_JIFFY)                         ; MSX BIOS time variable
    ; and     0000 0011 b                             ; each 4 frames
    ; jp      nz, .continue_xoffset_1

    ; ; Check 7th bit of enemy type (it stores the direction)
    ; ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
    ; ld      a, (hl)
    ; and     ENEMY_FACING_RIGHT                      ; a little faster than bit 7, a
    ; jp      nz, .moveEnemyRight
    
    ; ; Move enemy left
    ; ld      a, (UpdateBgObjects_X_Offset_Value)
    ; inc     a
    ; cp      16                                      ; if (X_Offset == 16) { X_Offset = 0; EnemyColumnPosition--; }
    ; jp      nz, .saveXoffset_Left
    
    ; ld      hl, (UpdateBgObjects_CurrentAddr)
    ; ld      a, (hl)
    ; dec     a
    ; ld      (hl), a
    ; xor     a                                       ; clear UpdateBgObjects_X_Offset_Value
    ; jp      .saveXoffset_Left

; .moveEnemyRight:
;     ; Move enemy right
;     ld      a, (UpdateBgObjects_X_Offset_Value)
;     dec     a
;     cp      -1                                      ; if (X_Offset == -1) { X_Offset = 15; EnemyColumnPosition++; }
;     jp      nz, .saveXoffset_Right
    
;     ld      hl, (UpdateBgObjects_CurrentAddr)
;     ld      a, (hl)
;     inc     a
;     ld      (hl), a
;     ld      a, 15

; .saveXoffset_Right:
;     ld      (UpdateBgObjects_X_Offset_Value), a
;     ld      hl, (UpdateBgObjects_CurrentAddr_X_Offset)
;     ld      (hl), a
;     jp      .continue_xoffset_1

; .saveXoffset_Left:
;     ld      (UpdateBgObjects_X_Offset_Value), a
;     ld      hl, (UpdateBgObjects_CurrentAddr_X_Offset)
;     ld      (hl), a

.continue_xoffset_1:
    
    ; ld      a, (Player_IsAlive)
    ; or      a
    ; jp      z, .return

    ; ;  Check collision - penguin jumped over enemy
    ; ld      a, (UpdateBgObjects_Enemy_TypeB_n_Y)
    ; ld      e, a
    ; ld      a, (UpdateBgObjects_Enemy_TypeB_n_X)
    ; ld      d, a
    ; call    CheckIfPenguinJumpedOverEnemy
    ; or      a
    ; jp      z, .checkBackground


    ; ; Start jump (bounce on the enemy)
    ; call    GameLogic.startJumping

; .animateEnemyDying:
;     ld      hl, (UpdateBgObjects_CurrentAddr_State)
;     ld      a, (hl)
;     inc     a
;     cp      60
;     jp      z, .endAnimationEnemyDying

;     ld      (hl), a
;     and     0000 0011 b
;     jp      z, .showEnemySprites


    ; ; hide sprites
    ; xor     a                           ; transparent color
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_1st_Sprite_Color), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Color), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Color), a
    ; jp      .return

;.showEnemySprite:
    ; show sprite
    ; ld      a, (UpdateBgObjects_Enemy_Sprite_Color)
    ; ld      (UpdateBgObjects_Enemy_TypeA_n_Color), a

    ; and show tiles
    ;jp      .showEnemySprites

; .endAnimationEnemyDying:
;     ld      hl, (UpdateBgObjects_CurrentAddr_State)
;     ld      (hl), 0
    
    ; ; hide sprite
    ; xor     a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_1st_Sprite_Pattern), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Pattern), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Pattern), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_1st_Sprite_Color), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Color), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Color), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_X), a
    ; ld      a, 192
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_Y), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Y), a
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Y), a
    
    jp      .return

;TODO: put this routine in EnemiesCommon
; .checkBackground:
;     ; Check 7th bit of enemy type (it stores the direction)
;     ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
;     ld      a, (hl)
;     and     ENEMY_FACING_RIGHT                      ; a little faster than bit 7, a
;     jp      nz, .checkBackgroundRight

; .DISTANCE_TO_WALL_LEFT:      equ 2

;     ; Check collision with background left
;     ld      a, (UpdateBgObjects_Enemy_TypeB_n_X)
;     cp      8
;     jp      c, .changeDirectionToRight             ; if a < 8 (fix bug when enemy is at screen left border)
;     sub     .DISTANCE_TO_WALL_LEFT
;     ld      h, a
;     ld      a, (UpdateBgObjects_Enemy_TypeB_n_Y)
;     add     8
;     ld      l, a
;     call    CheckBackGround_Left
;     jp      nz, .changeDirectionToRight             ;

;     ; Check if has empty space under at left
;     ld      a, (UpdateBgObjects_Enemy_TypeB_n_X)
;     ;sub     8
;     ld      h, a
;     ld      a, (UpdateBgObjects_Enemy_TypeB_n_Y)
;     add     24
;     ld      l, a
;     call    CheckBackGround_Left
;     jp      nz, .return                             ; no empty space, then return

; .changeDirectionToRight:
;     ; Change direction to right
;     ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
;     ld      a, (hl)
;     or      ENEMY_FACING_RIGHT
;     ld      (hl), a

;     jp      .return

; .checkBackgroundRight:

; .DISTANCE_TO_WALL_RIGHT:      equ 16 + 1
;     ; Check collision with background right
;     ld      a, (UpdateBgObjects_Enemy_TypeB_n_X)
;     add     .DISTANCE_TO_WALL_RIGHT
;     ld      h, a
;     ld      a, (UpdateBgObjects_Enemy_TypeB_n_Y)
;     add     8
;     ld      l, a
;     call    CheckBackGround_Right
;     jp      nz, .changeDirectionToLeft             ;

;     ; Check if has empty space under at right
;     ld      a, (UpdateBgObjects_Enemy_TypeB_n_X)
;     add     16 + 1
;     ld      h, a
;     ld      a, (UpdateBgObjects_Enemy_TypeB_n_Y)
;     add     24
;     ld      l, a
;     call    CheckBackGround_Right
;     jp      nz, .return                             ; no empty space, then return

; .changeDirectionToLeft:
;     ; Change direction to left
;     ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
;     ld      a, (hl)
;     and     0111 1111 b                 ; reset 7th bit
;     ld      (hl), a
;     jp      .return

.return:

    ; Copy temp variables back to enemy properties
    ld      hl, UpdateBgObjects_Enemy_TypeB_n_BaseAddress   ; source
    ld      de, (UpdateBgObjects_Enemy_Return_Addr)         ; destiny
    ld      bc, ENEMY_TYPE_B_STRUCT_SIZE                    ; size
    ldir                                                    ; Copy BC bytes from HL to DE

    
    ; ; Do not increment counter if enemy is dead
    ; ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ; ld      a, (hl)
    ; or      a
    ; ret     z

    ld      hl, Enemies_TypeB_Counter
    inc     (hl)

    ret


; -------------------------------------------------------------------------

.enemiesCounterRoutine:
    ld      a, (Enemies_TypeB_Counter)
  
    ; cp      3
    ; jp      z, .enemy_4
    
    ; cp      2
    ; jp      z, .enemy_3
    
    ; cp      1
    ; jp      z, .enemy_2
    
    or      a               ; if (Enemies_TypeB_Counter == 0) jp .enemy_1
    jp      z, .enemy_1
    
    dec     a               ; if (Enemies_TypeB_Counter == 1) jp .enemy_2
    jp      z, .enemy_2
    
    dec     a               ; if (Enemies_TypeB_Counter == 2) jp .enemy_3
    jp      z, .enemy_3
                            ; else jp .enemy_4
.enemy_4:
    ld      hl, Enemy_TypeB_4_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl
    ret
.enemy_1:
    ld      hl, Enemy_TypeB_1_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl
    ret
.enemy_2:
    ld      hl, Enemy_TypeB_2_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl
    ret
.enemy_3:
    ld      hl, Enemy_TypeB_3_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl
    ret
    ; add enemies here


.loadSceneryBushSprite:
    ; Load colors (are the same for both left and right sprites)
    ld      a, COLOR_LIGHT_GREEN
    ld      (UpdateBgObjects_Enemy_TypeB_n_1st_Sprite_Color), a
    ld      a, COLOR_LIGHT_RED ; TODO
    ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Color), a
    ld      a, COLOR_YELLOW; TODO
    ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Color), a

    ; Check if sprite patterns are already loaded
    ld      a, (EnemyTypeB_1_CurrentSpriteLoaded)
    cp      SCENERY_TYPE_BUSH
    ret     z

    ; Switch to MegaROM page where the sprites are located
    ld      a, SPRITES_ENEMY_TYPE_B_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a

    ; If not, then load ARMADILLO sprite pattern at enemy type B FIRST position
    ld      hl, Bush_SpritePatterns                                                 ; Source on RAM
    ld      de, ENEMY_TYPE_B_1_SPRITE_ADDR_VRAM                                     ; Destiny on VRAM
    ld      bc, 32 * 1                                                              ; Size
    call 	fast_LDIRVM        							                            ; Block transfer to VRAM from memory

    ; Save flag indicating sprite loaded
    ld      a, SCENERY_TYPE_BUSH
    ld      (EnemyTypeB_1_CurrentSpriteLoaded), a

    ret
