DrawBackground_3_Thirds:


; test 
    ; call    DrawBackground_1st_Third
    ; call    DrawBackground_2nd_Third
    ; call    DrawBackground_3rd_Third

    ; call    UpdateBgObjects_SetupVariables
    ; call    UpdateBgObjects_Execute

    ; ld      hl, (Addr_Screen_FirstVisibleColumn)
    ; ld      bc, 64                        ; TODO: use 8 bit add, as it is page aligned
    ; add     hl, bc
    ; ld      (UpdateBgObjects_CurrentAddr), hl
    ; call    UpdateBgObjects_Execute

    ; ld      hl, (Addr_Screen_FirstVisibleColumn)
    ; ld      bc, 64 + 96                   ; TODO: use 8 bit add, as it is page aligned, or even LD L, 64 + 96
    ; add     hl, bc
    ; ld      (UpdateBgObjects_CurrentAddr), hl
    ; call    UpdateBgObjects_Execute

    ; ret

; ------------------------- 1st third -------------------------

    IFDEF DEBUG
        ld 		a, COLOR_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    call    DrawBackground_1st_Third

    IFDEF DEBUG
        ld 		a, COLOR_LIGHT_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    call   UpdateBgObjects_SetupVariables
    call   UpdateBgObjects_Execute


; ------------------------- 2nd third -------------------------

    IFDEF DEBUG
        ld 		a, COLOR_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    call    DrawBackground_2nd_Third

    IFDEF DEBUG
        ld 		a, COLOR_LIGHT_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    ;call    UpdateBgObjects_SetupVariables
    ld      hl, (Addr_Screen_FirstVisibleColumn)
    ld      bc, 64                        ; TODO: use 8 bit add, as it is page aligned, or even LD L, 64
    add     hl, bc
    ld      (UpdateBgObjects_CurrentAddr), hl
    call    UpdateBgObjects_Execute

; ------------------------- 3rd third -------------------------

    IFDEF DEBUG
        ld 		a, COLOR_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    call    DrawBackground_3rd_Third

    IFDEF DEBUG
        ld 		a, COLOR_LIGHT_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

; ; test
;     ld hl, 2

;     call ShowBgObject

    ;call    UpdateBgObjects_SetupVariables
    ld      hl, (Addr_Screen_FirstVisibleColumn)
    ld      bc, 64 + 96                   ; TODO: use 8 bit add, as it is page aligned, or even LD L, 64 + 96
    add     hl, bc
    ld      (UpdateBgObjects_CurrentAddr), hl
;  ld a, 0
;  ld (FrameIndex), a
    call    UpdateBgObjects_Execute

    ret



DrawStaticBg:
    ld      a, (ScrollDirection)
    or      a
    jp      z, .drawBg
    dec     a
    jp      nz, .goLeft
    call    ScrollRight
    ret     ;jp      .continue
.goLeft:
    call    ScrollLeft
    ret     ;jp      .continue
.drawBg:
    call    DrawBackground_3_Thirds
;.continue:
    ret



NextMegaROMPage:
    ; inc     e   ; next page
    ; ld      a, e
	; ld	    (Seg_P8000_SW), a

    ld      a, (CurrentMegaRomPage)
    inc     a
    ld	    (Seg_P8000_SW), a
    ld	    (CurrentMegaRomPage), a

    ; hl -= TileMapSizeInColumns * 8 * 4
    ld      bc, - TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8 * 4
    add     hl, bc

    ret



