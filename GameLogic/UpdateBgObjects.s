UpdateBgObjects:

; --------------- test with fixed values

    ; ; --- Put Bg objs on screen
    ; ld	    a, (BIOS_VDP_DW)
    ; ld	    c, a
    
    ; ; First row
    ; ld	    hl, NamesTable + (32 * 16) + 16
	; call    BIOS_SETWRT
    
    ;     ; top left
    ;     ld      hl, BgObjectsInitialState_Start + 1
    ;     ld      a, (hl)
    ;     out     (c), a

    ;     ; top right
    ;     add     a, 8
    ;     out     (c), a

    ; ; Second row
    ; ld	    hl, NamesTable + (32 * 16) + 16
    ; ld      de, 32
    ; add     hl, de
	; call    BIOS_SETWRT
    
    ;     ; bottom left
    ;     ld      hl, BgObjectsInitialState_Start + 1
    ;     ld      a, (hl)
    ;     add     a, 32
    ;     out     (c), a

    ;     ; bottom right
    ;     add     a, 8
    ;     out     (c), a

; -------------------------------------

    ; get HL and divide by 8, to convert index expressed in pixels into tiles (first visible column)
    ld      hl, (BgCurrentIndex)
    srl     h
    rr      l
    srl     h
    rr      l
    srl     h
    rr      l

    ; one more, because the value to be found is previously divided by 2
    srl     h
    rr      l

    ;ld      b, h ; will always be 0
    ld      c, l

    ; set BgCurrentIndex + 31 (last visible column)
    ld      a, c
    add     31
    ld      b, a


    ; search
    ld      hl, BgObjects_Start
.loop:    
    ld      a, (hl)
    or      a
    jp      z, .end
    
    ; compare with first visible column
    cp      c
    jp      z, .isVisible
    jp      c, .next          ; if a < n

    ; compare with last visible column
    cp      b
    jp      nc, .end          ; if a >= n
    jp      .isVisible

    ;jp      .loop

.next:
    ld      de, BG_OBJ_STRUCT_SIZE
    add     hl, de
    
    ld      de, BgObjects_End
    call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    jp      nc, .end
    
    jp      .loop

.isVisible:
    push    hl
    push    bc
      call      ShowBgObject
    pop     bc
    pop     hl
    jp      .next

.end:
    ret


ShowBgObject:
    ; --- Put Bg objs on screen
    ld	    a, (BIOS_VDP_DW)
    ld	    c, a
    
    ; First row
    ld	    hl, NamesTable + (32 * 16) + 16
	call    BIOS_SETWRT
    
        ; top left
        ld      hl, BgObjectsInitialState_Start + 1
        ld      a, (hl)
        out     (c), a

        ; top right
        add     a, 8
        out     (c), a

    ; Second row
    ld	    hl, NamesTable + (32 * 16) + 16
    ld      de, 32
    add     hl, de
	call    BIOS_SETWRT
    
        ; bottom left
        ld      hl, BgObjectsInitialState_Start + 1
        ld      a, (hl)
        add     a, 32
        out     (c), a

        ; bottom right
        add     a, 8
        out     (c), a
    
    ret