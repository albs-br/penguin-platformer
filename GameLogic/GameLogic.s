GameLogic:

    ; ld      hl, X
    ; inc     (hl)


;--------------------

    ; [debug]
    ; check if player is at empty space
    ; formula: COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)     (only first 4 rows)
    

    ; b = LINE_NUMBER - 1:
    ld      a, (Player_Y)
    srl     a       ; divide by 8
    srl     a
    srl     a
    ld      b, a
    or      a ; unecessary?
    jp      z, .hl_set_to_0     ; LINE_NUMBER = 0
    dec     b

    ; hl = (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8)
    ld      hl, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8
    ld      a, b
    or      a
    jp      z, .continue        ; LINE_NUMBER = 1

    ; hl = (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER
    ld      d, h
    ld      e, l
.loopMulti:
    add     hl, de
    djnz    .loopMulti
    jp      .continue
.hl_set_to_0:
    ld      hl, 0
.continue:

    ; bc = COL_NUMBER:
    ld      a, (Player_X)
    srl     a       ; divide by 8
    srl     a
    srl     a
    ld      b, 0
    ld      c, a

    ; bc = COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)
    add     hl, bc
    ld      b, h
    ld      c, l


    ; set MegaROM initial page
    ld      a, 1 
    ld	    (Seg_P8000_SW), a

    ld      hl, (BgAddrIndex)
    ;ld      bc, 2 + (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * 2
    add     hl, bc
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