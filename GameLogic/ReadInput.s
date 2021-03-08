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


    ; ----- Read player inputs
    xor     a
    ld      (KeyPressed), a

    ld      a, c                    ; restore keyboard status

    bit     4, a                    ; 4th bit (key left), table with all keys on MSX Progs em Ling. de Maq. pag 58
    jp      z, .playerLeft

    ; ld a, c
    bit     7, a                    ; 7th bit (key right)
    jp      z, .playerRight


    ; test sprite
    ld      a, 0
    call    SNSMAT_NO_DI_EI         ; Read Data Of Specified Line From Keyboard Matrix
    ; ld c, a                       ; save keyboard status
    bit 1, a
    jp z, .spriteLeft
    bit 2, a
    jp z, .spriteRight
    bit 3, a
    jp z, .spriteUp
    bit 4, a
    jp z, .spriteDown



    xor     a
    ld      (ScrollDirection), a

    ret

.scrollLeft:
    ld      a, SCROLL_DIRECTION_LEFT
    ld      (ScrollDirection), a
    ret

.scrollRight:
    ld      a, SCROLL_DIRECTION_RIGHT
    ld      (ScrollDirection), a
    ret



.playerLeft:
    ld      a, SCROLL_DIRECTION_LEFT
    ld      (ScrollDirection), a
    ld      (KeyPressed), a
    ret

.playerRight:
    ; Check if there is a tile on the right

    ld      a, (Player_X)
    add     PENGUIN_WIDTH - 1       ; x of last column
    ld      h, a
    
    ; Add FrameIndex - 7 to X to compensate the scrolled tiles
    ld      a, (FrameIndex)
    sub     7
    add     h
    ld      h, a

    ld      a, (Player_Y)
    add     8
    ld      l, a
    call    CheckBackGround
    jp      nz, .cancelMovement

    ld      a, SCROLL_DIRECTION_RIGHT
    ld      (ScrollDirection), a
    ld      (KeyPressed), a
    ret

.cancelMovement:
    xor     a
    ld      (ScrollDirection), a
    ld      (KeyPressed), a
    ret



; test
.spriteUp:
    ld      hl, Test_Sprite_Y
    dec     (hl)
    ret

.spriteDown:
    ld      hl, Test_Sprite_Y
    inc     (hl)
    ret

.spriteRight:
    ld      hl, Test_Sprite_X
    inc     (hl)
    ret

.spriteLeft:
    ld      hl, Test_Sprite_X
    dec     (hl)
    ret
