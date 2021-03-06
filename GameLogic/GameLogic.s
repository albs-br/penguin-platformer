GameLogic:

;--------------------

    ; [debug]
    ; check if player is at empty space
    ; formula: COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)     (only first 4 rows)
    
    ld      a, (Test_Sprite_X)
    ld      h, a
    ld      a, (Test_Sprite_Y)
    ld      l, a
    call    CheckBackGround
    call    z, .testSpriteAtEmptySpace
    call    nz, .testSpriteAtOccupiedSpace
    ld      (Test_Sprite_Color), a



    ; Penguin animation
;     ld      a, (KeyPressed)
;     or      a
;     jp      z, .noKeyPressed                         ; if (KeyPressed == 0) ?
;     dec     a
;     jp      nz, .keyRightNotPressed                   ; if (KeyPressed == 1) ?

    ;playerRight
    ld      a, (Player_Animation_Frame)
    inc     a
    and     0000 0111 b             ; each n frames
    ld      (Player_Animation_Frame), a
    jp      nz, .keyRightNotPressed

    ld      a, (Player_Sprite_Number)
    cp      PENGUIN_RIGHT_WALKING_LAST_FRAME
    jp      z, .restartWalkingRight           ; if (Player_Sprite_Number == ?) ?
    add     8                                 ; next frame
    jp      .savePlayerFrame
.restartWalkingRight:
    ld      a, PENGUIN_RIGHT_WALKING_1
.savePlayerFrame:
    ld      (Player_Sprite_Number), a

.keyRightNotPressed:

;--------------------

    call    UpdateSpriteAttrTableBuffer

    ret


.testSpriteAtEmptySpace:
    ld      a, COLOR_RED
    ld      (Test_Sprite_Color), a
    ret

.testSpriteAtOccupiedSpace:
    ld      a, COLOR_GREEN
    ld      (Test_Sprite_Color), a
    ret

UpdateSpriteAttrTableBuffer:
    ld      hl, SpriteAttrTableBuffer

    ; Sprite # 0
    ld      a, (Test_Sprite_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Test_Sprite_X)
    ld      (hl), a

    inc     hl
    inc     hl
    ld      a, (Test_Sprite_Color)
    ld      (hl), a

    ; Sprite # 1
    inc     hl
    ld      a, (Player_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Player_X)
    ld      (hl), a

    inc     hl
    ld      a, (Player_Sprite_Number)
    ld      (hl), a

    inc     hl
    ld      a, COLOR_DARK_BLUE
    ld      (hl), a

    ; Sprite # 2
    inc     hl
    ld      a, (Player_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Player_X)
    ld      (hl), a

    inc     hl
    ld      a, (Player_Sprite_Number)
    add     4
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ret


; Checks if a given XY coord is over a blank tile
;   Inputs:
;       H: x coordinate (0-255)
;       L: y coordinate (0-191)
;   Output:
;       z: is at empty space
;       nz: is not at empty space
CheckBackGround:
    push    hl                  ; save h (x coord)

    ; b = LINE_NUMBER:
    ld      a, l
    srl     a                   ; divide by 8
    srl     a
    srl     a
    ld      c, a
    and     0000 0011 b         ; mask to get only lower 2 bits of line number and make it a line number 0-3
    ld      b, a
    

    ; hl = (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER
    ld      hl, 0
    jp      z, .continue
    ld      de, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8
.loopMulti:
    add     hl, de
    djnz    .loopMulti
.continue:

    ; de = COL_NUMBER:
    pop     af                  ; restore h (x coord)
    ;ld      a, d
    srl     a                   ; divide by 8
    srl     a
    srl     a
    ld      d, 0
    ld      e, a

    ; de = COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)
    add     hl, de
    ex      de, hl


    ; set MegaROM page
    ; c = MegaROM Page number
    ld      a, c
    and     0001 1100 b         ; mask to get the page number (0-5)
    srl     a                   ; align to right
    srl     a
    inc     a                   ; pages are numbered 1-6, not 0-5
    ; ld      c, a
    ; ld      a, c
    ld	    (Seg_P8000_SW), a

    ld      hl, (BgAddrIndex)
    ;ld      de, 2 + (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * 2
    add     hl, de
    ld      a, (hl)
    or      a
    
    ret