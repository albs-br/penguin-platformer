GameLogic:


;--------------------


    
    ; ; [debug]
    ; ; test only
    ; ld      a, (Test_Sprite_X)
    ; ld      h, a
    ; ld      a, (Test_Sprite_Y)
    ; ld      l, a
    ; call    CheckBackGround_Left
    ; ; [debug] save tile number
    ; ld (D_TileNumber), a
    ; call    z, .testSpriteAtEmptySpace
    ; call    nz, .testSpriteAtOccupiedSpace
    ; ld      (Test_Sprite_Color), a


    ; ------------------------------------------
;     ; [debug]
;     xor a
;     ld (D_Above), a
;     call CheckIfPlayerHasTileAbove
;     jp z, .D_Above_not_set
;     ld a, 1
; .D_Above_not_set:
;     ld (D_Above), a

;     xor a
;     ld (D_Right), a
;     call CheckIfPlayerHasTileOnTheRight
;     jp z, .D_Right_not_set
;     ld a, 1
; .D_Right_not_set:
;     ld (D_Right), a

;     xor a
;     ld (D_Below), a
;     call CheckIfPlayerIsGrounded
;     jp z, .D_Below_not_set
;     ld a, 1
; .D_Below_not_set:
;     ld (D_Below), a

    ; ------------------------------------------


    ld      a, (Player_IsAlive)
    or      a
    jp      z, InitGame


    ld      a, 1
    ld      (ScrollSpeed), a


    ld      a, (Player_Y)
    cp      -1                              ; y = 255 is valid
    jp      z, .isNotDead
    cp      SCREEN_HEIGHT_IN_PIXELS - 1
    jp      nc, .isDead                     ; if (a >= n)
.isNotDead:

    ld      a, (Player_JumpCounter)
    or      a
    jp      nz, .jumping


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
    jp      z, .setPlayerStanding                                   ; if (KeyPressed == 0)
    dec     a
    jp      z, .PlayerRight                                         ; if (KeyPressed == 1)
    dec     a
    jp      z, .PlayerLeft                                          ; if (KeyPressed == 2)
    jp      .return


.setPlayerStanding:
    xor     a
    ld      (ScrollDirection), a

    ld      a, (Player_Facing)
    cp      DIRECTION_RIGHT
    jp      z, .setPlayerStandingRight

;.setPlayerStandingLeft:
    ld      a, PENGUIN_LEFT_STANDING
    jp      .savePlayerFrame

.setPlayerStandingRight:
    ld      a, PENGUIN_RIGHT_STANDING
.savePlayerFrame:
    ld      (Player_Sprite_Number), a
.return:

;--------------------

    call    UpdateSpriteAttrTableBuffer

    ret

.isFalling:
    ld      a, (Player_Y)
    ; cp      SCREEN_HEIGHT_IN_PIXELS
    ; jp      nc, .isDead             ; if (a >= n)
    add     2 ;inc     a
    ld      (Player_Y), a

    ; only test for ground if not currently on last line
    cp      SCREEN_HEIGHT_IN_PIXELS - PENGUIN_HEIGHT - 8
    jp      nc, .return               ; if (a >= n)

    call    CheckIfPlayerIsGrounded
    jp      nz, .setIsGrounded

    call    CheckDirectionWhenOffGround

    jp      .return

.isDead:
    xor     a
    ld      (Player_IsAlive), a
    jp      .return


; ; test [debug]
; .testSpriteAtEmptySpace:
;     ld      a, COLOR_RED
;     ld      (Test_Sprite_Color), a
;     ret
; .testSpriteAtOccupiedSpace:
;     ld      a, COLOR_GREEN
;     ld      (Test_Sprite_Color), a
;     ret



.PlayerRight:
    ld      a, (Player_Facing)
    cp      DIRECTION_RIGHT
    jp      z, .isFacingRight

    ; set Penguin facing right
    ; ld      a, DIRECTION_RIGHT
    ; ld      (Player_Facing), a
    ; ld      a, PENGUIN_RIGHT_STANDING
    ; ld      (Player_Sprite_Number), a
    ; xor     a
    ; ld      (Player_Animation_Frame), a

    ; start left to right animation
    ld      a, PENGUIN_TURNING_LEFT_TO_RIGHT_0
    ld      (Player_Sprite_Number), a
    xor     a
    ld      (Player_Animation_Frame), a
    ld      a, DIRECTION_RIGHT
    ld      (Player_Facing), a

