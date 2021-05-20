UpdateSpriteAttrTableBuffer:
    ld      hl, SpriteAttrTableBuffer

    ; Sprite # 0
    ; IFDEF DEBUG
    ;     ld      a, (Test_Sprite_Y)
    ;     ld      (hl), a

    ;     inc     hl
    ;     ld      a, (Test_Sprite_X)
    ;     ld      (hl), a

    ;     inc     hl
    ;     inc     hl
    ;     ld      a, (Test_Sprite_Color)
    ;     ld      (hl), a
    ; ELSE
        inc     hl
        inc     hl
        inc     hl
    ; ENDIF    

    ; Sprite # 1
    inc     hl
    ld      a, (Player_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Player_X)
    ld      (hl), a

    inc     hl
    ld      a, (Player_Sprite_Number)
    ld      (hl), a

    inc     hl
    ld      a, COLOR_DARK_BLUE
    ld      (hl), a

    ; Sprite # 2
    inc     hl
    ld      a, (Player_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Player_X)
    ld      (hl), a

    inc     hl
    ld      a, (Player_Sprite_Number)
    add     4
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ; Sprite # 3
    inc     hl
    ld      a, (Sparkles_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Sparkles_X)
    ld      (hl), a

    inc     hl
    ld      a, (Sparkles_FrameNumber)
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ; Sprite # 4
    inc     hl
    ld      a, (HitFlash_Y)
    ld      (hl), a

    inc     hl
    ld      a, (HitFlash_X)
    ld      (hl), a

    inc     hl
    ld      a, (HitFlash_FrameNumber)
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ; Sprite # 5
    inc     hl
    ld      a, (Enemy_1_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_1_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_1_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_1_Color)
    ld      (hl), a



; ----------- TEST

    ; Sprite # 6
    inc     hl
    ld      a, 8 - 1
    ld      (hl), a

    inc     hl
    ld      a, 24
    ld      (hl), a

    inc     hl
    ld      a, TEST_NUMBER_0
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ; Sprite # 7
    inc     hl
    ld      a, 8 - 1 + 1
    ld      (hl), a

    inc     hl
    ld      a, 24 + 1
    ld      (hl), a

    inc     hl
    ld      a, TEST_NUMBER_0
    ld      (hl), a

    inc     hl
    ld      a, COLOR_BLACK
    ld      (hl), a

    ; Sprite # 8
    inc     hl
    ld      a, 24 - 1
    ld      (hl), a

    inc     hl
    ld      a, 24
    ld      (hl), a

    inc     hl
    ld      a, TEST_NUMBER_1
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ; Sprite # 9
    inc     hl
    ld      a, 24 - 1 + 1
    ld      (hl), a

    inc     hl
    ld      a, 24 + 1
    ld      (hl), a

    inc     hl
    ld      a, TEST_NUMBER_1
    ld      (hl), a

    inc     hl
    ld      a, COLOR_BLACK
    ld      (hl), a


    ret
