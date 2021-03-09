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



    ld      a, (Player_IsGrounded)
    or      a
    jp      z, .isFalling


    ; get the current key pressed
    ld      a, (KeyPressed)
    or      a
    jp      z, .setPlayerStandingRight                            ; if (KeyPressed == 0)
    dec     a
    jp      nz, .skip                                   ; if (KeyPressed == 1)

    jp      .PlayerRight



.setPlayerStandingRight:
    xor     a
    ld      (ScrollDirection), a
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



.PlayerRight:
    ; ---------------- Check if there is a tile on the right

    ld      a, (Player_X)
    add     PENGUIN_WIDTH - 1 - 7      ; PENGUIN_WIDTH - 1: x of last column; -7: compensate for the scrolled tiles
    ld      h, a
    
    ; Add FrameIndex - 7 to X to compensate for the scrolled tiles
    ld      a, (FrameIndex)
    ;sub     7
    add     h
    ld      h, a

    ld      a, (Player_Y)
    add     8
    ld      l, a
    call    CheckBackGround
    jp      nz, .cancelMovement

    ; ---------------- Check if there is a tile under the player

    ld      a, (Player_X)
    ld      h, a
    
    ld      a, (Player_Y)
    add     PENGUIN_HEIGHT + 8
    ld      l, a
    call    CheckBackGround
    jp      z, .resetIsGounded

.walkingRight:
    ; walking right
    ld      a, DIRECTION_RIGHT
    ld      (ScrollDirection), a


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


.cancelMovement:
    xor     a
    ld      (ScrollDirection), a
    jp      .setPlayerStandingRight

.resetIsGounded:
    xor     a
    ld      (Player_IsGrounded), a
    jp      .cancelMovement
