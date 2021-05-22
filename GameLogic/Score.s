Score:
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