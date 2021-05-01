ReadInput:
    ; read keyboard
    ld      a, 8                    ; 8th line
    call    SNSMAT_NO_DI_EI         ; Read Data Of Specified Line From Keyboard Matrix
    ld      c, a                    ; save keyboard status

    ; test
    ; ld a, c
    bit     3, a                    ; DEL
    jp      z, .scrollLeft
    ; ld a, c
    bit     2, a                    ; INS
    jp      z, .scrollRight


    ; Reset player direction inputs
    xor     a
    ld      (DirectionKeyPressed), a
    ld      (JumpKeyPressed), a



    ; ----- Read player direction inputs
    ld      a, c                    ; restore keyboard status

    bit     4, a                    ; 4th bit (key left)
    jp      z, .playerLeft

    ; ld a, c
    bit     7, a                    ; 7th bit (key right)
    jp      z, .playerRight


.readOtherKeys:
    ; Test if jump is pressed
    ld      a, 5                    ; 5th line
    call    SNSMAT_NO_DI_EI         ; Read Data Of Specified Line From Keyboard Matrix
    ld      c, a

    bit     5, a                    ; 5th bit (key X)
    call    z, .playerJump

    ld      a, c
    bit     7, a                    ; 7th bit (key Z)
    call    z, .playerRun
    call    nz, .playerNoRun

    ; ; test sprite
    ; ld      a, 0
    ; call    SNSMAT_NO_DI_EI         ; Read Data Of Specified Line From Keyboard Matrix
    ; ; ld c, a                       ; save keyboard status
    ; bit 1, a
    ; jp z, .spriteLeft
    ; bit 2, a
    ; jp z, .spriteRight
    ; bit 3, a
    ; jp z, .spriteUp
    ; bit 4, a
    ; jp z, .spriteDown


    ret

.scrollLeft:
    ld      a, DIRECTION_LEFT
    ld      (ScrollDirection), a
    ret

.scrollRight:
    ld      a, DIRECTION_RIGHT
    ld      (ScrollDirection), a
    ret



.playerLeft:
    ld      a, DIRECTION_LEFT
    ld      (DirectionKeyPressed), a
    jp      .readOtherKeys

.playerRight:
    ld      a, DIRECTION_RIGHT
    ld      (DirectionKeyPressed), a
    jp      .readOtherKeys

.playerJump:
    ld      a, 1
    ld      (JumpKeyPressed), a
    ret

.playerRun:
    ld      a, 1
    ld      (RunKeyPressed), a
    ret

.playerNoRun:
    xor     a
    ld      (RunKeyPressed), a
    ret

; test [debug]
; .spriteUp:
;     ld      hl, Test_Sprite_Y
;     dec     (hl)
;     ret

; .spriteDown:
;     ld      hl, Test_Sprite_Y
;     inc     (hl)
;     ret

; .spriteRight:
;     ld      hl, Test_Sprite_X
;     inc     (hl)
;     ret

; .spriteLeft:
;     ld      hl, Test_Sprite_X
;     dec     (hl)
;     ret
