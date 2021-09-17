LoadLevel:
    ; Load level Bg (static blocks)
    ; ld      hl, TileMap_LevelTest_LastLine_Start
    ld      hl, TileMap_LevelTest_Start
    ld      (BgAddrIndex), hl
    ld      (BgAddrIndexFirstFrame), hl


    ; Fill with zeroes the BgObjects_Start RAM area
    ld      hl, BgObjects_Start         ; RAM start address
    ld      de, BgObjects_Start.end     ; RAM end address
.loop:
    xor     a                   ; same as ld a, 0, but faster
    ld      (hl), a
    inc     hl
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nz, .loop


    ; Load bg dynamic objects (like diamonds) initial state
    ld      hl, BgObjectsInitialState_Start
    ld      de, BgObjects_Start
    ld      bc, BgObjectsInitialState_End - BgObjectsInitialState_Start
    ldir                                    ; copies BC bytes from HL to DE

    ret
