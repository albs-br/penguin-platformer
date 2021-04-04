UpdateBgObjects:

    ; get BgCurrentIndex and divide by 8, to convert index expressed in pixels into tiles (first visible column)
    ld      hl, (BgCurrentIndex)
    srl     h                 ; shift right HL
    rr      l
    srl     h                 ; shift right HL
    rr      l
    srl     h                 ; shift right HL
    rr      l

    ld      (FirstVisibleColumn), hl
    ld      de, 31
    add     hl, de
    ld      (LastVisibleColumn), hl


    ; search
    ld      hl, BgObjects_Start
    ld      (UpdateBgObjects_CurrentAddr), hl
.loop:    
    ld      hl, (UpdateBgObjects_CurrentAddr)
    ld      a, (hl)
    or      a
    ret     z ;jp      z, .end

    ld      h, 0
    ld      l, a

    ; multiply by 2, because the value is (0-510) but stored as (0-255)
    add     hl, hl
    

    ; compare with first visible column
    ld      de, (FirstVisibleColumn)
    call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    jp      z, .isVisible               ; if hl == de
    jp      c, .next                    ; if hl < de

    ; compare with last visible column
    ld      de, (LastVisibleColumn)
    call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    ret     nc ; jp      nc, .end       ; if hl >= de
    jp      .isVisible

.next:
    ld      hl, (UpdateBgObjects_CurrentAddr)

    ld      de, BG_OBJ_STRUCT_SIZE
    add     hl, de

    ld      (UpdateBgObjects_CurrentAddr), hl
    
    ld      de, BgObjects_End
    call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    ret     nc ;jp      nc, .end        ; if hl >= de
    
    jp      .loop

.isVisible:
    call    ShowBgObject
    jp      .next

; .end:
;     ret


; inputs:
;   HL: column position of object on the bg (0-511)
ShowBgObject:
    ; --- Put a Bg obj on screen

    ; position of object on bg
    ld      (UpdateBgObjects_PosObjOnBG), hl
    ex      de, hl

    ; check if object is enabled
    ld      hl, (UpdateBgObjects_CurrentAddr)
    inc     hl
    inc     hl
    inc     hl
    ld      a, (hl)
    or      a
    ret     z
    
    ; get row number
    dec     hl
    ld      a, (hl)
    ld      h, 0
    ld      l, a
    ; add     hl, hl                          ; multiply by 32
    ; add     hl, hl                          ; this multiplication is now pre calculated on BgObjects.s
    ; add     hl, hl
    ;ld      a, l
    ld      (UpdateBgObjects_Y), a          ; save object pixel Y position
    add     hl, hl
    add     hl, hl                          
    ld      bc, NamesTable
    add     hl, bc

    ld	    a, (BIOS_VDP_DW)
    ld	    c, a

    ; First row of 16x16 object
    ;ld	    hl, NamesTable + (32 * 16)
    add     hl, de
    ld      de, (FirstVisibleColumn)
    or      a                               ; clear carry flag
    sbc     hl, de
    dec     hl
    push    hl
	    call    BIOS_SETWRT
    
        ; top left
        ; TODO: check if column is < 0 (bug showing on the other side of screen)
        ld      hl, BgObjectsInitialState_Start + 1     ; TODO get object from second byte of struct
        ld      b, (hl)
        ld      a, (FrameIndex)
        add     b
        out     (c), a

        ; top center
        add     a, 8
        nop
        out     (c), a

        ; top right
        add     a, 8
        nop
        out     (c), a

    ; Second row of 16x16 object
    ;ld	    hl, NamesTable + (32 * 16) + 16
    pop     hl
    ld      de, 32
    add     hl, de
	call    BIOS_SETWRT
    
        ; bottom left
        ld      hl, BgObjectsInitialState_Start + 1
        ld      b, (hl)
        ld      a, (FrameIndex)
        add     b
        add     a, 32
        out     (c), a

        ; bottom center
        add     a, 8
        nop
        out     (c), a
    
        ; bottom right
        add     a, 8
        nop
        out     (c), a
    
    ; Check collision between penguin and object
    ld      a, (Player_X)
    ld      b, a
    ld      a, (Player_Y)
    inc     a                                   ; small adjust needed (is it because of the y+1 issue of TMS9918?)
    ld      c, a

    ld      hl, (UpdateBgObjects_PosObjOnBG)    ; x of object = (ObjPositionOnBg - FirstVisibleColumn) * 8
    ld      de, (FirstVisibleColumn)
    or      a                                   ; clear carry flag
    sbc     hl, de
    add     hl, hl                              ; multiply by 8
    add     hl, hl
    add     hl, hl
    ld      a, (FrameIndex)
    ld      e, a
    ld      a, l
    sub     a, e
    ld      d, a
    ld      (UpdateBgObjects_X), a

    ld      a, (UpdateBgObjects_Y)
    ld      e, a ;16 * 8
    call    CheckCollision_8x8_8x8
    ret     nc

    ; if collided, disable object
    ld      hl, (UpdateBgObjects_CurrentAddr)
    inc     hl
    inc     hl
    inc     hl
    xor     a ; same as ld a, 0
    ld      (hl), a

    ; start diamond disappearing animation
    ld      a, DIAMOND_DISAPPEARING_FIRST_FRAME
    ld      (DiamondDisappearing_FrameNumber), a
    ld      a, (UpdateBgObjects_Y)
    ld      (DiamondDisappearing_Y), a
    ld      a, (UpdateBgObjects_X)
    ld      (DiamondDisappearing_X), a
    xor     a
    ld      (DiamondDisappearing_Counter), a

    ret