; Inputs:
;   (BgCurrentIndex)
;   (BgAddrIndex)
;   (FrameIndex)
; Updates:
;   (BgCurrentIndex)
;   (BgAddrIndex)
ScrollRight:
    ; check if scroll is at limit
    ld      hl, (BgCurrentIndex)
    ld      de, 8 * (TILE_MAP_WIDTH_IN_8X8_COLUMNS - SCREEN_WIDTH_IN_TILES)
    ;call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    or      a                           ; DCOMPR alternative (30 cycles)
    sbc     hl, de
    add     hl, de


    ; code of DCOMPR BIOS routine: (54/48 cycles)
    ; ; call    BIOS_DCOMPR
    ; ld a,h
    ; sub d
    ; ret nz
    ; ld a,l
    ; sub e
    ; ret


    ret     nc                          ; hl >= de


    ; BC = ScrollSpeed; Normal: 1, Fast: 2
    ld      a, (ScrollSpeed)
    ld      b, 0
    ld      c, a


    ; Update X position of sparkles sprite
    ld      a, (Sparkles_X)
    sub     c
    ld      (Sparkles_X), a


    ; Update BgCurrentIndex
    add     hl, bc
    ld      (BgCurrentIndex), hl
    

	; Update BgAddrIndex
    ld	    hl, (BgAddrIndex)
    ; hl = hl + (TileMapSizeInColumns * ScrollSpeed)
    ld      de, TILE_MAP_WIDTH_IN_8X8_COLUMNS
    ld      b, c
.loop:
    add     hl, de
    djnz    .loop    
    ld      (BgAddrIndex), hl


    ; FrameIndex += ScrollSpeed
    ld      de, FrameIndex
    ld      a, (de)
    add     c


    ; if (FrameIndex >= 8) {
    ;   FrameIndex = 0;
    ;   (BgIndexFirstFrame)++;        
    ;   (BgIndex) = (BgIndexFirstFrame);
    ; }
    cp      8
    jp      c, .lessThan8                ; if (a < n)

    ; FrameIndex >= 8:
    ld      hl, (BgAddrIndexFirstFrame)
    inc     hl
    ld      (BgAddrIndexFirstFrame), hl
    ld      (BgAddrIndex), hl

    ; get 3 lower bits of BgCurrentIndex and save it to FrameIndex
    ld      a, (BgCurrentIndex)
    and     0000 0111 b
.lessThan8:
    ld      (de), a                     ; Update FrameIndex
    
    call    DrawBackground_3_Thirds

    ret



ScrollLeft:
    ; check if scroll is at limit
    ; TODO: Fix bug: check if is < 0 (still buggy)
    ld      hl, (BgCurrentIndex)
    ld      a, l
    or      h
    jp      z, .cancel                  ; if (BgCurrentIndex == 0)

    ;ld      de, 0
    ; ld      a, l
    ; or      h
    ; jp      nz, .continue
    ;call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    ;or      a                           ; DCOMPR alternative (30 cycles)
    ;sbc     hl, de
    ;add     hl, de

    ld      a, h
    cp      255
    jp      z, .cancel                  ; if (BgCurrentIndex >= 0xFF00)
    jp      .continue

.cancel:
    ld      hl, 0
    ld      (BgCurrentIndex), hl
    xor     a
    ld      (FrameIndex), a
    call    DrawBackground_3_Thirds
    ret

.continue:

    ; BC = ScrollSpeed; Normal: 1, Fast: 2
    ld      a, (ScrollSpeed)
    ld      b, 0
    ld      c, a


    ; Update X position of sparkles sprite
    ld      a, (Sparkles_X)
    add     c
    ld      (Sparkles_X), a


    ; Update BgCurrentIndex
    or      a
    sbc     hl, bc
    ld      (BgCurrentIndex), hl
    ; dec     hl
    ; ld      (BgCurrentIndex), hl


	; Update BgAddrIndex
	ld	    hl, (BgAddrIndex)
    ; hl = hl - (TileMapSizeInColumns * ScrollSpeed)
    ld      de, - TILE_MAP_WIDTH_IN_8X8_COLUMNS
    ;add     hl, de
    ld      b, c
.loop:
    add     hl, de
    djnz    .loop    
    ld      (BgAddrIndex), hl

    ; FrameIndex -= ScrollSpeed
    ld      de, FrameIndex
    ld      a, (de)
    ;dec     a
    sub     c
    

    ; if (FrameIndex) <= -1 {
    ;   FrameIndex = 7;
    ;   (BgIndexFirstFrame)--;        
    ;   (BgIndex) = (BgIndexFirstFrame) + (TileMapSizeInColumns)*7;
    ; }
    ; cp      -1
    ; jp      nz, .notMinus1

    ; Signed
    ; If A < N, then S and P/V are different.
    ; A >= N, then S and P/V are the same.

    ; TODO: this is so ugly
    cp      -1
    jp      z, .equalOrLessThanMinus1                ; if (a != n)
    cp      -2
    jp      z, .equalOrLessThanMinus1                ; if (a != n)
    jp      .higherThanMinus1

