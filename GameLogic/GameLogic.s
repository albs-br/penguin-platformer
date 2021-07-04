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

    ld      a, (Player_IsJumping)
    or      a
    jp      nz, .isJumping


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
    ld      a, (Player_IsJumping)
    or      a
    jp      nz, .isJumping

    ; skip test jump pressed if already jumping
    ; ld      a, (Player_JumpCounter)
    ; or      a
    ; jp      nz, .skipCheckJumpKeyPressed
    
    ; Check if jump pressed
    ld      a, (JumpKeyPressed)
    or      a
    call    nz, .startJumping
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
    call    .startFalling

    jp      .cancelMovement

.setIsGrounded:
    xor     a
    ld      (Player_IsJumping), a
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



.startJumping:
    ; Check if is at screen top (Player_Y == 255) ; 255 is the same as -1
    ld      a, (Player_Y)
    inc     a                          ; Player_Y == 255 is valid
    ret     z

    ld      a, 1
    ld      (Player_IsJumping), a

    ; Set jump delta Y addr to start of jumping
    ld      hl, JUMP_DELTA_Y_TABLE
    ld      (Player_Jumping_Addr), hl

    ret



.isJumping:
    ld      hl, (Player_Jumping_Addr)
    inc     hl
    ld      (Player_Jumping_Addr), hl

    ld      b, (hl)

    ld      a, (Player_Y)
    add     a, b
    ld      (Player_Y), a

    cp      4                           ; check if is at screen top
    jp      c, .setIsFalling            ; if (a < n)

    push    hl
        call    CheckIfPlayerHasTileAbove
    pop     hl
    jp      nz, .setIsFalling

    ; if (deltaY >= 0) jp .falling
    ld      de, JUMP_DELTA_Y_TABLE.FALL_OFFSET_ADDR
    call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    jp      nc, .setIsFalling           ; if hl >= de

    call    CheckDirectionWhenOffGround

    jp      .return

.setIsFalling:
    call    .startFalling

    jp      .return



.startFalling:
    xor     a
    ld      (Player_IsGrounded), a
    ld      (Player_IsJumping), a

    ; Set jump counter addr to start of falling
    ld      hl, JUMP_DELTA_Y_TABLE.FALL_OFFSET_ADDR
    ld      (Player_Jumping_Addr), hl

    ret



.isFalling:
    ld      hl, (Player_Jumping_Addr)
    inc     hl
    ld      (Player_Jumping_Addr), hl

    ; ld      a, (Player_Y)
    ; cp      SCREEN_HEIGHT_IN_PIXELS
    ; jp      nc, .isDead             ; if (a >= n)
    ;add     2
    ;ld      (Player_Y), a

    push    hl
        ld      de, JUMP_DELTA_Y_TABLE.end
        call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
        jp      c, .notTerminalSpeed        ; if hl < de

;.terminalSpeed:
        ld      b, CFG_PLAYER_GRAVITY
        jp      .saveYafterFalling

.notTerminalSpeed:
        ld      b, (hl)

.saveYafterFalling:
        ld      a, (Player_Y)
        add     a, b
        ld      (Player_Y), a
    pop     hl

    ; only test for ground if not currently on last line
    cp      SCREEN_HEIGHT_IN_PIXELS - PENGUIN_HEIGHT - 8
    jp      nc, .return               ; if (a >= n)

    call    CheckIfPlayerIsGrounded
    jp      nz, .setIsGrounded

    call    CheckDirectionWhenOffGround

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




; Delta-Y (dY) table for jumping and falling
; original code from @TheNestruo (https://www.msx.org/forum/msx-talk/development/first-test-horizontal-scrolling-game-possibly-named-penguim-platformer?page=10)
JUMP_DELTA_Y_TABLE:        			                                    ; jump height: 56 pixels
	db	-4, -4, -4, -4                                                  ; 4 steps / 16 pixels
	db	-3, -3, -3, -3, -3, -3                                          ; 6 steps / 18 pixels
	db	-2, -2, -2, -2, -2, -2, -2, -2                                  ; 8 steps / 16 pixels
	db	-1, -1, -1, -1, -1, -1,  0, -1,  0,  0, -1                      ; 11 steps / 8 pixels
.TOP_OFFSET_ADDR:
	db	 0,  0,  0,  0,  0,  0
.FALL_OFFSET_ADDR:
	db	 1,  0,  0,  1,  0,  1,  1,  1,  1,  1,  1
	db	 2,  2,  2,  2,  2,  2,  2,  2
	db	 3,  3,  3,  3,  3,  3
	db	 4
.end:

; Terminal falling speed (pixels/frame)
CFG_PLAYER_GRAVITY:		equ 4