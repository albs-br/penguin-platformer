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

    ; get HL and divide by 8, to convert index expressed in pixels into tiles (first visible row)
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

    ; set BgCurrentIndex + 31 (last visible row)
    ld      a, c
    add     31
    ld      b, a


    ; search
    ld      hl, BgObjects
.loop:    
    ld      a, (hl)
    
    ; compare with first visible row
    cp      c
    jp      z, .found
    jp      nc, .next          ; if a <= n

    ; compare with last visible row
    cp      b
    jp      c, .end          ; if a > n
    jp      .found

    ;jp      .loop

.next:
    ld      de, BG_OBJ_STRUCT_SIZE
    add     hl, de
    jp      .loop

.found:
    ;push   bc
    ;   call   ShowBgObject
    ;pop    bc
    jp      .next

.end:
    ret