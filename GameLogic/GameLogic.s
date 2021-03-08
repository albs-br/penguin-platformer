GameLogic:

;--------------------


    
    ; [debug]
    ; test only
    ld      a, (Test_Sprite_X)
    ld      h, a
    ld      a, (Test_Sprite_Y)
    ld      l, a
    call    CheckBackGround
    call    z, .testSpriteAtEmptySpace
    call    nz, .testSpriteAtOccupiedSpace
    ld      (Test_Sprite_Color), a



    ld      a, (Player_IsAlive)
    or      a
    jp      z, InitGame



    ; check if player is at empty space
    ; formula: COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)     (only first 4 rows)
    ld      a, (Player_IsGrounded)
    or      a
    jp      z, .isFalling




    ; Penguin animation
    ld      a, (KeyPressed)
    or      a
    jp      z, .noKeyPressed                            ; if (KeyPressed == 0)
    dec     a
    jp      nz, .skip                                   ; if (KeyPressed == 1)



    ; walking right
    ld      a, (Player_Animation_Frame)
    inc     a
    and     0000 0111 b                                 ; each 8 frames
    ld      (Player_Animation_Frame), a
    jp      nz, .skip

    ld      a, (Player_Sprite_Number)
    cp      PENGUIN_RIGHT_WALKING_LAST_FRAME
    jp      z, .restartWalkingRight                     ; if (Player_Sprite_Number == PENGUIN_RIGHT_WALKING_LAST_FRAME)
    add     8                                           ; next frame
    jp      .savePlayerFrame
.restartWalkingRight:
    ld      a, PENGUIN_RIGHT_WALKING_1
    jp      .savePlayerFrame

.noKeyPressed:
    ld      a, PENGUIN_RIGHT_STANDING
.savePlayerFrame:
    ld      (Player_Sprite_Number), a
.skip:

;--------------------

    call    UpdateSpriteAttrTableBuffer

    ret

.isFalling:
    ld      a, (Player_Y)
    cp      SCREEN_HEIGHT_IN_PIXELS
    jp      z, .isDead
    inc     a
    ; TODO: check if there is ground under the updated position
    ld      (Player_Y), a

    jp      .skip

.isDead:
    xor     a
    ld      (Player_IsAlive), a
    jp      .skip



.testSpriteAtEmptySpace:
    ld      a, COLOR_RED
    ld      (Test_Sprite_Color), a
    ret

.testSpriteAtOccupiedSpace:
    ld      a, COLOR_GREEN
    ld      (Test_Sprite_Color), a
    ret

UpdateSpriteAttrTableBuffer:
    ld      hl, SpriteAttrTableBuffer

    ; Sprite # 0
    ld      a, (Test_Sprite_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Test_Sprite_X)
    ld      (hl), a

    inc     hl
    inc     hl
    ld      a, (Test_Sprite_Color)
    ld      (hl), a

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

