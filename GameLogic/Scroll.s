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



NextPage:
    inc     e   ; next page
    ld      a, e
	ld	    (Seg_P8000_SW), a

    ; hl -= TileMapSizeInColumns * 8 * 4
    ld      bc, - TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8 * 4
    add     hl, bc

    ret


DrawBackground_3_Thirds:
    ; set MegaROM initial page
    ld      e, 1
    ld      a, e
    ld	    (Seg_P8000_SW), a

    call    DrawBackground_1st_Third

    IFDEF DEBUG
        ld 		a, COLOR_LIGHT_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    call    DrawBackground_2nd_Third

    IFDEF DEBUG
        ld 		a, COLOR_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    call    DrawBackground_3rd_Third

    ret


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

    ; TODO: this is only for automatic scrolling - not for actual game
;     jp      nc, .setDirectionLeft
;     jp      .continue
; .setDirectionLeft:
;     xor     a ; ld      a, 1                    
;     ld      (ScrollDirection), a
;     ret
; .continue:


    ; TODO: 1x or 2x speed here
    ; Update X position of sparkles sprite
    ld      a, (Sparkles_X)
    dec     a
    ld      (Sparkles_X), a


; TODO: 1x or 2x speed here (it's bugged)
    inc     hl
    ld      a, (ScrollSpeed)
    or      a
    jp      z, .normalSpeed
    inc     hl
.normalSpeed:
    ld      (BgCurrentIndex), hl
    
    call    DrawBackground_3_Thirds

; TODO: 1x or 2x speed here (it's bugged)
	ld	    hl, (BgAddrIndex)
    ; hl = hl + TileMapSizeInColumns
    ld      de, TILE_MAP_WIDTH_IN_8X8_COLUMNS
    add     hl, de

    ld      a, (ScrollSpeed)
    or      a
    jp      z, .normalSpeed_1
    add     hl, de
.normalSpeed_1:

    ld      (BgAddrIndex), hl

; TODO: 1x or 2x speed here (it's bugged)
    ; inc FrameIndex
    ld      de, FrameIndex

    ld      a, (ScrollSpeed)
    or      a
    ld      a, (de)
    jp      z, .normalSpeed_2
    inc     a
.normalSpeed_2:
    inc     a

    ; if (FrameIndex >= 8) {
    ;   FrameIndex = 0;
    ;   (BgIndexFirstFrame)++;        
    ;   (BgIndex) = (BgIndexFirstFrame);
    ; }
    cp      8
    ;jp      nz, .not8
    jp      c, .lessThan8                ; if (a < n)

    ;FrameIndex >= 8:
    ld      hl, (BgAddrIndexFirstFrame)
    inc     hl
    ld      (BgAddrIndexFirstFrame), hl
    ld      (BgAddrIndex), hl

    xor     a
.lessThan8:
    ld      (de), a
    
    ret



ScrollLeft:
    ; check if scroll is at limit
    ld      hl, (BgCurrentIndex)
    ld      a, l
    or      h
    jp      nz, .continue

    call    DrawBackground_3_Thirds
    ret
    ;ld      de, 8 * (TILE_MAP_WIDTH_IN_8X8_COLUMNS - SCREEN_WIDTH_IN_TILES) ; 0
    ;call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    ; ret     nc
;     jp      c, .resetBgCurrentIndex
;     jp      .continue

; .resetBgCurrentIndex:
;     ld      hl, 0
;     ld      (BgCurrentIndex), hl

    ; TODO: this is only for automatic scrolling - not for actual game
;     jp      nc, .setDirectionRight
;     jp      .continue
; .setDirectionRight:
;     xor     a ; ld      a, 2
;     ld      (ScrollDirection), a
;     ret
;.continue:

.continue:

    dec     hl
    ld      (BgCurrentIndex), hl

    call    DrawBackground_3_Thirds

	ld	    hl, (BgAddrIndex)
    ; hl = hl - TileMapSizeInColumns
    ld      de, - TILE_MAP_WIDTH_IN_8X8_COLUMNS
    ;or      a                               ; clear carry flag
    ; sbc     hl, de
    add     hl, de
    ld      (BgAddrIndex), hl

    ; dec FrameIndex
    ld      de, FrameIndex
    ld      a, (de)
    dec     a

    ; if (FrameIndex) == -1 {
    ;   FrameIndex = 7;
    ;   (BgIndexFirstFrame)--;        
    ;   (BgIndex) = (BgIndexFirstFrame) + (TileMapSizeInColumns)*7;
    ; }
    cp      -1
    jp      nz, .notMinus1

;  
    ;FrameIndex == -1:
    ld      hl, (BgAddrIndexFirstFrame)
    dec     hl
    ld      (BgAddrIndexFirstFrame), hl
    
    ld      bc, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 7
    add     hl, bc
    ld      (BgAddrIndex), hl

    ld      a, 7
.notMinus1:
    ld      (de), a
    
    ret



DrawBackground_1st_Third:
    ;ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable
	call    BIOS_SETWRT

            ld	    hl, (BgAddrIndex)

            ; ; set MegaROM initial page
            ; ld      e, 1                    
            ; ld      a, e
	        ; ld	    (Seg_P8000_SW), a

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
            call    z, NextPage

            dec     d
            jp      nz, .loopLines1
    
    ld	    (BgAddrIndex), hl
    ret

DrawBackground_2nd_Third:
    ;ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable + 256
	call    BIOS_SETWRT

            ld	    hl, (BgAddrIndex)

            ; set MegaROM initial page
            ; ld      e, 1                    
            ; ld      a, e
	        ; ld	    (Seg_P8000_SW), a

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
            call    z, NextPage

            dec     d
            jp      nz, .loopLines2

    ld	    (BgAddrIndex), hl
    ret

DrawBackground_3rd_Third:
    ;ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable + 512
	call    BIOS_SETWRT

            ld	    hl, (BgAddrIndex)

            ; set MegaROM initial page
            ; ld      e, 1                    
            ; ld      a, e
	        ; ld	    (Seg_P8000_SW), a

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
            call    z, NextPage

            dec     d
            jp      nz, .loopLines2

    ld	    (BgAddrIndex), hl
    ret