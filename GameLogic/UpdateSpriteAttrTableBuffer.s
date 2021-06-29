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

; ---------------------------------------------

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



; ----------------------------------------
; Enemies Type A

    ; Sprite # 5
    inc     hl
    ld      a, (Enemy_TypeA_1_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_1_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_1_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_1_Color)
    ld      (hl), a

    ; Sprite # 6
    inc     hl
    ld      a, (Enemy_TypeA_2_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_2_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_2_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_2_Color)
    ld      (hl), a

    ; Sprite # 7
    inc     hl
    ld      a, (Enemy_TypeA_3_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_3_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_3_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeA_3_Color)
    ld      (hl), a

; ---------------------------------------
; Enemies Type B

    ; Enemy type B #1

    ; Sprite # 8
    inc     hl
    ld      a, (Enemy_TypeB_1_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_1st_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_1st_Sprite_Color)
    ld      (hl), a

    ; Sprite # 9
    inc     hl
    ld      a, (Enemy_TypeB_1_2nd_Sprite_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_2nd_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_2nd_Sprite_Color)
    ld      (hl), a

    ; Sprite # 10
    inc     hl
    ld      a, (Enemy_TypeB_1_3rd_Sprite_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_3rd_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_1_3rd_Sprite_Color)
    ld      (hl), a


    ; Enemy type B #2

    ; Sprite # 11
    inc     hl
    ld      a, (Enemy_TypeB_2_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_1st_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_1st_Sprite_Color)
    ld      (hl), a

    ; Sprite # 12
    inc     hl
    ld      a, (Enemy_TypeB_2_2nd_Sprite_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_2nd_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_2nd_Sprite_Color)
    ld      (hl), a

    ; Sprite # 13
    inc     hl
    ld      a, (Enemy_TypeB_2_3rd_Sprite_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_3rd_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_2_3rd_Sprite_Color)
    ld      (hl), a


    ; Enemy type B #3

    ; Sprite # 14
    inc     hl
    ld      a, (Enemy_TypeB_3_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_1st_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_1st_Sprite_Color)
    ld      (hl), a

    ; Sprite # 15
    inc     hl
    ld      a, (Enemy_TypeB_3_2nd_Sprite_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_2nd_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_2nd_Sprite_Color)
    ld      (hl), a

    ; Sprite # 16
    inc     hl
    ld      a, (Enemy_TypeB_3_3rd_Sprite_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_X)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_3rd_Sprite_Pattern)
    ld      (hl), a

    inc     hl
    ld      a, (Enemy_TypeB_3_3rd_Sprite_Color)
    ld      (hl), a

    ; add enemies here



; ---------------------------------------
; Score

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
