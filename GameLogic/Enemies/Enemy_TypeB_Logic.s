Enemy_TypeB_Logic:
    ; Return if enemy is dead
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    or      a
    ret     z


    call    EnemiesCounterRoutine


.copyEnemyPropertiesToTempVars:


    ; Copy enemy properties to temp variables
    ld      hl, (UpdateBgObjects_Enemy_Return_Addr)
    ld      de, UpdateBgObjects_Enemy_n_BaseAddress     ; destiny
    ld      bc, ENEMY_STRUCT_SIZE                       ; size
    ldir                                                ; Copy BC bytes from HL to DE



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
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    cp      2
    jp      nc, .animateEnemyDying        ; a >= n



; TODO:
.showEnemySprites:
	exx
        ; switch enemy type
        ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
        ld      a, (hl)
        
        cp      ENEMY_TYPE_LADYBUG_LEFT
        jp      z, .enemyTypeLadybugLeft
        cp      ENEMY_TYPE_LADYBUG_RIGHT
        jp      z, .enemyTypeLadybugRight
        
        cp      ENEMY_TYPE_SNAIL_LEFT
        jp      z, .enemyTypeSnailLeft
        cp      ENEMY_TYPE_SNAIL_RIGHT
        jp      z, .enemyTypeSnailRight

.enemyTypeLadybugLeft:
        ; ld      a, LADYBUG_SPRITE_LEFT
        ld      a, TEST_SPRITE ; test sprite
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_RED
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a
        jp      .continue

.enemyTypeLadybugRight:
        ;ld      a, LADYBUG_SPRITE_RIGHT
        ld      a, TEST_SPRITE ; test sprite
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_RED
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a
        jp      .continue

.enemyTypeSnailLeft:
        ld      a, SNAIL_SPRITE_LEFT
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_DARK_YELLOW
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a
        jp      .continue

.enemyTypeSnailRight:
        ld      a, SNAIL_SPRITE_RIGHT
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_DARK_YELLOW
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a
        jp      .continue

.continue:
    exx
    
    ; Place enemy sprite

    ; Get x coord in pixels
    ld      hl, (UpdateBgObjects_PosObjOnBG)
    call    Convert_BgPosition_X_To_X_In_Pixels    
    dec     a                                       ; fix x position (not sure why)
        ; adjust for x offset
        ; EnemyX = EnemyX - xOffset
        ld      c, a
        ld      a, (UpdateBgObjects_X_Offset_Value)
        ld      b, a
        ld      a, c
        sub     b
    ld      (UpdateBgObjects_Enemy_n_X), a


    ; Get Y position (already stored in pixels)
    ld      hl, (UpdateBgObjects_CurrentAddr)
    inc     hl
    inc     hl
    ld      a, (hl)
    dec     a               ; adjust for the Y - 1 TMS 9918 bug/feature
    ld      (UpdateBgObjects_Enemy_n_Y), a


    ; ld      a, SNAIL_SPRITE_LEFT ; LADYBUG_SPRITE_LEFT
    ld      a, (UpdateBgObjects_Enemy_Sprite_Number)
    ld      (UpdateBgObjects_Enemy_n_Pattern), a
    ; ld      a, COLOR_DARK_YELLOW ; COLOR_RED
    ld      a, (UpdateBgObjects_Enemy_Sprite_Color)
    ld      (UpdateBgObjects_Enemy_n_Color), a


    ; Move enemy / check collision only if enemy is alive (it may be on dying animation)
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    cp      2
    jp      nc, .return     ; if (a >= n)



; -------------------- Enemy movement
    ; Change x offset and save it back
    
    ; Move enemy only at each 4 frames
    ; ld      a, (BIOS_JIFFY)                         ; MSX BIOS time variable
    ; and     0000 0011 b                             ; each 4 frames
    ; jp      nz, .continue_xoffset_1

    ; Check 7th bit of enemy type (it stores the direction)
    ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
    ld      a, (hl)
    and     ENEMY_FACING_RIGHT                      ; a little faster than bit 7, a
    jp      nz, .moveEnemyRight
    
    ; Move enemy left
    ld      a, (UpdateBgObjects_X_Offset_Value)
    inc     a
    cp      16                                      ; if (X_Offset == 16) { X_Offset = 0; EnemyColumnPosition--; }
    jp      nz, .saveXoffset_Left
    
    ld      hl, (UpdateBgObjects_CurrentAddr)
    ld      a, (hl)
    dec     a
    ld      (hl), a
    xor     a                                       ; clear UpdateBgObjects_X_Offset_Value
    jp      .saveXoffset_Left

.moveEnemyRight:
    ; Move enemy right
    ld      a, (UpdateBgObjects_X_Offset_Value)
    dec     a
    cp      -1                                      ; if (X_Offset == -1) { X_Offset = 15; EnemyColumnPosition++; }
    jp      nz, .saveXoffset_Right
    
    ld      hl, (UpdateBgObjects_CurrentAddr)
    ld      a, (hl)
    inc     a
    ld      (hl), a
    ld      a, 15

.saveXoffset_Right:
    ld      (UpdateBgObjects_X_Offset_Value), a
    ld      hl, (UpdateBgObjects_CurrentAddr_X_Offset)
    ld      (hl), a
    jp      .continue_xoffset_1

.saveXoffset_Left:
    ld      (UpdateBgObjects_X_Offset_Value), a
    ld      hl, (UpdateBgObjects_CurrentAddr_X_Offset)
    ld      (hl), a

