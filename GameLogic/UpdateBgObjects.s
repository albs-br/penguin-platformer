UpdateBgObjects_SetupVariables:

; ---------------- Setup variables

    ; get BgCurrentIndex (0-4095) and divide by 8, to convert index expressed in pixels into 8x8 tiles (first visible column)
    ld      hl, (BgCurrentIndex)                    ; 0-4095
    
    ;dec     hl  ; debug

    srl     h                 ; shift right HL
    rr      l
    srl     h                 ; shift right HL
    rr      l
    srl     h                 ; shift right HL
    rr      l
    ld      (FirstVisibleColumn), hl                ; 0-511

    ; get the screen number (0-15); it's also the number of the page with the Bg Objects (page aligned)
    srl     h                 ; shift right HL
    rr      l                                       ; 0-255
    ld      a, l
    and     1111 0000 b       ; masking to get high nibble
    srl     a                 ; shift right 4 times
    srl     a
    srl     a
    srl     a
    ld      b, a
    ld      c, 0

    ld      hl, (FirstVisibleColumn)
    ld      de, 31
    add     hl, de
    ld      (LastVisibleColumn), hl



    ; setup adresses of current page and next
    ld      hl, BgObjects_Start
    add     hl, bc
    ld      (Addr_Screen_FirstVisibleColumn), hl
    ld      (UpdateBgObjects_CurrentAddr), hl
    ld      bc, 256 + 256 - 1                           ; last byte of the second page / screen
    add     hl, bc
    ld      (Addr_Screen_LastVisibleColumn), hl

    ret

; --------------------------------
; Inputs:
;   (UpdateBgObjects_CurrentAddr)
;   (FirstVisibleColumn)
;   (LastVisibleColumn)
;   (Addr_Screen_LastVisibleColumn)
; Updates:
;   (UpdateBgObjects_StartAddr)
UpdateBgObjects_Execute:
    ld      hl, (UpdateBgObjects_CurrentAddr)
    ld      (UpdateBgObjects_StartAddr), hl

.loop:    
    ; Read first byte of the struct (position on bg 1-255)
    ld      hl, (UpdateBgObjects_CurrentAddr)
    ld      a, (hl)
    or      a
    jp      z, .nextPage                ; if byte read is 0 go to next page

    ; multiply it by 2, because the value is (0-510) but stored as (0-255)
    ld      h, 0
    ld      l, a
    add     hl, hl
    

    ; compare it with first visible column
    ld      de, (FirstVisibleColumn)
    ;call    BIOS_DCOMPR                ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    or      a
    sbc     hl, de
    add     hl, de

    jp      z, .isVisible               ; if hl == de
    jp      c, .next                    ; if hl < de

    ; compare it with last visible column
    ld      de, (LastVisibleColumn)
    ;call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    or      a
    sbc     hl, de
    add     hl, de

    ; ret     nc ;                      ; if hl >= de
    jp      nc, .next                   ; if hl >= de           ; if object is out of visible screen, go to next (objects may be out of order)
    jp      .isVisible

.next:
    ld      hl, (UpdateBgObjects_CurrentAddr)

    ld      a, BG_OBJ_STRUCT_SIZE
    add     l                           ; updating only low byte, as it is table aligned the high byte is always the same
    ld      l, a



    ld      (UpdateBgObjects_CurrentAddr), hl
    
    ;ld      de, BgObjects_End
    ld      de, (Addr_Screen_LastVisibleColumn)
    ;call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    or      a
    sbc     hl, de

    ret     nc ;jp      nc, .end        ; if hl >= de
    
    jp      .loop

.isVisible:
    call    ShowBgObject
    jp      .next

.nextPage:
    ; check if passed end of last page
    ld      de, (Addr_Screen_LastVisibleColumn)
    ;call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    or      a
    sbc     hl, de
    ret     nc ;jp      nc, .end        ; if hl >= de

    ld      hl, (UpdateBgObjects_StartAddr)
    inc     h                                   ; increment only High byte (table aligned)

    ld      (UpdateBgObjects_CurrentAddr), hl
    ld      (UpdateBgObjects_StartAddr), hl
    jp      .loop

; .end:
;     ret