.isFacingRight:
    ld      a, DIRECTION_RIGHT
    ld      (Player_Facing), a

    ; check if movement is possible
    call    CheckIfPlayerHasTileOnTheRight
    jp      nz, .cancelMovement
    call    CheckIfPlayerIsGrounded
    jp      z, .noGroundUnder

    ; Movement possible
    ld      a, DIRECTION_RIGHT
    ld      (ScrollDirection), a


; --------------- Animation
;.doAnimation:

    ; if (Player_Sprite_Number >= PENGUIN_TURNING_LEFT_TO_RIGHT_0) { 
    ;   doAnimationLeftToRight 
    ; }
    ; else {
    ;   doWalkingRightAnimation
    ; }
    ld      a, (Player_Sprite_Number)
    cp      PENGUIN_TURNING_LEFT_TO_RIGHT_0
    ;jp      nc, .doAnimationLeftToRight        ; a >= n
    jp      c, .doWalkingRightAnimation         ; a < n

    ;.doAnimationLeftToRight:
        ld      a, (Player_Animation_Frame)
        inc     a
        ld      (Player_Animation_Frame), a
        and     0000 0011 b                         ; each 4 frames
        jp      nz, .return
        
        ; if (Player_Sprite_Number == PENGUIN_TURNING_LEFT_TO_RIGHT_LAST_FRAME) { endAnimationLeftToRight}
        ld      a, (Player_Sprite_Number)
        cp      PENGUIN_TURNING_LEFT_TO_RIGHT_LAST_FRAME
        jp      nc, .restartWalkingRight            ; a >= n
        add     8                                   ; next frame
        jp      .savePlayerFrame

    .doWalkingRightAnimation:
        ; walking right
        ld      a, (Player_Animation_Frame)
        inc     a
        ld      (Player_Animation_Frame), a
        and     0000 0111 b                                 ; each 8 frames
        jp      nz, .return
        
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
    jp      .setPlayerStanding

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


.PlayerLeft:
    ld      a, (Player_Facing)
    cp      DIRECTION_LEFT
    jp      z, .isFacingLeft

    ; set Penguin facing left
    ld      a, DIRECTION_LEFT
    ld      (Player_Facing), a
    ld      a, PENGUIN_LEFT_STANDING
    ld      (Player_Sprite_Number), a
    xor     a
    ld      (Player_Animation_Frame), a


.isFacingLeft:
    call    CheckIfPlayerHasTileOnTheLeft
    jp      nz, .cancelMovement

    call    CheckIfPlayerIsGrounded
    jp      z, .noGroundUnder

.walkingLeft:
    ; walking left
    ld      a, DIRECTION_LEFT
    ld      (ScrollDirection), a


    ld      a, (Player_Animation_Frame)
    inc     a
    and     0000 0111 b                                 ; each 8 frames
    ld      (Player_Animation_Frame), a
    jp      nz, .return

    ld      a, (Player_Sprite_Number)
    cp      PENGUIN_LEFT_WALKING_LAST_FRAME
    jp      z, .restartWalkingleft                      ; if (Player_Sprite_Number == PENGUIN_LEFT_WALKING_LAST_FRAME)
    add     8                                           ; next frame
    jp      .savePlayerFrame
.restartWalkingLeft:
    ld      a, PENGUIN_LEFT_WALKING_1
    jp      .savePlayerFrame



.startJump:
    ; Check if is at screen top (Player_Y == 255)
    ld      a, (Player_Y)
    inc     a                          ; Player_Y == 255 is valid
    ret     z

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

    call    CheckIfPlayerHasTileAbove
    jp      nz, .falling

    jp      .return

.falling:
    xor     a
    ld      (Player_IsGrounded), a
    ld      (Player_JumpCounter), a
    jp      .return



CheckDirectionWhenOffGround:
    ld      a, (DirectionKeyPressed)
    or      a
    jp      z, .setDirectionNone
    dec     a ; cp      DIRECTION_RIGHT
    jp      z, .checkDirectionRight
    dec     a ; cp      DIRECTION_LEFT
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