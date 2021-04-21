GameLogic:


;--------------------


    
    ; [debug]
    ; test only
    ld      a, (Test_Sprite_X)
    ld      h, a
    ld      a, (Test_Sprite_Y)
    ld      l, a
    call    CheckBackGround_Left
    ; [debug] save tile number
    ld (D_TileNumber), a
    call    z, .testSpriteAtEmptySpace
    call    nz, .testSpriteAtOccupiedSpace
    ld      (Test_Sprite_Color), a


    ; ------------------------------------------
    ; [debug]
    xor a
    ld (D_Above), a
    call CheckIfPlayerHasTileAbove
    jp z, .D_Above_not_set
    ld a, 1
.D_Above_not_set:
    ld (D_Above), a

    xor a
    ld (D_Right), a
    call CheckIfPlayerHasTileOnTheRight
    jp z, .D_Right_not_set
    ld a, 1
.D_Right_not_set:
    ld (D_Right), a

    xor a
    ld (D_Below), a
    call CheckIfPlayerIsGrounded
    jp z, .D_Below_not_set
    ld a, 1
.D_Below_not_set:
    ld (D_Below), a

    ; ------------------------------------------


    ld      a, (Player_IsAlive)
    or      a
    jp      z, InitGame


    ld      a, 1
    ld      (ScrollSpeed), a

    ; call    CheckIfPlayerIsGrounded
    ; jp      z, .isFalling


    ld      a, (Player_IsGrounded)
    or      a
    jp      z, .isFalling

    ; if (Player_IsGrounded && RunKeyPressed) ScrollSpeed = 2
    ld      a, (RunKeyPressed)
    or      a
    jp      z, .notRunning
    ld      a, 2
    ld      (ScrollSpeed), a
.notRunning:    

    ; Check if is jumping
    ld      a, (Player_JumpCounter)
    or      a
    jp      nz, .jumping

    ; skip test jump pressed if already jumping
    ; ld      a, (Player_JumpCounter)
    ; or      a
    ; jp      nz, .skipCheckJumpKeyPressed
    
    ; Check if jump pressed
    ld      a, (JumpKeyPressed)
    or      a
    call    nz, .startJump
.skipCheckJumpKeyPressed:

    ; Get the current direction key pressed
    ld      a, (DirectionKeyPressed)
    or      a
    jp      z, .setPlayerStandingRight                              ; if (KeyPressed == 0)
    dec     a
    jp      z, .PlayerRight                                         ; if (KeyPressed == 1)
    ;dec     a
    ;jp      z, .PlayerLeft                                         ; if (KeyPressed == 2)
    jp      .skip



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
    jp      nc, .isDead             ; if (a >= n)
    add     2 ;inc     a
    ld      (Player_Y), a

    ; only test for ground if not currently on last line
    cp      SCREEN_HEIGHT_IN_PIXELS - PENGUIN_HEIGHT - 8
    jp      nc, .skip               ; if (a >= n)

    ; ---------------- Check if there is a tile under the player (bottom left)
    ; add     PENGUIN_HEIGHT + 1
    ; ld      l, a
    ; ld      a, (Player_X)
    ; ld      h, a
    ; call    CheckBackGround
    ; jp      nz, .setIsGrounded

    ; ; ---------------- Check if there is a tile under the player (bottom right)
    ; ld      a, (Player_Y)
    ; add     PENGUIN_HEIGHT + 1
    ; ld      l, a
    ; ld      a, (Player_X)
    ; add     PENGUIN_WIDTH - 1
    ; ld      h, a
    ; call    CheckBackGround
    ; jp      nz, .setIsGrounded
    call    CheckIfPlayerIsGrounded
    jp      nz, .setIsGrounded

    call    CheckDirectionWhenOffGround

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

    ; ld      a, (Player_X)
    ; add     PENGUIN_WIDTH - 1 - 7      ; PENGUIN_WIDTH - 1: x of last column; -7: compensate for the scrolled tiles
    ; ld      h, a
    
    ; ; Add FrameIndex - 7 to X to compensate for the scrolled tiles
    ; ld      a, (FrameIndex)
    ; ;sub     7
    ; add     h
    ; ld      h, a

    ; ; Check top right
    ; ld      a, (Player_Y)
    ; add     8
    ; ld      l, a
    ; call    CheckBackGround
    ; jp      nz, .cancelMovement
    call    CheckIfPlayerHasTileOnTheRight
    jp      nz, .cancelMovement

    ; ; ---------------- Check if there is a tile under the player
    ; ld      a, (Player_X)
    ; ld      h, a
    ; ld      a, (Player_Y)
    ; add     PENGUIN_HEIGHT + 8
    ; ld      l, a
    ; call    CheckBackGround
    ; jp      z, .noGroundUnder
    call    CheckIfPlayerIsGrounded
    jp      z, .noGroundUnder

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

.noGroundUnder:
    xor     a
    ld      (Player_IsGrounded), a
    ld      (Player_JumpCounter), a
    jp      .cancelMovement

.setIsGrounded:
    xor     a
    ld      (Player_JumpCounter), a
    inc     a
    ld      (Player_IsGrounded), a
    jp      .cancelMovement




.startJump:
    ld      hl, Player_JumpCounter
    inc     (hl)
    ret

.jumping:
    ld      a, (Player_JumpCounter)
    inc     a
    cp      32
    ld      (Player_JumpCounter), a
    jp      nc, .falling                ; if (a >= n)

    call    CheckDirectionWhenOffGround

    ld      a, (Player_JumpCounter)
    cp      24
    jp      nc, .topOfJump              ; if (a >= n)

    ld      a, (Player_Y)
    cp      2                           ; check if is at screen top
    jp      c, .falling                 ; if (a < n)
    sub     2
    jp      .saveY

.topOfJump:
    ld      a, (Player_Y)
    cp      1                           ; check if is at screen top
    jp      c, .falling                 ; if (a < n)
    dec     a

.saveY:
    ld      (Player_Y), a

    ; ; Check if there is a tile above the player (top left)
    ;ld      (Player_Y), a
    ; ld      l, a

    ; ld      a, (Player_X)
    ; add     8
    ; ld      h, a

    ; call    CheckBackGround
    ; jp      nz, .falling


    ; ; Check if there is a tile above the player (top right)
    ; ld      a, (Player_Y)
    ; ld      l, a

    ; ld      a, (Player_X)
    ; add     PENGUIN_WIDTH - 1 - 8
    ; ld      h, a
    ; call    CheckBackGround
    ; jp      nz, .falling

    call    CheckIfPlayerHasTileAbove
    jp      nz, .falling

    jp      .skip

.falling:
    xor     a
    ld      (Player_IsGrounded), a
    jp      .skip



CheckDirectionWhenOffGround:
    ld      a, (DirectionKeyPressed)
    or      a
    jp      z, .setDirectionNone
    cp      DIRECTION_RIGHT
    jp      z, .checkDirectionRight
    cp      DIRECTION_LEFT
    jp      z, .checkDirectionLeft
    ret

.checkDirectionRight:
    call    CheckIfPlayerHasTileOnTheRight
    jp      nz, .setDirectionNone

    ld      a, DIRECTION_RIGHT
    ld      (ScrollDirection), a

    ret

.checkDirectionLeft:
    call    CheckIfPlayerHasTileOnTheLeft
    jp      nz, .setDirectionNone

    ld      a, DIRECTION_LEFT
    ld      (ScrollDirection), a
    ret

.setDirectionNone:
    xor     a
    ld      (ScrollDirection), a
    ret