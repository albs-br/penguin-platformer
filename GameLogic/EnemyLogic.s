EnemyLogic:
    TILE_POSITION_ON_NAMTBL_ENEMY_1:    equ 217
    VRAM_PATTERN_TABLE_ADDR_ENEMY_1:    equ PatternsTable_3rd_Third + (TILE_POSITION_ON_NAMTBL_ENEMY_1 * 8)
    VRAM_COLORS_TABLE_ADDR_ENEMY_1:     equ ColorsTable_3rd_Third + (TILE_POSITION_ON_NAMTBL_ENEMY_1 * 8)


    TILE_POSITION_ON_NAMTBL_ENEMY_2:    equ TILE_POSITION_ON_NAMTBL_ENEMY_1 + 6
    VRAM_PATTERN_TABLE_ADDR_ENEMY_2:    equ PatternsTable_3rd_Third + (TILE_POSITION_ON_NAMTBL_ENEMY_2 * 8)
    VRAM_COLORS_TABLE_ADDR_ENEMY_2:     equ ColorsTable_3rd_Third + (TILE_POSITION_ON_NAMTBL_ENEMY_2 * 8)


    ;
    ld      a, (Enemies_Counter)
    cp      2
    jp      z, .enemy_3
    cp      1
    jp      z, .enemy_2
; enemy 1
    ld      a, TILE_POSITION_ON_NAMTBL_ENEMY_1
    ld      (UpdateBgObjects_VRAM_NamesTable_Position), a
    ld      hl, VRAM_COLORS_TABLE_ADDR_ENEMY_1
    ld      (UpdateBgObjects_VRAM_ColorsTable_Addr), hl
    ld      hl, Enemy_1_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl
    
    jp      .copyEnemyPropertiesToTempVars
.enemy_3:
    
    jp      .copyEnemyPropertiesToTempVars
.enemy_2:
    ld      a, TILE_POSITION_ON_NAMTBL_ENEMY_2
    ld      (UpdateBgObjects_VRAM_NamesTable_Position), a
    ld      hl, VRAM_COLORS_TABLE_ADDR_ENEMY_2
    ld      (UpdateBgObjects_VRAM_ColorsTable_Addr), hl
    ld      hl, Enemy_2_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl

.copyEnemyPropertiesToTempVars:


    ; Copy enemy properties to temp variables
    ;ld      hl, Enemy_1_BaseAddress                     ; source
    ld      hl, (UpdateBgObjects_Enemy_Return_Addr)
    ld      de, UpdateBgObjects_Enemy_n_BaseAddress     ; destiny
    ld      bc, ENEMY_STRUCT_SIZE                       ; size
    ldir                                                ; Copy BC bytes from HL to DE

    ; set VDP port for OUT command
    ld	    a, (BIOS_VDP_DW)
    ld	    c, a


    ld      hl, (UpdateBgObjects_CurrentAddr_State)

    inc     hl
    ld      (UpdateBgObjects_CurrentAddr_X_Offset), hl
    ld      a, (hl)
    ld      (UpdateBgObjects_X_Offset_Value), a

    inc     hl
    ld      (UpdateBgObjects_CurrentAddr_EnemyType), hl



    ; --------------- To deal with x offset (movement of the enemy)

    ; A = FrameIndex + UpdateBgObjects_X_Offset_Value
    ld      a, (UpdateBgObjects_X_Offset_Value)
    ld      b, a
    ld      a, (FrameIndex)
    add     b

    ; if (a >= 0 && a <= 7)
    cp      8
    jp      c, .between_0_and_7                 ; if (a < n)
    ; else if (a >= 8 && a <= 15)
    cp      16
    jp      c, .between_8_and_15                ; if (a < n)
    ; else if (a >= 16)
    cp      16
    jp      nc, .greaterThan_16                 ; if (a >= n)
.between_0_and_7:
    ; do nothing
    ld      (UpdateBgObjects_FrameIndex_Enemy), a
    jp      .continue_xoffset

