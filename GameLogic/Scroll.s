NextPage:
    inc     e   ; next page
    ld      a, e
	ld	    (Seg_P8000_SW), a

    ; hl -= TileMapSizeInColumns * 8 * 4
    ld      bc, - TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8 * 4
    add     hl, bc

    ret


DrawScreen:
    ld      hl, (BgCurrentIndex)
    call    DrawBackground
    ret


ScrollRight:
    ; check if scroll is at limit
    ld      hl, (BgCurrentIndex)
    ld      de, 8 * (TILE_MAP_WIDTH_IN_8X8_COLUMNS - SCREEN_WIDTH_IN_TILES)
    call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
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
    inc     hl
    ld      a, (ScrollSpeed)
    or      a
    jp      z, .normalSpeed
    inc     hl
.normalSpeed:
    
    call    DrawBackground

; TODO: 1x or 2x speed here
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

; TODO: 1x or 2x speed here
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
    
    ;scf                                     ; set carry flag
    ret



ScrollLeft:
    ; check if scroll is at limit
    ld      hl, (BgCurrentIndex)
    ld      a, l
    or      h
    jp      nz, .continue

    call    DrawScreen
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

    call    DrawBackground

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



DrawBackground:
    ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable
	call    BIOS_SETWRT

            ld	    hl, (BgAddrIndex)

            ; set MegaROM initial page
            ld      e, 1                    
            ld      a, e
	        ld	    (Seg_P8000_SW), a

            ; First n lines with unroled OUTI's during Vblank
            ld      d, SCROLL_TILE_LINES_DURING_VBLANK
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



            ; last 24-n lines with the slower OUTI inside loop after Vblank
            ld      d, SCROLL_TILE_LINES_AFTER_VBLANK
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

    ret