EnemyLogic:
    TILE_POSITION_ON_NAMTBL:    equ 217
    VRAM_PATTERN_TABLE_ADDR:    equ PatternsTable_3rd_Third + (TILE_POSITION_ON_NAMTBL * 8)
    VRAM_COLORS_TABLE_ADDR:     equ ColorsTable_3rd_Third + (TILE_POSITION_ON_NAMTBL * 8)


;     ; x offset
;     inc     hl
;     ld      a, (hl)
;     or      a   ; if (xOffset == 0) xOffset = 15
;     jp      nz, .saveXOffset
;     ld      a, 16
; .saveXOffset:
;     dec     a
;     ld      (hl), a
;     and     0000 0111 b     ; test (mask to get only 0-7)
;     ld      (UpdateBgObjects_X_Offset_Value), a
;     dec     hl

;     ; xOffset:
;     ;   0-7: add it to frame index
;     ;   8-15: UpdateBgObjects_VRAMAddr++ ;ccx xxxOffset -= 8 ; add it to frame index


        ; ld      b, a
        ; ld      a, (UpdateBgObjects_X_Offset_Value)         ; add it to xoffset and draw on screen
        ; add     b



    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    inc     hl
    inc     hl
    ld      (UpdateBgObjects_CurrentAddr_EnemyType), hl


    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    cp      2
    jp      nc, .animateEnemyDying        ; a >= n

.showEnemyTiles:
	exx
        ; switch enemy type
        ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
        ld      a, (hl)
        cp      ENEMY_TYPE_LADYBUG_LEFT
        jp      z, .enemyTypeLadybugLeft
        cp      ENEMY_TYPE_SNAIL_LEFT
        jp      z, .enemyTypeSnailLeft

.enemyTypeLadybugLeft:
        ld      a, LADYBUG_SPRITE_LEFT
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_RED
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a

        ld      hl, TileColors_EnemyLadybug_Top_Start
        ld      (UpdateBgObjects_Enemy_Color_Addr), hl
        
        ld      hl, TilePatterns_Enemy_Ladybug_Start
        jp      .continue

.enemyTypeSnailLeft:
        ld      a, SNAIL_SPRITE_LEFT
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_DARK_YELLOW
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a

        ld      hl, TileColors_EnemySnail_Top_Start
        ld      (UpdateBgObjects_Enemy_Color_Addr), hl
        
        ld      hl, TilePatterns_Enemy_Snail_Start
        ; jp      .continue

.continue:
        ; ------------ Update patterns table  ------------
        ; set pointer to copy pattern data of enemy to VRAM
        
        ; HL = TilePatterns_Enemy_Ladybug_Start + (FrameIndex * (6 * 8))
        ;ld		hl, TilePatterns_Enemy_Snail_Start ; TilePatterns_Enemy_Ladybug_Start	                                ; RAM address
        ld      a, (FrameIndex)
        or      a
        jp      z, .noMult

        sla     a           ; multiply by 8
        sla     a
        sla     a

        ld      b, a
        ld      de, 6       ; multiply by 6
.multLoop:
        add     hl, de
        djnz    .multLoop
