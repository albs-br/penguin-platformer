GameLogic:

;--------------------

    ; [debug]
    ; check if player is at empty space
    ; formula: COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)     (only first 4 rows)
    

    ; b = LINE_NUMBER:
    ld      a, (Player_Y)
    srl     a       ; divide by 8
    srl     a
    srl     a
    ld      c, a
    and     0000 0011 b         ; mask to get only lower 2 bits of line number and make it a line number 0-3
    ld      b, a
    ld      a, c
    and     0001 1100 b         ; mask to get the page number (0-5)
    srl     a                   ; align to right
    srl     a
    inc     a                   ; pages are numbered 1-6, not 0-5
    ld      c, a



    ; hl = (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER
    ld      hl, 0
    jp      z, .continue
    ld      de, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8
.loopMulti:
    add     hl, de
    djnz    .loopMulti
.continue:

    ; de = COL_NUMBER:
    ld      a, (Player_X)
    srl     a       ; divide by 8
    srl     a
    srl     a
    ld      d, 0
    ld      e, a

    ; de = COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)
    add     hl, de
    ex      de, hl


    ; set MegaROM page
    ld      a, c
    ld	    (Seg_P8000_SW), a

    ld      hl, (BgAddrIndex)
    ;ld      de, 2 + (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * 2
    add     hl, de
    ld      a, (hl)
    or      a
    call    z, .playerAtEmptySpace
    call    nz, .playerAtOccupiedSpace

    ld      (Test_sprite_color), a





;--------------------

    call    UpdateSpriteAttrTableBuffer

    ret


.playerAtEmptySpace:
    ld      a, COLOR_RED
    ld      (Test_sprite_color), a
    ret

.playerAtOccupiedSpace:
    ld      a, COLOR_GREEN
    ld      (Test_sprite_color), a
    ret

UpdateSpriteAttrTableBuffer:
    ld      hl, SpriteAttrTableBuffer
    ld      a, (Player_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Player_X)
    ld      (hl), a

    inc     hl
    inc     hl
    ld      a, (Test_sprite_color)
    ld      (hl), a

    ret