.between_8_and_15:
    ; FrameIndex -= 8
    sub     8
    ld      (UpdateBgObjects_FrameIndex_Enemy), a
    ; NameTable_Addr--
    ld      hl, UpdateBgObjects_NameTable_Addr
    dec     (hl)
    jp      .continue_xoffset

.greaterThan_16:
    ; FrameIndex -= 16
    sub     16
    ld      (UpdateBgObjects_FrameIndex_Enemy), a
    ; NameTable_Addr -= 2
    ld      hl, UpdateBgObjects_NameTable_Addr
    dec     (hl)
    dec     (hl)

.continue_xoffset:

    ; Check if enemy is dying (show animation and not move)
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    cp      2
    jp      nc, .animateEnemyDying        ; a >= n



    ; Change x offset and save it back
    
    ; Move enemy only at each 4 frames (causing bug)
    ;ld      a, (BIOS_JIFFY)                         ; MSX BIOS time variable
    ;and     0000 0011 b                             ; each 4 frames
    ;jp      nz, .continue_xoffset_1

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

    inc     a               ; correct x position (because of the two 
    and     0000 1111 b     ; name tables we are seeing previous tiles)
    ld      (UpdateBgObjects_X_Offset_Value_Adjusted), a
    jp      .continue_xoffset_1

.saveXoffset_Left:
    ld      (UpdateBgObjects_X_Offset_Value), a
    ld      hl, (UpdateBgObjects_CurrentAddr_X_Offset)
    ld      (hl), a

    dec     a               ; correct x position (because of the two 
    and     0000 1111 b     ; name tables we are seeing previous tiles)
    ld      (UpdateBgObjects_X_Offset_Value_Adjusted), a

.continue_xoffset_1:
    
    ; ---------------------------------------------




.showEnemyTiles:
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
        ld      a, LADYBUG_SPRITE_LEFT
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_RED
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a

        ld      hl, TileColors_EnemyLadybug_Top_Start
        ld      (UpdateBgObjects_Enemy_Color_Addr), hl
        
        ld      hl, TilePatterns_Enemy_Ladybug_Left_Start
        jp      .continue

.enemyTypeLadybugRight:
        ld      a, LADYBUG_SPRITE_RIGHT
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_RED
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a

        ld      hl, TileColors_EnemyLadybug_Top_Start
        ld      (UpdateBgObjects_Enemy_Color_Addr), hl
        
        ld      hl, TilePatterns_Enemy_Ladybug_Right_Start
        jp      .continue

.enemyTypeSnailLeft:
        ld      a, SNAIL_SPRITE_LEFT
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_DARK_YELLOW
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a

        ld      hl, TileColors_EnemySnail_Top_Start
        ld      (UpdateBgObjects_Enemy_Color_Addr), hl
        
        ld      hl, TilePatterns_Enemy_Snail_Left_Start
        jp      .continue

.enemyTypeSnailRight:
        ld      a, SNAIL_SPRITE_RIGHT
        ld      (UpdateBgObjects_Enemy_Sprite_Number), a

        ld      a, COLOR_DARK_YELLOW
        ld      (UpdateBgObjects_Enemy_Sprite_Color), a

        ld      hl, TileColors_EnemySnail_Top_Start
        ld      (UpdateBgObjects_Enemy_Color_Addr), hl
        
        ld      hl, TilePatterns_Enemy_Snail_Right_Start
        jp      .continue

