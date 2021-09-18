LoadLevel:

; CurrentLevel_BgObjectsInitialState_Start:   rw  1
; CurrentLevel_BgObjectsInitialState_Size:    rw  1
; CurrentLevel_TileMap_Start:                 rw  1


    ; TODO: implement routine to load correct level (passed by A register)
    ; Test - loading level info dinamically
    ld      hl, BgObjectsInitialState_LevelTest_Start
    ld      (CurrentLevel_BgObjectsInitialState_Start), hl
    ld      hl, BgObjectsInitialState_LevelTest_End - BgObjectsInitialState_LevelTest_Start
    ld      (CurrentLevel_BgObjectsInitialState_Size), hl
    ld      hl, TileMap_LevelTest_Start
    ld      (CurrentLevel_TileMap_Start), hl






    ; Load level Bg (static blocks)
    ; ld      hl, TileMap_LevelTest_Start
    ld      hl, (CurrentLevel_TileMap_Start)
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
    ld      hl, (CurrentLevel_BgObjectsInitialState_Start)
    ld      de, BgObjects_Start
    ; ld      bc, BgObjectsInitialState_End - BgObjectsInitialState_Start
    ld      bc, (CurrentLevel_BgObjectsInitialState_Size)
    ldir                                    ; copies BC bytes from HL to DE

    ret
