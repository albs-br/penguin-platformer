; Input:
;   A: level to be loaded
LoadLevel:

; CurrentLevel_BgObjectsInitialState_Start:   rw  1
; CurrentLevel_BgObjectsInitialState_Size:    rw  1


    cp      1
    jp      z, .load_TestLevel_1
    jp      .load_TestLevel_2

.load_TestLevel_1:
    ld      hl, BgObjectsInitialState_TestLevel_1_Start
    ld      (CurrentLevel_BgObjectsInitialState_Start), hl
    ld      hl, BgObjectsInitialState_TestLevel_1_End - BgObjectsInitialState_TestLevel_1_Start
    ld      (CurrentLevel_BgObjectsInitialState_Size), hl
    ld      a, TEST_LEVEL_1_MEGAROM_PAGE
    ld      (CurrentLevel_InitialMegaRomPage), a
    jp      .continue

.load_TestLevel_2:
    ld      hl, BgObjectsInitialState_TestLevel_2_Start 
    ld      (CurrentLevel_BgObjectsInitialState_Start), hl
    ld      hl, BgObjectsInitialState_TestLevel_2_End - BgObjectsInitialState_TestLevel_2_Start
    ld      (CurrentLevel_BgObjectsInitialState_Size), hl
    ld      a, TEST_LEVEL_2_MEGAROM_PAGE
    ld      (CurrentLevel_InitialMegaRomPage), a
    jp      .continue



.continue:
    ; Load level Bg (static blocks)
    ; ld      hl, TileMap_LevelTest_Start
    ld      hl, 0x8000                          ; all levels are in the same address, only the MegaROM page is different
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
    ; ld      hl, BgObjectsInitialState_Start
    ; TODO: will be necessary a variable for this megarom page,
    ; as only 4 per page are allowed
    ld      a, BG_OBJECTS_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a               ; set MegaROM page for BgObjects

    ld      hl, (CurrentLevel_BgObjectsInitialState_Start)
    ld      de, BgObjects_Start
    ; ld      bc, BgObjectsInitialState_End - BgObjectsInitialState_Start
    ld      bc, (CurrentLevel_BgObjectsInitialState_Size)
    ldir                                    ; copies BC bytes from HL to DE

    ret
