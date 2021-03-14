UpdateSpriteAttrTableBuffer:
    ld      hl, SpriteAttrTableBuffer

    ; Sprite # 0
    IFDEF DEBUG
        ld      a, (Test_Sprite_Y)
        ld      (hl), a

        inc     hl
        ld      a, (Test_Sprite_X)
        ld      (hl), a

        inc     hl
        inc     hl
        ld      a, (Test_Sprite_Color)
        ld      (hl), a
    ELSE
        inc     hl
        inc     hl
        inc     hl
    ENDIF    

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

    ret
