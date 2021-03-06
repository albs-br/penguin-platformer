InitVariables:
    ld      a, (BIOS_JIFFY)                  ; MSX BIOS time variable
    or      0x80                             ; A value different of zero is granted
    ld      (SEED), a

    xor     a
    ld      (BgAddrCurrentIndex), a
    ld      (FrameIndex), a

    ld      (ScrollDirection), a
    
    ld      (KeyPressed), a
    
    ld      (Player_Animation_Frame), a

    ld	    a, 192-32-1
    ld      (Player_Y), a
    ld      a, 128-8
    ld      (Player_X), a
    ld      a, PENGUIN_RIGHT_STANDING
    ld      (Player_Sprite_Number), a


    ; Load level Bg
    ; ld      hl, TileMap_LevelTest_LastLine_Start
    ld      hl, TileMap_LevelTest_Start
    ld      (BgAddrIndex), hl
    ld      (BgAddrIndexFirstFrame), hl


    ; test
    ld	    a, 192-32-1
    ld      (Test_Sprite_Y), a
    ld	    a, 64
    ld      (Test_Sprite_X), a



    ret