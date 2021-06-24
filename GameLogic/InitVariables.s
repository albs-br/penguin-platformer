InitVariables:
    ld      a, (BIOS_JIFFY)                  ; MSX BIOS time variable
    or      0x80                             ; A value different of zero is granted
    ld      (Seed), a


    ; Writing to Names Table 2 while showing Names Table 1
    call    SetNameTable_1
    ld      hl, NamesTable_2
    ld      (CurrentNamesTable), hl


    ld      hl, 0
    ld      (BgCurrentIndex), hl

    xor     a
    ld      (IsProcessingFrame), a
    ld      (HasFrameSkiped), a
    ld      (FrameIndex), a

    
    
    ld      a, 1
    ld      (ScrollSpeed), a

    xor     a
    ld      (ScrollDirection), a
    
    ld      (DirectionKeyPressed), a
    ld      (JumpKeyPressed), a
    ld      (RunKeyPressed), a
    
    ld      (Player_Animation_Frame), a
    ld      (Player_IsJumping), a

    ld	    a, 192-48-1
    ld      (Player_Y), a
    ld      a, 128-8
    ld      (Player_X), a
    ld      a, PENGUIN_RIGHT_STANDING
    ld      (Player_Sprite_Number), a

    ld      a, 1
    ld      (Player_IsAlive), a
    ld      (Player_IsGrounded), a

    ld      a, DIRECTION_RIGHT
    ld      (Player_Facing), a


; ----------------------------------------------------------------------------
; ------------ Background ------------

    ; Load level Bg (static blocks)
    ; ld      hl, TileMap_LevelTest_LastLine_Start
    ld      hl, TileMap_LevelTest_Start
    ld      (BgAddrIndex), hl
    ld      (BgAddrIndexFirstFrame), hl



    ; Load bg dynamic objects (like diamonds) initial state
    ld      hl, BgObjectsInitialState_Start
    ld      de, BgObjects_Start
    ld      bc, BgObjectsInitialState_End - BgObjectsInitialState_Start
    ldir                                    ; copies BC bytes from HL to DE


; ----------------------------------------------------------------------------


    ; Animation for sparkles
    xor     a
    ld      (Sparkles_Counter), a
    ld      (Sparkles_FrameNumber), a
    ld      (Sparkles_X), a
    ld      a, 192
    ld      (Sparkles_Y), a


    ; Animation for hit flash
    xor     a
    ld      (HitFlash_Counter), a
    ld      (HitFlash_FrameNumber), a
    ld      (HitFlash_X), a
    ld      a, 192
    ld      (HitFlash_Y), a


    ; Sprites for enemies
    call    InitEnemiesVariables

    ; test [debug]
    ; ld	    a, 192-32-1
    ; ld      (Test_Sprite_Y), a
    ; ld	    a, 64
    ; ld      (Test_Sprite_X), a



    ret


InitEnemiesVariables:
    ld      hl, 0
    ld      (Enemy_1_RAM_Pattern_Addr), hl
    ld      (Enemy_2_RAM_Pattern_Addr), hl
    ld      (Enemy_3_RAM_Pattern_Addr), hl
    xor     a
    ld      (Enemies_Counter), a
    ld      (Enemy_1_X), a
    ld      (Enemy_1_Pattern), a
    ld      (Enemy_1_Color), a
    ld      (Enemy_2_X), a
    ld      (Enemy_2_Pattern), a
    ld      (Enemy_2_Color), a
    ld      (Enemy_3_X), a
    ld      (Enemy_3_Pattern), a
    ld      (Enemy_3_Color), a
    ld      a, 192
    ld      (Enemy_1_Y), a
    ld      (Enemy_2_Y), a
    ld      (Enemy_3_Y), a

    ret