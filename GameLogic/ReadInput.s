ReadInput:
    ; read keyboard
    ld      a, 8                    ; 8th line
    call    SNSMAT_NO_DI_EI         ; Read Data Of Specified Line From Keyboard Matrix
    ; ld c, a                       ; save keyboard status

    ; ld a, c
    ; bit     4, a                    ; 4th bit (key left), table with all keys on MSX Progs em Ling. de Maq. pag 58
    bit     3, a                    ; DEL
    jp      z, .keyboardLeft

    ; ld a, c
    ; bit     7, a                    ; 7th bit (key right)
    bit     2, a                    ; INS
    jp      z, .keyboardRight



    ; test sprite
    bit 4, a
    jp z, .spriteLeft
    bit 7, a
    jp z, .spriteRight
    bit 5, a
    jp z, .spriteUp
    bit 6, a
    jp z, .spriteDown



    xor     a
    ld      (ScrollDirection), a

    ret

.keyboardLeft:
    ld      a, 2
    ld      (ScrollDirection), a
    ret

.keyboardRight:
    ld      a, 1
    ld      (ScrollDirection), a
    ret





.spriteUp:
    ld      hl, Player_Y
    dec     (hl)
    ret

.spriteDown:
    ld      hl, Player_Y
    inc     (hl)
    ret

.spriteRight:
    ld      hl, Player_X
    inc     (hl)
    ret

.spriteLeft:
    ld      hl, Player_X
    dec     (hl)
    ret
