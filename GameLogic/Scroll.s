; Scroll_old:

;     ; search names table buffer looking for tiles 
;     ; other than 0
;     ld      hl, NamesTableBuffer + 512
;     xor     a                           ; same as ld a, 0
;     ld      b, 0                        ; counter
; .loop:
;     or      (hl)
;     jp      z, .next

; .animate:

;     inc     (hl)

; .next:

;     inc     hl
;     djnz    .loop
    
;     ; at each 8 pixel fine scrolls, do a tile scroll
;     ld      a, (BgScrollRegister)
;     inc     a
;     cp      8
;     call    z, ScrollTiles

;     ld      (BgScrollRegister), a

;     ; call    UpdateNamesTable_BackGround
;     ;call    UpdateNamesTable

;     ret

; ScrollTiles:

; ; test only last line

;     ; scroll all tiles
; 	; ld	    hl, (NextBgLineAddr)
; 	ld	    hl, TileMap_LevelTest_Start + SCREEN_HEIGHT_IN_TILES - 1    ; Origin
;     ld      de, NamesTableBuffer + (SCREEN_WIDTH_IN_TILES * 23)         ; Destiny
;     ld      b, SCREEN_WIDTH_IN_TILES - 1
; .loop:
;     ld      a, (hl)
;     ld      (de), a
;     push    bc
;     ld      bc, SCREEN_HEIGHT_IN_TILES
;     add     hl, bc
;     pop     bc
;     inc     de
; ; .loopEnternal:
; ;     jp .loopEnternal
;     djnz    .loop    

;     ;inc     de
;     ld      a, 1
;     ld      (de), a ; load tile in last column


;     ; load next bg line
;     ; ld	    hl, (NextBgLineAddr)
; 	; ld	    bc, 32                                                  ; Block length
;     ; and     a                                                       ; Clear C flag
;     ; sbc     hl, bc
;     ; ld	    (NextBgLineAddr), hl
;     ; ld      de, NamesTableBuffer + SCREEN_WIDTH_IN_TILES            ; Destiny
;     ; ; ldir                                                        ; Copy BC number of bytes from HL to DE
;     ; ; 32 unrolled ldi's (160 less cycles). Made with MSXUtilities
;     ; ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi ldi 

;     ; clear BgScrollRegister when exit subroutine
;     xor     a                                                       ; same as ld a, 0 but faster

;     ret


NextPage:
    inc     e   ; next page
    ld      a, e
	ld	    (Seg_P8000_SW), a

    ; hl -= TileMapSizeInColumns * 8 * 4
    ld      bc, - TileMapSizeInColumns * 8 * 4
    add     hl, bc

    ret



ScrollRight:
    ; check if scroll is at limit
    ld      hl, (BgCurrentIndex)
    ld      de, 8 * (TileMapSizeInColumns - SCREEN_WIDTH_IN_TILES)
    call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
    ;ret     nc

    jp      nc, .setDirectionLeft
    jp      .continue
.setDirectionLeft:
    ld      a, 1
    ld      (ScrollDirection), a
    ret
.continue:



    inc     hl
    ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable
	call    BIOS_SETWRT

            ld	    hl, (BgIndex)
            
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
            ld      bc, TileMapSizeInColumns * 8
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
            ld      bc, TileMapSizeInColumns * 8
            add     hl, bc

            ; check if line is multiple of 4 (go to next page)
            ld      a, d
            dec     a
            and     0000 0011 b
            call    z, NextPage

            dec     d
            jp      nz, .loopLines2



	ld	    hl, (BgIndex)
    ; hl = hl + TileMapSizeInColumns
    ld      de, TileMapSizeInColumns
    add     hl, de
    ld      (BgIndex), hl

    ; inc FrameIndex
    ld      de, FrameIndex
    ld      a, (de)
    inc     a

    ; if (FrameIndex) == 8 {
    ;   FrameIndex = 0;
    ;   (BgIndexFirstFrame)++;        
    ;   (BgIndex) = (BgIndexFirstFrame);
    ; }
    cp      8
    jp      nz, .not8

    ;FrameIndex == 8:
    ld      hl, (BgIndexFirstFrame)
    inc     hl
    ld      (BgIndexFirstFrame), hl
    ld      (BgIndex), hl

    xor     a
.not8:
    ld      (de), a
    
    ;scf                                     ; set carry flag
    ret



ScrollLeft:
    ; check if scroll is at limit
    ld      hl, (BgCurrentIndex)
    ld      de, 0
    call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.

    jp      z, .setDirectionRight
    jp      .continue
.setDirectionRight:
    xor     a
    ld      (ScrollDirection), a
    ret
.continue:



    dec     hl
    ld      (BgCurrentIndex), hl

    ; Sets the VRAM pointer (destiny)
	ld	    hl, NamesTable
	call    BIOS_SETWRT

            ld	    hl, (BgIndex)

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
            ld      bc, TileMapSizeInColumns * 8
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
            ld      bc, TileMapSizeInColumns * 8
            add     hl, bc

            ; check if line is multiple of 4 (go to next page)
            ld      a, d
            dec     a
            and     0000 0011 b
            call    z, NextPage

            dec     d
            jp      nz, .loopLines2



	ld	    hl, (BgIndex)
    ; hl = hl - TileMapSizeInColumns
    ld      de, - TileMapSizeInColumns
    ;or      a                               ; clear carry flag
    ; sbc     hl, de
    add     hl, de
    ld      (BgIndex), hl

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
    ld      hl, (BgIndexFirstFrame)
    dec     hl
    ld      (BgIndexFirstFrame), hl
    
    ld      bc, TileMapSizeInColumns * 7
    add     hl, bc
    ld      (BgIndex), hl

    ld      a, 7
.notMinus1:
    ld      (de), a
    
    ret