; Inputs:
;   HL: column position of object on the bg (0-511)
;   (UpdateBgObjects_CurrentAddr)
;   (FirstVisibleColumn)
;   (FrameIndex)
; Updates:
;   (UpdateBgObjects_PosObjOnBG)
;   (UpdateBgObjects_Y)
;   (UpdateBgObjects_X)
;   (UpdateBgObjects_CurrentAddr)
ShowBgObject:
    ; --- Put a dynamic bg obj (like diamonds for example) on screen

    ; DE = position of object on bg (0-511)
    ld      (UpdateBgObjects_PosObjOnBG), hl
    ex      de, hl

    ; check if object is enabled
    ld      hl, (UpdateBgObjects_CurrentAddr)
    inc     hl
    inc     hl
    inc     hl
    ld      (UpdateBgObjects_CurrentAddr_State), hl
    ld      a, (hl)
    or      a
    ret     z
    
    ; get row number
    ; HL = VRAM addr of first column of the specified row (NamesTable + (row number * 32))
    dec     hl
    ld      a, (hl)
    ld      h, 0
    ld      l, a
    ; add     hl, hl                          ; multiply by 32
    ; add     hl, hl                          ; multiplication by 8 now is pre calculated on BgObjects.s
    ; add     hl, hl
    ;ld      a, l
    ld      (UpdateBgObjects_Y), a          ; save object pixel Y position
    add     hl, hl
    add     hl, hl
    ld      bc, (CurrentNamesTable)
    add     hl, bc

    ; set VDP port for OUT command
    ld	    a, (BIOS_VDP_DW)
    ld	    c, a

    ; First row of the 16x16 object
    add     hl, de
    ld      de, (FirstVisibleColumn)
    or      a                               ; clear carry flag
    sbc     hl, de
    
    dec     hl                              ; minus one because each two tiles are in reality 3 tiles (for scrolling)

    ;push    hl
    ld      (UpdateBgObjects_NameTable_Addr), hl

	    call    BIOS_SETWRT
    
        ; TODO: check if column is < 0 (bug showing on the other side of screen)
        ld      hl, (UpdateBgObjects_CurrentAddr)
        
        inc     hl                          ; get object from second byte of struct
        ld      a, (hl)
        cp      ENEMY
        jp      z, EnemyLogic
        ld      b, a
        
        ; top left
        ld      a, (FrameIndex)             ; add it to frame index and draw on screen
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

    ; Second row of the 16x16 object
    ;pop     hl
    ld      hl, (UpdateBgObjects_NameTable_Addr)

    ld      de, 32
    add     hl, de
	call    BIOS_SETWRT
    
        ; bottom left
        ;ld      hl, BgObjectsInitialState_Start + 1     ; TODO get object from second byte of struct
        ld      hl, (UpdateBgObjects_CurrentAddr)
        inc     hl
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
    
    ; ------- Check collision between penguin and object

    ld      a, (Player_Y)
    inc     a                                   ; small adjust needed (is it because of the y+1 issue of TMS9918?)
    ld      c, a

    ld      a, (UpdateBgObjects_Y)
    ld      e, a ;16 * 8

    ; first check vertical collision, saving the next block (130 cycles), plus 57/62 of the subroutine if no collision
    call    CheckCollision_16x16_16x16_Vertical
    ret     nc

    ld      a, (Player_X)
    ld      b, a

    ; x of object = (ObjPositionOnBg - FirstVisibleColumn) * 8
    ; ld      hl, (UpdateBgObjects_PosObjOnBG)
    ; ld      de, (FirstVisibleColumn)
    ; or      a                                   ; clear carry flag
    ; sbc     hl, de
    ; add     hl, hl                              ; multiply by 8
    ; add     hl, hl
    ; add     hl, hl
    ; ld      a, (FrameIndex)
    ; ld      e, a
    ; ld      a, l
    ; sub     a, e
    ; ld      d, a
    ; ld      (UpdateBgObjects_X), a
    ld      hl, (UpdateBgObjects_PosObjOnBG)
    call    Convert_BgPosition_X_To_X_In_Pixels
    ld      (UpdateBgObjects_X), a
    ld      d, a

    call    CheckCollision_16x16_16x16_Horizontal
    ret     nc

    ; if collided, disable object
    ; ld      hl, (UpdateBgObjects_CurrentAddr)
    ; inc     hl
    ; inc     hl
    ; inc     hl
    ld      hl, (UpdateBgObjects_CurrentAddr_State)
    ld      a, (hl)
    xor     a ; same as ld a, 0
    ld      (hl), a

    ; start sparkles animation
    ld      a, SPARKLES_FIRST_FRAME
    ld      (Sparkles_FrameNumber), a
    ld      a, (UpdateBgObjects_Y)
    ld      (Sparkles_Y), a
    ld      a, (UpdateBgObjects_X)
    ld      (Sparkles_X), a
    xor     a
    ld      (Sparkles_Counter), a

    ; call    SoundGetItem

    ret



; Convert obj X position expressed in tiles to pixels
; Input:
;   HL: object X position in 8x8 tiles on the background (0-511)
; Output:
;   A: object X position in pixels of the current screen (0-255)
; Depends on variables:
;   (FirstVisibleColumn)
;   (FrameIndex)
Convert_BgPosition_X_To_X_In_Pixels:
    ; Formula:
    ; x of object = (ObjPositionOnBg - FirstVisibleColumn) * 8
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
    ret