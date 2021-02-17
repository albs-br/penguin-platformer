InitVariables:
    ld      a, (BIOS_JIFFY)                  ; MSX BIOS time variable
    or      0x80                             ; A value different of zero is granted
    ld      (SEED), a

    xor     a
    ld      (BgCurrentIndex), a
    ld      (FrameIndex), a

    ; ld      hl, TileMap_LevelTest_LastLine_Start
    ld      hl, TileMap_LevelTest_Start
    ld      (BgIndex), hl
    ld      (BgIndexFirstFrame), hl

    ret