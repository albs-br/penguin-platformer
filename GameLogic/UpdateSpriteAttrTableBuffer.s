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
        ld      a, 192          ; put sprite out of screen
        ld      (hl), a
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

    ; Sprite # 6
    inc     hl
    ld      a, (Enemy_2_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_2_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_2_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_2_Color)
    ld      (hl), a


    ; ; Sprite # 7
    ; inc     hl
    ; inc     hl
    ; inc     hl
    ; inc     hl



    ; ; Sprite # 8
    ; inc     hl
    ; inc     hl
    ; inc     hl
    ; inc     hl



    ; ; Sprite # 9
    ; inc     hl
    ; inc     hl
    ; inc     hl
    ; inc     hl



    ; ; Sprite # 10
    ; inc     hl
    ; inc     hl
    ; inc     hl
    ; inc     hl



    ; ; Sprite # 11
    ; inc     hl
    ; inc     hl
    ; inc     hl
    ; inc     hl



    ; ; Sprite # 12
    ; inc     hl
    ; inc     hl
    ; inc     hl
    ; inc     hl

; ----------- Score

SCORE_TOP_LEFT_Y:       equ 8 + 2 - 1
SCORE_TOP_LEFT_X:       equ 7 + 4


    ; Penguin face
    ; Sprite # 
    inc     hl
    ld      a, SCORE_TOP_LEFT_Y
    ld      (hl), a

    inc     hl
    ld      a, SCORE_TOP_LEFT_X
    ld      (hl), a

    inc     hl
    ld      a, TEST_PENGUIN_FACE_BLUE
    ld      (hl), a

    inc     hl
    ld      a, COLOR_DARK_BLUE
    ld      (hl), a

    ; Sprite # 
    inc     hl
    ld      a, SCORE_TOP_LEFT_Y
    ld      (hl), a

    inc     hl
    ld      a, SCORE_TOP_LEFT_X
    ld      (hl), a

    inc     hl
    ld      a, TEST_PENGUIN_FACE_WHITE
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ; Number of lifes
    ; Sprite # 
    inc     hl
    ld      a, SCORE_TOP_LEFT_Y
    ld      (hl), a

    inc     hl
    ld      a, SCORE_TOP_LEFT_X + 17
    ld      (hl), a

    inc     hl
    ld      a, TEST_NUMBER_0_BIG
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ; Number of lifes (shadow)
    ; Sprite # 
    inc     hl
    ld      a, SCORE_TOP_LEFT_Y + 1
    ld      (hl), a

    inc     hl
    ld      a, SCORE_TOP_LEFT_X + 17 + 1
    ld      (hl), a

    inc     hl
    ld      a, TEST_NUMBER_0_BIG
    ld      (hl), a

    inc     hl
    ld      a, COLOR_BLACK
    ld      (hl), a

    ; Number of diamonds / time bar - LEFT
    ; Sprite # 
    inc     hl
    ld      a, SCORE_TOP_LEFT_Y + 16 + 2
    ld      (hl), a

    inc     hl
    ld      a, SCORE_TOP_LEFT_X
    ld      (hl), a

    inc     hl
    ld      a, TEST_SCORE_DOWN_LEFT
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a

    ; Number of diamonds / time bar - RIGHT
    ; Sprite # 
    inc     hl
    ld      a, SCORE_TOP_LEFT_Y + 16 + 2
    ld      (hl), a

    inc     hl
    ld      a, SCORE_TOP_LEFT_X + 16
    ld      (hl), a

    inc     hl
    ld      a, TEST_SCORE_DOWN_RIGHT
    ld      (hl), a

    inc     hl
    ld      a, COLOR_WHITE
    ld      (hl), a
    
    ; Number of diamonds / time bar - LEFT - shadow
    ; Sprite # 
    inc     hl
    ld      a, SCORE_TOP_LEFT_Y + 16 + 2 + 1
    ld      (hl), a

    inc     hl
    ld      a, SCORE_TOP_LEFT_X + 1
    ld      (hl), a

    inc     hl
    ld      a, TEST_SCORE_DOWN_LEFT
    ld      (hl), a

    inc     hl
    ld      a, COLOR_BLACK
    ld      (hl), a

    ; Number of diamonds / time bar - RIGHT - shadow
    ; Sprite # 
    inc     hl
    ld      a, SCORE_TOP_LEFT_Y + 16 + 2 + 1
    ld      (hl), a

    inc     hl
    ld      a, SCORE_TOP_LEFT_X + 16 + 1
    ld      (hl), a

    inc     hl
    ld      a, TEST_SCORE_DOWN_RIGHT
    ld      (hl), a

    inc     hl
    ld      a, COLOR_BLACK
    ld      (hl), a


    ret
