Scenery_Logic:

    ; call    .enemiesCounterRoutine

; TEST (this should be changed by a logic like "enemiesCounterRoutine"
; if more than one scenery per screen will be used)
    ld      hl, Scenery_1_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl



    ; Copy scenery properties to temp variables
    ld      hl, (UpdateBgObjects_Enemy_Return_Addr)             ; source
    ld      de, UpdateBgObjects_Scenery_n_BaseAddress           ; destiny
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



	exx
        ; Switch scenery type
        ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
        ld      a, (hl)
        
        cp      SCENERY_TYPE_BUSH
        jp      z, .sceneryBush

        cp      SCENERY_TYPE_FENCE
        jp      z, .sceneryFence

.sceneryBush:
        ld      a, SCENERY_SPRITE
        ld      (UpdateBgObjects_Scenery_n_1st_Sprite_Pattern), a
        ; ld      a, ENEMY_TYPE_B_1_2ND_SPRITE_LEFT ; TODO
        ; ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Pattern), a
        ; ld      a, ENEMY_TYPE_B_1_3RD_SPRITE_LEFT
        ; ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Pattern), a

        call    .loadSceneryBushSprite

        jp      .continue

.sceneryFence:
        ld      a, SCENERY_SPRITE
        ld      (UpdateBgObjects_Scenery_n_1st_Sprite_Pattern), a
        ; ld      a, ENEMY_TYPE_B_1_2ND_SPRITE_LEFT ; TODO
        ; ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Pattern), a
        ; ld      a, ENEMY_TYPE_B_1_3RD_SPRITE_LEFT
        ; ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Pattern), a

        call    .loadSceneryFenceSprite

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

;ld a, 128; //[debug]
    ld      (UpdateBgObjects_Scenery_n_X), a


    ; Get Y position (already stored in pixels)
    ld      hl, (UpdateBgObjects_CurrentAddr)
    inc     hl
    inc     hl
    ld      a, (hl)
    dec     a               ; adjust for the Y - 1 TMS 9918 bug/feature

;ld a, 128; //[debug]
    ld      (UpdateBgObjects_Scenery_n_Y), a
;     inc     hl
;     inc     hl
;     inc     hl
;     inc     hl
;     ld      a, (hl)
;     dec     a               ; adjust for the Y - 1 TMS 9918 bug/feature
; ld a, 128+16; //[debug]
;     ld      (UpdateBgObjects_Scenery_n_Y), a
;     inc     hl
;     ld      a, (hl)
;     dec     a               ; adjust for the Y - 1 TMS 9918 bug/feature
; ld a, 128+32; //[debug]
;     ld      (UpdateBgObjects_Scenery_n_Y), a

.skipCopyPattern:

.continue_xoffset_1:
    
    jp      .return

.return:

    ; Copy temp variables back to object properties
    ld      hl, UpdateBgObjects_Scenery_n_BaseAddress       ; source
    ld      de, (UpdateBgObjects_Enemy_Return_Addr)         ; destiny
    ld      bc, SCENERY_STRUCT_SIZE                         ; size
    ldir                                                    ; Copy BC bytes from HL to DE

    
    ; ; Do not increment counter if enemy is dead
    ; ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ; ld      a, (hl)
    ; or      a
    ; ret     z

    ; ld      hl, Enemies_TypeB_Counter
    ; inc     (hl)

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
    ; Load colors
    ld      a, COLOR_LIGHT_GREEN
    ld      (UpdateBgObjects_Scenery_n_1st_Sprite_Color), a
    ; ld      a, COLOR_LIGHT_RED ; TODO
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Color), a
    ; ld      a, COLOR_YELLOW; TODO
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Color), a

    ; Check if sprite patterns are already loaded
    ld      a, (Scenery_1_CurrentSpriteLoaded)
    cp      SCENERY_TYPE_BUSH
    ret     z

    ; Switch to MegaROM page where the sprites are located
    ld      a, SPRITES_ENEMY_TYPE_B_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a

    ; If not, then load ARMADILLO sprite pattern at enemy type B FIRST position
    ld      hl, Bush_SpritePatterns                                                 ; Source on RAM
    ld      de, SCENERY_SPRITE_ADDR_VRAM                                            ; Destiny on VRAM
    ld      bc, 32 * 1                                                              ; Size
    call 	fast_LDIRVM        							                            ; Block transfer to VRAM from memory

    ; Save flag indicating sprite loaded
    ld      a, SCENERY_TYPE_BUSH
    ld      (Scenery_1_CurrentSpriteLoaded), a

    ret

.loadSceneryFenceSprite:
    ; Load colors
    ld      a, COLOR_DARK_RED
    ld      (UpdateBgObjects_Scenery_n_1st_Sprite_Color), a
    ; ld      a, COLOR_LIGHT_RED ; TODO
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Color), a
    ; ld      a, COLOR_YELLOW; TODO
    ; ld      (UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Color), a

    ; Check if sprite patterns are already loaded
    ld      a, (Scenery_1_CurrentSpriteLoaded)
    cp      SCENERY_TYPE_FENCE
    ret     z

    ; Switch to MegaROM page where the sprites are located
    ld      a, SPRITES_ENEMY_TYPE_B_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a

    ; If not, then load ARMADILLO sprite pattern at enemy type B FIRST position
    ld      hl, Fence_SpritePatterns                                                ; Source on RAM
    ld      de, SCENERY_SPRITE_ADDR_VRAM                                            ; Destiny on VRAM
    ld      bc, 32 * 1                                                              ; Size
    call 	fast_LDIRVM        							                            ; Block transfer to VRAM from memory

    ; Save flag indicating sprite loaded
    ld      a, SCENERY_TYPE_FENCE
    ld      (Scenery_1_CurrentSpriteLoaded), a

    ret
