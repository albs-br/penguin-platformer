ReadInput:
    ; read keyboard
    ld      a, 8                    ; 8th line
    call    SNSMAT_NO_DI_EI         ; Read Data Of Specified Line From Keyboard Matrix
    ; ld c, a                       ; save keyboard status

    ; ld a, c
    bit     4, a                    ; 4th bit (key left), table with all keys on MSX Progs em Ling. de Maq. pag 58
    jp      z, .keyboardLeft

    ; ld a, c
    bit     7, a                    ; 7th bit (key right)
    jp      z, .keyboardRight

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