.continue:
        ; ------------ Update patterns table  ------------
        ; set pointer to copy pattern data of enemy to VRAM
        
        ; HL = TilePatterns_Enemy_Ladybug_Start + (FrameIndex * (6 * 8))
        ;ld		hl, TilePatterns_Enemy_Snail_Start ; TilePatterns_Enemy_Ladybug_Start	                                ; RAM address
        ld      a, (UpdateBgObjects_FrameIndex_Enemy)
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
        ld      (UpdateBgObjects_Enemy_n_Pattern_Addr), hl
        


        ; ------------ Update colors table  ------------
        ; copy color data of enemy to VRAM
        ld		bc, 8 * 6   ; Block length
        ;ld		de, VRAM_COLORS_TABLE_ADDR						                        ; VRAM address
        ld		de, (UpdateBgObjects_VRAM_ColorsTable_Addr)						    ; VRAM address
        
        ;ld		hl, TileColors_EnemySnail_Top_Start ; TileColors_EnemyLadybug_Top_Start	                                ; RAM address
        ld      hl, (UpdateBgObjects_Enemy_Color_Addr)                                  ; RAM address
        call 	fast_LDIRVM        							                            ; Block transfer to VRAM from memory
    exx

    ; ------------ Update names table  ------------
    ld      hl, (UpdateBgObjects_NameTable_Addr)
	call    BIOS_SETWRT

    ; top left
    ;ld      a, TILE_POSITION_ON_NAMTBL_ENEMY_1 ;DIAMOND_FIRST_TILE
    ld      a, (UpdateBgObjects_VRAM_NamesTable_Position)
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
        ld      hl, (UpdateBgObjects_NameTable_Addr)
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
        ; adjust for x offset
        ld      c, a
        ld      a, (UpdateBgObjects_X_Offset_Value_Adjusted)

        ; dec     a               ; correct x position (because of the two 
        ; and     0000 1111 b     ; name tables we are seeing previous tiles)

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


    ; Check collision only if enemy is alive (it may be on dying animation)
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    cp      2
    ;ret     nc              ; if (a >= n)
    jp      nc, .return     ; if (a >= n)


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
    ;ret     nc
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
    ;ret     nc
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
    ld      (UpdateBgObjects_Enemy_n_Color), a
    ;ret
    jp      .return

.showEnemySprite:
    ; show sprite
    ld      a, (UpdateBgObjects_Enemy_Sprite_Color)
    ld      (UpdateBgObjects_Enemy_n_Color), a

    ; and show tiles
    jp      .showEnemyTiles

    ;ret

.endAnimationEnemyDying:
    xor     a
    ld      (UpdateBgObjects_CurrentAddr_State), a
    
    ; hide sprite
    xor     a
    ld      (UpdateBgObjects_Enemy_n_Pattern), a
    ld      (UpdateBgObjects_Enemy_n_Color), a
    ld      (UpdateBgObjects_Enemy_n_X), a
    ld      a, 192
    ld      (UpdateBgObjects_Enemy_n_Y), a
    
    ;ret
    jp      .return

.checkBackground:
    ; Check 7th bit of enemy type (it stores the direction)
    ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
    ld      a, (hl)
    and     ENEMY_FACING_RIGHT                      ; a little faster than bit 7, a
    jp      nz, .checkBackgroundRight

    ; Check collision with background left
    ld      a, (UpdateBgObjects_Enemy_n_X)
    sub     8
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
    ;ret     nz                                      ; no empty space, then return
    jp      nz, .return                             ; no empty space, then return

.changeDirectionToRight:
    ; Change direction to right
    ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
    ld      a, (hl)
    or      ENEMY_FACING_RIGHT
    ld      (hl), a

    ;ret
    jp      .return

.checkBackgroundRight:
    ; Check collision with background right
    ld      a, (UpdateBgObjects_Enemy_n_X)
    add     24 + 1
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
    ;ret     nz                                      ; no empty space, then return
    jp      nz, .return                             ; no empty space, then return

.changeDirectionToLeft:
    ; Change direction to left
    ld      hl, (UpdateBgObjects_CurrentAddr_EnemyType)
    ld      a, (hl)
    and     0111 1111 b                 ; reset 7th bit
    ld      (hl), a
    ;ret
    jp      .return

.return:
    ld      de, (UpdateBgObjects_Enemy_Return_Addr)

    ; Copy temp variables back to enemy properties
    ld      hl, UpdateBgObjects_Enemy_n_BaseAddress     ; source
    ;ld      de, Enemy_1_BaseAddress                     ; destiny
    ld      bc, ENEMY_STRUCT_SIZE                       ; size
    ldir                                                ; Copy BC bytes from HL to DE

    
    ; Do not increment counter if enemy is dead
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    or      a
    ret     z

    ld      hl, Enemies_Counter
    inc     (hl)

    ret