.equalOrLessThanMinus1:
    ; FrameIndex <= -1:
    ld      hl, (BgAddrIndexFirstFrame)
    dec     hl
    ld      (BgAddrIndexFirstFrame), hl
    
    ld      bc, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 7
    add     hl, bc
    ld      (BgAddrIndex), hl

    ; ld      a, 7
    ; get 3 lower bits of BgCurrentIndex and save it to FrameIndex
    ld      a, (BgCurrentIndex)
    and     0000 0111 b
.higherThanMinus1:
    ld      (de), a                     ; Update FrameIndex
    
    call    DrawBackground_3_Thirds

    ret



DrawBackground_1st_Third:
    ; set MegaROM initial page
    ld      a, 1
    ld      (CurrentMegaRomPage), a
    ld	    (Seg_P8000_SW), a
    
    ;ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable
	call    BIOS_SETWRT

            ld	    hl, (BgAddrIndex)

            ; First n lines with unroled OUTI's during Vblank
            ld      d, 8 ; SCROLL_TILE_LINES_DURING_VBLANK
        .loopLines1:
            ; Set the source pointer in RAM
            push    hl

            ld	    a, (BIOS_VDP_DW)
            ld	    c, a
            ; 32 Unrolled OUTIs (use only during v-blank)
            OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI 
            
            ; Update bgIndex to next line
            ; BgIndex += 128 * 8
            pop     hl
            ld      bc, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8
            add     hl, bc

            ; check if line is multiple of 4 (go to next page)
            ld      a, d
            dec     a
            and     0000 0011 b
            call    z, NextMegaROMPage

            dec     d
            jp      nz, .loopLines1
    
    ld	    (BgAddrIndex), hl
    ret

DrawBackground_2nd_Third:
    ld      a, (CurrentMegaRomPage)
    ld	    (Seg_P8000_SW), a

    ;ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable + 256
	call    BIOS_SETWRT

            ld	    hl, (BgAddrIndex)

            ; mid 8 lines with the slower OUTI inside loop after Vblank
            ld      d, 8 ; SCROLL_TILE_LINES_AFTER_VBLANK
        .loopLines2:
            ; Set the source pointer in RAM
            push    hl

            ld	    a, (BIOS_VDP_DW)
            ld	    c, a

                    ld      b, 32
                .loopOUTI:
                    outi
                    jp	    nz, .loopOUTI

            ; Update bgIndex to next line
            ; BgIndex += 128 * 8
            pop     hl
            ld      bc, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8
            add     hl, bc

            ; check if line is multiple of 4 (go to next page)
            ld      a, d
            dec     a
            and     0000 0011 b
            call    z, NextMegaROMPage

            dec     d
            jp      nz, .loopLines2

    ld	    (BgAddrIndex), hl
    ret

DrawBackground_3rd_Third:
    ld      a, (CurrentMegaRomPage)
    ld	    (Seg_P8000_SW), a

    ;ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable + 512
	call    BIOS_SETWRT

            ld	    hl, (BgAddrIndex)

            ; last 8 lines with the slower OUTI inside loop after Vblank
            ld      d, 8 ; SCROLL_TILE_LINES_AFTER_VBLANK
        .loopLines2:
            ; Set the source pointer in RAM
            push    hl

            ld	    a, (BIOS_VDP_DW)
            ld	    c, a

                    ld      b, 32
                .loopOUTI:
                    outi
                    jp	    nz, .loopOUTI

            ; Update bgIndex to next line
            ; BgIndex += 128 * 8
            pop     hl
            ld      bc, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8
            add     hl, bc

            ; check if line is multiple of 4 (go to next page)
            ld      a, d
            dec     a
            and     0000 0011 b
            call    z, NextMegaROMPage

            dec     d
            jp      nz, .loopLines2

    ld	    (BgAddrIndex), hl
    ret