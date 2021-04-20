InitVariables:
    ld      a, (BIOS_JIFFY)                  ; MSX BIOS time variable
    or      0x80                             ; A value different of zero is granted
    ld      (SEED), a

    ld      hl, 0
    ld      (BgCurrentIndex), hl

    ld      a, 0
    ld      (FrameIndex), a

    
    
    ld      a, 1
    ld      (ScrollSpeed), a

    xor     a
    ld      (ScrollDirection), a
    
    ld      (DirectionKeyPressed), a
    ld      (JumpKeyPressed), a
    ld      (RunKeyPressed), a
    
    ld      (Player_Animation_Frame), a
    ld      (Player_JumpCounter), a

    ld	    a, 192-48-1
    ld      (Player_Y), a
    ld      a, 128-8
    ld      (Player_X), a
    ld      a, PENGUIN_RIGHT_STANDING
    ld      (Player_Sprite_Number), a

    ld      a, 1
    ld      (Player_IsAlive), a
    ld      (Player_IsGrounded), a


    ; Load level Bg
    ; ld      hl, TileMap_LevelTest_LastLine_Start
    ld      hl, TileMap_LevelTest_Start
    ld      (BgAddrIndex), hl
    ld      (BgAddrIndexFirstFrame), hl



    ; Load bg objects initial state
    ld      hl, BgObjectsInitialState_Start
    ld      de, BgObjects_Start
    ld      bc, BgObjectsInitialState_End - BgObjectsInitialState_Start
    ldir                                    ; copies BC bytes from HL to DE


    ; Animation for sparkles
    xor     a
    ld      (Sparkles_Counter), a
    ld      (Sparkles_FrameNumber), a
    ld      (Sparkles_X), a
    ld      a, 192
    ld      (Sparkles_Y), a



    ; test
    ; ld	    a, 192-32-1
    ; ld      (Test_Sprite_Y), a
    ; ld	    a, 64
    ; ld      (Test_Sprite_X), a



    ret