.noMult:

        ; save enemy pattern address
        ld      (UpdateBgObjects_Enemy_1_Pattern_Addr), hl
        


        ; ------------ Update colors table  ------------
        ; copy color data of enemy to VRAM
        ld		bc, 8 * 6   ; Block length
        ld		de, VRAM_COLORS_TABLE_ADDR						                        ; VRAM address
        ;ld		hl, TileColors_EnemySnail_Top_Start ; TileColors_EnemyLadybug_Top_Start	                                ; RAM address
        ld      hl, (UpdateBgObjects_Enemy_Color_Addr)                                  ; RAM address
        call 	fast_LDIRVM        							                            ; Block transfer to VRAM from memory
    exx

    ; ------------ Update names table  ------------
    ld      hl, (UpdateBgObjects_VRAMAddr)
	call    BIOS_SETWRT

    ; top left
    ld      a, TILE_POSITION_ON_NAMTBL ;DIAMOND_FIRST_TILE
    out     (c), a

    ; top center
    inc     a
    nop
    nop
    out     (c), a

    ; top right
    inc     a
    nop
    nop
    out     (c), a
    
    ld      b, a
    exx
        ld      hl, (UpdateBgObjects_VRAMAddr)
        ld      bc, 32
        add     hl, bc
        call    BIOS_SETWRT
    exx
    ld      a, b

    ; bottom left
    inc     a
    out     (c), a

    ; bottom center
    inc     a
    nop
    nop
    out     (c), a

    ; bottom right
    inc     a
    nop
    nop
    out     (c), a


    ; Place enemy sprite

    ; Get x coord in pixels
    ld      hl, (UpdateBgObjects_PosObjOnBG)
    call    Convert_BgPosition_X_To_X_In_Pixels    
    dec     a                                       ; fix x position (not sure why)
    ld      (Enemy_1_X), a


    ; Get Y position (already stored in pixels)
    ld      hl, (UpdateBgObjects_CurrentAddr)
    inc     hl
    inc     hl
    ld      a, (hl)
    dec     a               ; adjust for the Y - 1 TMS 9918 bug/feature
    ld      (Enemy_1_Y), a


    ; ld      a, SNAIL_SPRITE_LEFT ; LADYBUG_SPRITE_LEFT
    ld      a, (UpdateBgObjects_Enemy_Sprite_Number)
    ld      (Enemy_1_Pattern), a
    ; ld      a, COLOR_DARK_YELLOW ; COLOR_RED
    ld      a, (UpdateBgObjects_Enemy_Sprite_Color)
    ld      (Enemy_1_Color), a


    ; Check collision only if enemy is alive (it may be on dying animation)
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    cp      2
    ret     nc              ; if (a >= n)


    ; Check collision - penguin jumped over enemy
    ; Player (x + 2, y + 12) - (x + 13, y + 15)
    ; Enemy  (x + 2, y + 6) - (x + 13, y + 7)
    ld      a, (Player_Y)
    inc     a                                   ; small adjust needed (is it because of the y+1 issue of TMS9918?)
    add     12
    ld      c, a
    ld      b, 4                                ; height = 4

    ld      a, (Enemy_1_Y)
    add     6
    ld      e, a
    ld      d, 2                                ; height = 2

    ; first check vertical collision, saving the next block (130 cycles), plus 57/62 of the subroutine if no collision
    call    CheckCollision_W1xH1_W2xH2_Vertical
    ret     nc


    ld      a, (Player_X)
    add     2
    ld      b, a
    ld      c, 14                               ; width = 14

    ld      a, (Enemy_1_X)
    add     2
    ld      d, a
    ld      e, 14                               ; width = 14

    call    CheckCollision_W1xH1_W2xH2_Horizontal
    ret     nc

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
    ld      a, 1
    ld      (Player_JumpCounter), a

.animateEnemyDying:
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    inc     a
    cp      60
    jp      z, .endAnimationEnemyDying

    ld      (hl), a

    and     0000 0011 b
    jp      z, .showEnemySprite

    ; odd frame, hide sprite
    xor     a                           ; transparent color
    ld      (Enemy_1_Color), a
    ret

.showEnemySprite:
    ; show sprite
    ld      a, COLOR_RED
    ld      (Enemy_1_Color), a

    ; and show tiles
    jp      .showEnemyTiles

    ;ret

.endAnimationEnemyDying:
    xor     a
    ld      (UpdateBgObjects_CurrentAddr_State), a
    
    ; hide sprite
    xor     a
    ld      (Enemy_1_Pattern), a
    ld      (Enemy_1_Color), a
    ld      (Enemy_1_X), a
    ld      a, 192
    ld      (Enemy_1_Y), a
    
    ret