.continue_xoffset_1:
    
    ; ---------------------------------------------

    ; Check collision - penguin jumped over enemy
    ; Player (x + 2, y + 12) - (x + 13, y + 15)
    ; Enemy  (x + 2, y + 6) - (x + 13, y + 7)
    ld      a, (Player_Y)
    inc     a                                   ; small adjust needed (is it because of the y+1 issue of TMS9918?)
    add     12
    ld      c, a
    ld      b, 4                                ; height = 4

    ld      a, (UpdateBgObjects_Enemy_n_Y)
    add     6
    ld      e, a
    ld      d, 2                                ; height = 2

    ; first check vertical collision, saving the next block (130 cycles), plus 57/62 of the subroutine if no collision
    call    CheckCollision_W1xH1_W2xH2_Vertical
    jp      nc, .checkBackground


    ld      a, (Player_X)
    add     2
    ld      b, a
    ld      c, 14                               ; width = 14

    ld      a, (UpdateBgObjects_Enemy_n_X)
    add     2
    ld      d, a
    ld      e, 14                               ; width = 14

    call    CheckCollision_W1xH1_W2xH2_Horizontal
    jp      nc, .checkBackground

    ; if collided, disable enemy
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, 2            ; start enemy dying animation
    ld      (hl), a

    ; start hit flash animation
    ld      a, HIT_FLASH_FIRST_FRAME
    ld      (HitFlash_FrameNumber), a
    ld      a, (Player_Y)
    ld      (HitFlash_Y), a
    ld      a, (Player_X)
    ld      (HitFlash_X), a
    xor     a
    ld      (HitFlash_Counter), a

    ; Start jump (bounce on the enemy)
    call    GameLogic.startJumping

.animateEnemyDying:
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    inc     a
    cp      60
    jp      z, .endAnimationEnemyDying

    ld      (hl), a
    and     0000 0011 b
    jp      z, .showEnemySprite


    ; hide sprite
    xor     a                           ; transparent color
    ld      (UpdateBgObjects_Enemy_n_Color), a
    jp      .return

.showEnemySprite:
    ; show sprite
    ld      a, (UpdateBgObjects_Enemy_Sprite_Color)
    ld      (UpdateBgObjects_Enemy_n_Color), a

    ; and show tiles
    jp      .showEnemySprites

.endAnimationEnemyDying:
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      (hl), 0
    
    ; hide sprite
    xor     a
    ld      (UpdateBgObjects_Enemy_n_Pattern), a
    ld      (UpdateBgObjects_Enemy_n_Color), a
    ld      (UpdateBgObjects_Enemy_n_X), a
    ld      a, 192
    ld      (UpdateBgObjects_Enemy_n_Y), a
    
    jp      .return

;TODO: put this routine in EnemiesCommon
.checkBackground:
    ; Check 7th bit of enemy type (it stores the direction)
    ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
    ld      a, (hl)
    and     ENEMY_FACING_RIGHT                      ; a little faster than bit 7, a
    jp      nz, .checkBackgroundRight

.DISTANCE_TO_WALL_LEFT:      equ 2

    ; Check collision with background left
    ld      a, (UpdateBgObjects_Enemy_n_X)
    cp      8
    jp      c, .changeDirectionToRight             ; if a < 8 (fix bug when enemy is at screen left border)
    sub     .DISTANCE_TO_WALL_LEFT
    ld      h, a
    ld      a, (UpdateBgObjects_Enemy_n_Y)
    add     8
    ld      l, a
    call    CheckBackGround_Left
    jp      nz, .changeDirectionToRight             ;

    ; Check if has empty space under at left
    ld      a, (UpdateBgObjects_Enemy_n_X)
    ;sub     8
    ld      h, a
    ld      a, (UpdateBgObjects_Enemy_n_Y)
    add     24
    ld      l, a
    call    CheckBackGround_Left
    jp      nz, .return                             ; no empty space, then return

.changeDirectionToRight:
    ; Change direction to right
    ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
    ld      a, (hl)
    or      ENEMY_FACING_RIGHT
    ld      (hl), a

    jp      .return

.checkBackgroundRight:

.DISTANCE_TO_WALL_RIGHT:      equ 16 + 1
    ; Check collision with background right
    ld      a, (UpdateBgObjects_Enemy_n_X)
    add     .DISTANCE_TO_WALL_RIGHT
    ld      h, a
    ld      a, (UpdateBgObjects_Enemy_n_Y)
    add     8
    ld      l, a
    call    CheckBackGround_Right
    jp      nz, .changeDirectionToLeft             ;

    ; Check if has empty space under at right
    ld      a, (UpdateBgObjects_Enemy_n_X)
    add     16 + 1
    ld      h, a
    ld      a, (UpdateBgObjects_Enemy_n_Y)
    add     24
    ld      l, a
    call    CheckBackGround_Right
    jp      nz, .return                             ; no empty space, then return

.changeDirectionToLeft:
    ; Change direction to left
    ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
    ld      a, (hl)
    and     0111 1111 b                 ; reset 7th bit
    ld      (hl), a
    jp      .return

.return:

    ; Copy temp variables back to enemy properties
    ld      hl, UpdateBgObjects_Enemy_n_BaseAddress     ; source
    ld      de, (UpdateBgObjects_Enemy_Return_Addr)     ; destiny
    ld      bc, ENEMY_STRUCT_SIZE                       ; size
    ldir                                                ; Copy BC bytes from HL to DE

    
    ; Do not increment counter if enemy is dead
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    or      a
    ret     z

    ld      hl, Enemies_TypeA_Counter
    inc     (hl)

    ret