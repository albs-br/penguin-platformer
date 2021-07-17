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
    ld      (FramesSkipped), a
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


    ld      a, 255
    ld      (EnemyTypeB_1_CurrentSpriteLoaded), a
    ld      (EnemyTypeB_2_CurrentSpriteLoaded), a

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
    
    ; Enemies type A
    ld      hl, 0
    ld      (Enemy_TypeA_1_RAM_Pattern_Addr), hl
    ld      (Enemy_TypeA_2_RAM_Pattern_Addr), hl
    ld      (Enemy_TypeA_3_RAM_Pattern_Addr), hl
    xor     a
    ld      (Enemies_TypeA_Counter), a
    ld      (Enemy_TypeA_1_X), a
    ld      (Enemy_TypeA_1_Pattern), a
    ld      (Enemy_TypeA_1_Color), a
    ld      (Enemy_TypeA_2_X), a
    ld      (Enemy_TypeA_2_Pattern), a
    ld      (Enemy_TypeA_2_Color), a
    ld      (Enemy_TypeA_3_X), a
    ld      (Enemy_TypeA_3_Pattern), a
    ld      (Enemy_TypeA_3_Color), a
    ld      a, 192
    ld      (Enemy_TypeA_1_Y), a
    ld      (Enemy_TypeA_2_Y), a
    ld      (Enemy_TypeA_3_Y), a

    ; Enemies type B
    xor     a
    ld      (Enemies_TypeB_Counter), a
    ld      (Enemy_TypeB_1_X), a
    ld      (Enemy_TypeB_1_1st_Sprite_Pattern), a
    ld      (Enemy_TypeB_1_2nd_Sprite_Pattern), a
    ld      (Enemy_TypeB_1_3rd_Sprite_Pattern), a
    ld      (Enemy_TypeB_1_1st_Sprite_Color), a
    ld      (Enemy_TypeB_1_2nd_Sprite_Color), a
    ld      (Enemy_TypeB_1_3rd_Sprite_Color), a
    ld      (Enemy_TypeB_2_X), a
    ld      (Enemy_TypeB_2_1st_Sprite_Pattern), a
    ld      (Enemy_TypeB_2_2nd_Sprite_Pattern), a
    ld      (Enemy_TypeB_2_3rd_Sprite_Pattern), a
    ld      (Enemy_TypeB_2_1st_Sprite_Color), a
    ld      (Enemy_TypeB_2_2nd_Sprite_Color), a
    ld      (Enemy_TypeB_2_3rd_Sprite_Color), a
    ld      (Enemy_TypeB_3_X), a
    ld      (Enemy_TypeB_3_1st_Sprite_Pattern), a
    ld      (Enemy_TypeB_3_2nd_Sprite_Pattern), a
    ld      (Enemy_TypeB_3_3rd_Sprite_Pattern), a
    ld      (Enemy_TypeB_3_1st_Sprite_Color), a
    ld      (Enemy_TypeB_3_2nd_Sprite_Color), a
    ld      (Enemy_TypeB_3_3rd_Sprite_Color), a
    ld      (Enemy_TypeB_4_X), a
    ld      (Enemy_TypeB_4_1st_Sprite_Pattern), a
    ld      (Enemy_TypeB_4_2nd_Sprite_Pattern), a
    ld      (Enemy_TypeB_4_3rd_Sprite_Pattern), a
    ld      (Enemy_TypeB_4_1st_Sprite_Color), a
    ld      (Enemy_TypeB_4_2nd_Sprite_Color), a
    ld      (Enemy_TypeB_4_3rd_Sprite_Color), a
    ; add enemies here
    ld      a, 192
    ld      (Enemy_TypeB_1_Y), a
    ld      (Enemy_TypeB_1_2nd_Sprite_Y), a
    ld      (Enemy_TypeB_1_3rd_Sprite_Y), a
    ld      (Enemy_TypeB_2_Y), a
    ld      (Enemy_TypeB_2_2nd_Sprite_Y), a
    ld      (Enemy_TypeB_2_3rd_Sprite_Y), a
    ld      (Enemy_TypeB_3_Y), a
    ld      (Enemy_TypeB_3_2nd_Sprite_Y), a
    ld      (Enemy_TypeB_3_3rd_Sprite_Y), a
    ld      (Enemy_TypeB_4_Y), a
    ld      (Enemy_TypeB_4_2nd_Sprite_Y), a
    ld      (Enemy_TypeB_4_3rd_Sprite_Y), a
    ; add enemies here

    ret