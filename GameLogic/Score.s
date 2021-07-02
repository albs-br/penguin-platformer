Score:

    ; test cycle color
    ld      a, (BIOS_JIFFY)
    and     0001 1100 b                 ; get value between 0-7
    srl     a
    srl     a
    ld      hl, .colorsScoreCycle
    ld      b, 0
    ld      c, a
    add     hl, bc
    ld      a, (hl)
    ld      (ScoreBottom_Color), a



    ; Place Penguin face detail tile on namestable
    ld	    hl, (CurrentNamesTable)
    ld      bc, 0 + (32 * 2) + 2                        ; line: 2, column: 2
    add     hl, bc
    call	BIOS_SETWRT                                 ; Sets the VRAM pointer
    ld	    a, (BIOS_VDP_DW)
    ld	    c, a
    ld      a, TILE_PENGUIN_FACE_DETAILS
    out     (c), a

    ret

.colorsScoreCycle:      ; 8 values
    db      COLOR_WHITE,    COLOR_GREY,         COLOR_LIGHT_BLUE,   COLOR_BLUE, COLOR_DARK_BLUE
    db      COLOR_BLUE,     COLOR_LIGHT_BLUE,   COLOR_GREY