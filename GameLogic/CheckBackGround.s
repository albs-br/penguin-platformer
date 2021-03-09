
; Checks if a given XY coord is over a blank tile
;   Inputs:
;       H: x coordinate (0-255)
;       L: y coordinate (0-191)
;   Output:
;       z: is at empty space
;       nz: is not at empty space
CheckBackGround:
    ; check if player is at empty space
    ; formula: COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)     (only first 4 rows)

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