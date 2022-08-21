DrawBackground_3_Thirds:

    IFDEF DEBUG
        ld 		a, COLOR_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    call    DrawBackground_3_Thirds_New



    IFDEF DEBUG
        ld 		a, COLOR_LIGHT_BLUE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    ; reset some variables of objects (enemies and scenery)
    call    InitObjectsVariables

    call    UpdateBgObjects

    ret



; TODO: Refactor HERE! These names and code flow are terrible
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



    ; Adjust FrameIndex when ScrollSpeed = 2 (running)
    ; to fix bug (screen corrupted when running and changing direction left/right fast)
    ; if(FrameIndex is odd) ScrollSpeed = 1
    ld      a, (FrameIndex)
    bit     0, a
    jp      nz, .frameIndexIsOdd
    jp      .frameIndexIsEven
.frameIndexIsOdd:
    ld      a, 1
    ld      (ScrollSpeed), a
.frameIndexIsEven:



    ; BC = ScrollSpeed; Normal: 1, Fast: 2
    ld      a, (ScrollSpeed)
    ld      b, 0
    ld      c, a



    ld      d, c
        ; Invert signal of C
        ld      a, c
        neg
        ld      c, a

        call    UpdateSpritesX
    ld      c, d




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
    ;   FrameIndex = 0;  // only for speed normal, speed 2x must get 3 lower bits of BgCurrentIndex
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


    call    UpdateSpritesX


    ; Update BgCurrentIndex
    or      a
    sbc     hl, bc
    ld      (BgCurrentIndex), hl
    ; dec     hl
    ; ld      (BgCurrentIndex), hl


	; Update BgAddrIndex
	ld	    hl, (BgAddrIndex)
    ; hl = hl - (TileMapSizeInColumns * ScrollSpeed)
    ld      de, TILE_MAP_WIDTH_IN_8X8_COLUMNS
    ;add     hl, de
    ld      b, c
.loop:
    or      a
    sbc     hl, de
    ;add     hl, de
    djnz    .loop    
    ld      (BgAddrIndex), hl

    ; FrameIndex -= ScrollSpeed
    ld      de, FrameIndex
    ld      a, (de)
    ;dec     a
    sub     c
    

    ; if (FrameIndex) <= -1 {
    ;   FrameIndex = 7;  // only for speed normal, speed 2x must get 3 lower bits of BgCurrentIndex
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

    ; FrameIndex = 7
    ;ld      a, 7
    
    ; get 3 lower bits of BgCurrentIndex and save it to FrameIndex
    ld      a, (BgCurrentIndex)
    and     0000 0111 b
.higherThanMinus1:
    ld      (de), a                     ; Update FrameIndex
    
    call    DrawBackground_3_Thirds

    ret


SCROLL_TILE_LINES_DURING_VBLANK:        equ 8
SCROLL_TILE_LINES_AFTER_VBLANK:         equ 24 - SCROLL_TILE_LINES_DURING_VBLANK

DrawBackground_3_Thirds_New:
    ; set MegaROM initial page
    ; ld      a, 1
    ld      a, (CurrentLevel_InitialMegaRomPage)
    ld      (CurrentMegaRomPage), a
    ld	    (Seg_P8000_SW), a
    
    ;ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, (CurrentNamesTable)
    call    BIOS_SETWRT
    
            ld	    hl, (BgAddrIndex)

            ; First n lines with unroled OUTI's during Vblank
            ld      d, SCROLL_TILE_LINES_DURING_VBLANK
        .loopLines1:
            ; Set the source pointer in RAM
            push    hl

            ld	    a, (BIOS_VDP_DW)
            ld	    c, a
            ; 32 Unrolled OUTIs (use only during v-blank)
            OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI 
            ;     ld      b, 32
            ; .loopOUTI_1:
            ;     outi
            ;     jp	    nz, .loopOUTI_1
            
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
    

            ld	    hl, (BgAddrIndex)

            ; last n lines with the slower OUTI inside loop after Vblank
            ld      d, SCROLL_TILE_LINES_AFTER_VBLANK
        .loopLines2:
            ; Set the source pointer in RAM
            push    hl

            ld	    a, (BIOS_VDP_DW)
            ld	    c, a

            ; if MSX 2 or over use unrolled OUTIs
            ; ld      a, (MSXID3) ; MSX version number ; 0 = MSX 1 ; 1 = MSX 2 ; 2 = MSX 2+ ; 3 = MSX turbo R
            ; or      a
            ; jp      z, .isMSX1
            
            ; Check VDP is better than checking MSX version, because there are some MSX's 1 with 9938 VDP (e.g. Yamaha CX11)
            ld      a, (VDP_Is9918) ; 1 = 9918 ; 0 = other VDPs
            or      a
            jp      nz, .isMSX1


            ; 32 Unrolled OUTIs (use only during v-blank OR if MSX version >= 2)
            OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI 
            jp      .continue_1

            .isMSX1:
                    ld      b, 32
                .loopOUTI:
                    outi
                    jp	    nz, .loopOUTI


            .continue_1:


            ; ------------------- 2nd BG layer logic (bad logic, also uses a lt of cycles)
            
            ; ;push    de
            ;     ; HL -= 32
            ;     ld      bc, 32
            ;     or      a       ; Clear carry
            ;     sbc     hl, bc  ; HL = HL - BC

            ;     ld	    a, (BIOS_VDP_DW)
            ;     ld	    c, a

            ;     ; loop through 32 HL's
            ;     ld      b, 32
            ;     .loop_Bg2nLayer:
            ;         ; if ((HL) == 0 && has2ndBgTile)
            ;         ld      a, (hl)
            ;         or      a
            ;         jp      nz, .skip_Bg2nLayer

            ;         ; if (B == 24)
            ;         ld      a, b
            ;         cp      24
            ;         jp      nz, .skip_Bg2nLayer

            ;         ld      a, 10
            ;         out     (c), a

            ;         .skip_Bg2nLayer:
            ;             inc     hl
            ;     djnz    .loop_Bg2nLayer
            ; ;pop     de            

            ; ------------------- 

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

    ret


; Updates the X coord of the sprites, to compensate for scrolling
; Input:
;   C: pixels to move, e.g.: 1, 2, -1, or -2
UpdateSpritesX:
    ; Update X position of sparkles sprite
    ld      a, (Sparkles_X)
    add     c
    ld      (Sparkles_X), a

    ; Update X position of hit flash sprite
    ld      a, (HitFlash_X)
    add     c
    ld      (HitFlash_X), a

    ret