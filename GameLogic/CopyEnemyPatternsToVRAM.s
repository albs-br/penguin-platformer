CopyEnemyPatternsToVRAM:
    ; Get enemy 1 pattern address and spit it to VRAM
    ld      hl, (UpdateBgObjects_Enemy_1_Pattern_Addr)
    ld      a, h
    or      l
    jp      z, .skipEnemy_1                             ; if no enemy, skip copying patterns
    ex      de, hl
        ld	    hl, VRAM_PATTERN_TABLE_ADDR
        call	BIOS_SETWRT                                 ; Sets the VRAM pointer
    ex      de, hl
    ld	    a, (BIOS_VDP_DW)
    ld	    c, a
    ; Uses 6 * 8 = 48 OUTIs to copy the 6 tiles from ROM to VRAM
    ; Unrolled OUTIs (use only during v-blank)
    OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI 
    OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI 
.skipEnemy_1:

    ret