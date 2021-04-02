InitVram:

	call 	BIOS_DISSCR		; 


    ld 		a, 0
    ld 		(BIOS_CLIKSW), a     ; Key Press Click Switch 0:Off 1:On (1B/RW)

    ; call BIOS_INIGRP        ; Screen 2


; Define screen colors and mode
    ld 		a, COLOR_WHITE       	; Foregoung color
    ld 		(BIOS_FORCLR), a    
    ld 		a, COLOR_BLACK   		; Backgroung color
    ld 		(BIOS_BAKCLR), a     
    ld 		a, COLOR_BLACK       	; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color


; Set screen 2
	ld		a, 2	               	; Screen Mode (0..3 for MSX 1)
    call 	BIOS_CHGMOD        		; 

	call 	BIOS_DISSCR		; 


; Write to VDP register 1 (Set Screen mode, sprites size, Vblank, Display, VRAM mode setting)
; Set it to 225 (‭1110 0001‬ b)
; bit 7: 4/16K selects VRAM configuration. Write 1 if the VDP is not a V9938 nor V9958.
; bit 6: BL disables the screen display when reseted.VDP's commands work a bit faster as well. Screen display is displayed by default.
; bit 5: IE0 enables (1) or disable (0) the vertical retrace interrupts that occur at just after each display of the screen (foreground).
; bit 4: M2 is one of bits that defines the screen mode. (Write 1 to set the SCREEN 3)
; bit 3: M1 is one of bits that defines the screen mode. (Write 1 to set the SCREEN 0)
; bit 2: not used (always 0)
; bit 1: SI defines the sprite size. Write 1 to use 16x16 sprites, 0 to use 8x8 sprites.
; bit 0: MAG enlarges the sprites when 1 is written. (0 by default)
; https://www.msx.org/wiki/VDP_Mode_Registers#Control_Register_1
	ld		c, 1	               		; VDP Register Number (0..27, 32..46)
	ld		b, 1110 0010 b   	        ; Data To Write
    call 	BIOS_WRTVDP        		    ; 



; --------------------------------------------------
	call 	BIOS_DISSCR		; 


	call 	ClearVRAM


    call    LoadTilePatterns
    call    LoadTileColors

    ;call    LoadNamesTableBuffer



    ; Create Sprites
	ld		bc, EndSpritePatterns - StartSpritePatterns ; Block length
	ld		de, SpritePatternTable						; VRAM address
	ld		hl, StartSpritePatterns        				; RAM address
    call 	BIOS_LDIRVM        							; Block transfer to VRAM from memory

    ; Set sprite attributes [debug]
	; Y
    ld	    hl, SpriteAttrTableBuffer                   ; VRAM Address
	; ld	    a, 192-32-1                                 ; Value
	; ld      (hl), a
    ; X
    inc     hl
	; ld	    a, 0                                        ; Value
	; ld      (hl), a
    ; Pattern number
    inc     hl
	ld	    a, 0 * 4                                       ; Value
	ld      (hl), a
    ; Color
    ; inc     hl
	; ld	    a, COLOR_GREEN                              ; Value
	; ld      (hl), a


	call 	BIOS_ENASCR		; 

	ret


LoadTilePatterns:
	; ld	    bc, TilePatterns_End - TilePatterns_Start                               ; Block length
	; ld	    de, PatternsTable_1st_Third                                             ; VRAM Address
	; ld	    hl, TilePatterns_Start                                                  ; RAM Address
    ; call    BIOS_LDIRVM                                                             ; Block transfer to VRAM from memory

	; ld	    bc, TilePatterns_End - TilePatterns_Start                               ; Block length
	; ld	    de, PatternsTable_2nd_Third                                             ; VRAM Address
	; ld	    hl, TilePatterns_Start                                                  ; RAM Address
    ; call    BIOS_LDIRVM                                                             ; Block transfer to VRAM from memory

	; ld	    bc, TilePatterns_End - TilePatterns_Start                               ; Block length
	; ld	    de, PatternsTable_3rd_Third                                             ; VRAM Address
	; ld	    hl, TilePatterns_Start                                                  ; RAM Address
    ; call    BIOS_LDIRVM                                                             ; Block transfer to VRAM from memory


    ld		ix, PatternTableStructure_1st_Third										; Source on RAM (Start)
	ld		iy, PatternTableStructure_1st_Third_End									; Source on RAM (End)
	ld	    de, PatternsTable_1st_Third                                             ; VRAM Address
	call 	LoadTilePatterns_OneThird

    ld		ix, PatternTableStructure_2nd_Third										; Source on RAM (Start)
	ld		iy, PatternTableStructure_2nd_Third_End									; Source on RAM (End)
	ld	    de, PatternsTable_2nd_Third                                             ; VRAM Address
	call 	LoadTilePatterns_OneThird

    ld		ix, PatternTableStructure_3rd_Third										; Source on RAM (Start)
	ld		iy, PatternTableStructure_3rd_Third_End									; Source on RAM (End)
	ld	    de, PatternsTable_3rd_Third                                             ; VRAM Address
	call 	LoadTilePatterns_OneThird

	ret

LoadTilePatterns_OneThird:
.loop:
	; Get start address of patterns
	ld		l, (ix)
	ld		h, (ix + 1)
	
	; Get size in bytes
	ld		c, (ix + 2)
	ld		b, (ix + 3)

	; Do the copy
	push	bc
		push	de
			call    BIOS_LDIRVM                                                             ; Block transfer to VRAM from memory
		pop		hl	; from DE to HL
	pop		bc
	; Update DE (destiny on VRAM to the start of next pattern sequence)
	add		hl, bc
	ex		de, hl

	; Go to next register
	inc		ix
	inc		ix
	inc		ix
	inc		ix

	; Check if passed the end of the source patterns
	push	de
		ld		d, ixh
		ld		e, ixl
		ld		h, d
		ld		l, e
	pop		de
	push	de
		ld		d, iyh
		ld		e, iyl
		call    BIOS_DCOMPR                 ; Compares HL with DE. Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.
	pop		de
	jp		c, .loop

    ret


; TODO: this must be better...
LoadTileColors:
	ld	    de, ColorsTable_1st_Third     	                                        ; VRAM color table start address
	ld	    hl, TileColors_Black_Start                                              ; RAM start address of color pattern (8 bytes)
	ld      a, TilePatterns_Black_SizeInChars          								; number of cells in color table to be filled by the pattern
	call    FillColorTable_3thirds

ColorsTable_Addr_SmallBricks_Top_Start:		equ	ColorsTable_1st_Third + 8
	ld	    de, ColorsTable_Addr_SmallBricks_Top_Start											; VRAM color table start address
	ld	    hl, TileColors_SmallBricks_Top_Start                                    			; RAM start address of color pattern (8 bytes)
	ld      a, 0 + (TilePatterns_SmallBricks_End - TilePatterns_SmallBricks_Start) / 8          ; number of cells in color table to be filled by the pattern
	call    FillColorTable_3thirds
ColorsTable_Addr_SmallBricks_Bottom_Start:	equ	ColorsTable_Addr_SmallBricks_Top_Start + (24*8);(TilePatterns_SmallBricks_Top_SizeInChars * 8)
	ld	    de, ColorsTable_Addr_SmallBricks_Bottom_Start 							; VRAM color table start address
	ld	    hl, TileColors_SmallBricks_Bottom_Start                                 ; RAM start address of color pattern (8 bytes)
	ld      a, 24;ilePatterns_SmallBricks_Bottom_SizeInChars                          ; number of cells in color table to be filled by the pattern
	call    FillColorTable_3thirds



; Filling color table separatly for each third of screen
ColorsTable_Addr_BigBricks_Top_Start_1st_Third:		equ	ColorsTable_Addr_SmallBricks_Bottom_Start + (24*8)
	ld	    de, ColorsTable_Addr_BigBricks_Top_Start_1st_Third									; VRAM color table start address
	ld	    hl, TileColors_BigBricks_Top_Start                                    				; RAM start address of color pattern (8 bytes)
	ld      a, 32                             													; number of cells in color table to be filled by the pattern
	call    FillColorTable
ColorsTable_Addr_BigBricks_Top_Start_2nd_Third:		equ	ColorsTable_Addr_BigBricks_Top_Start_1st_Third + (256*8)
	ld	    de, ColorsTable_Addr_BigBricks_Top_Start_2nd_Third									; VRAM color table start address
	ld	    hl, TileColors_BigBricks_Top_Start                                    				; RAM start address of color pattern (8 bytes)
	ld      a, 32                             													; number of cells in color table to be filled by the pattern
	call    FillColorTable
ColorsTable_Addr_BigBricks_Top_Start_3rd_Third:		equ	ColorsTable_Addr_BigBricks_Top_Start_2nd_Third + (256*8)
	ld	    de, ColorsTable_Addr_BigBricks_Top_Start_3rd_Third									; VRAM color table start address
	ld	    hl, TileColors_Diamonds_Top_Start                                    				; RAM start address of color pattern (8 bytes)
	ld      a, 32                             													; number of cells in color table to be filled by the pattern
	call    FillColorTable



; Filling color table separatly for each third of screen
ColorsTable_Addr_BigBricks_Bottom_Start_1st_Third:		equ	ColorsTable_Addr_BigBricks_Top_Start_1st_Third + (32*8)
	ld	    de, ColorsTable_Addr_BigBricks_Bottom_Start_1st_Third									; VRAM color table start address
	ld	    hl, TileColors_BigBricks_Bottom_Start                                    				; RAM start address of color pattern (8 bytes)
	ld      a, 32                             													; number of cells in color table to be filled by the pattern
	call    FillColorTable
ColorsTable_Addr_BigBricks_Bottom_Start_2nd_Third:		equ	ColorsTable_Addr_BigBricks_Bottom_Start_1st_Third + (256*8)
	ld	    de, ColorsTable_Addr_BigBricks_Bottom_Start_2nd_Third									; VRAM color table start address
	ld	    hl, TileColors_BigBricks_Bottom_Start                                    				; RAM start address of color pattern (8 bytes)
	ld      a, 32                             													; number of cells in color table to be filled by the pattern
	call    FillColorTable
ColorsTable_Addr_BigBricks_Bottom_Start_3rd_Third:		equ	ColorsTable_Addr_BigBricks_Bottom_Start_2nd_Third + (256*8)
	ld	    de, ColorsTable_Addr_BigBricks_Bottom_Start_3rd_Third									; VRAM color table start address
	ld	    hl, TileColors_Diamonds_Bottom_Start                                    				; RAM start address of color pattern (8 bytes)
	ld      a, 32                             													; number of cells in color table to be filled by the pattern
	call    FillColorTable



; ColorsTable_Addr_BigBricks_Bottom_Start:	equ	ColorsTable_Addr_BigBricks_Top_Start_1st_Third + (32*8);(TilePatterns_SmallBricks_Top_SizeInChars * 8)
; 	ld	    de, ColorsTable_Addr_BigBricks_Bottom_Start								; VRAM color table start address
; 	ld	    hl, TileColors_BigBricks_Bottom_Start                                   ; RAM start address of color pattern (8 bytes)
; 	ld      a, 32;TilePatterns_SmallBricks_Bottom_SizeInChars                          ; number of cells in color table to be filled by the pattern
; 	call    FillColorTable_3thirds

ColorsTable_Addr_Grass_Top_Start:		equ	ColorsTable_Addr_BigBricks_Bottom_Start_1st_Third + (32*8);(TilePatterns_SmallBricks_Bottom_SizeInChars * 8)
	ld	    de, ColorsTable_Addr_Grass_Top_Start								; VRAM color table start address
	ld	    hl, TileColors_Grass_Top_Start                                    	; RAM start address of color pattern (8 bytes)
	ld      a, 32;TilePatterns_SmallBricks_Top_SizeInChars                             ; number of cells in color table to be filled by the pattern
	call    FillColorTable_3thirds
ColorsTable_Addr_Grass_Bottom_Start:	equ	ColorsTable_Addr_Grass_Top_Start + (32*8);(TilePatterns_SmallBricks_Top_SizeInChars * 8)
	ld	    de, ColorsTable_Addr_Grass_Bottom_Start								; VRAM color table start address
	ld	    hl, TileColors_Grass_Bottom_Start                                   ; RAM start address of color pattern (8 bytes)
	ld      a, 32;TilePatterns_SmallBricks_Bottom_SizeInChars                          ; number of cells in color table to be filled by the pattern
	call    FillColorTable_3thirds

ColorsTable_Addr_Rocks_Top_Start:		equ	ColorsTable_Addr_Grass_Bottom_Start + (32*8);(TilePatterns_SmallBricks_Bottom_SizeInChars * 8)
	ld	    de, ColorsTable_Addr_Rocks_Top_Start								; VRAM color table start address
	ld	    hl, TileColors_Rocks_Top_Start                                    	; RAM start address of color pattern (8 bytes)
	ld      a, 32;TilePatterns_SmallBricks_Top_SizeInChars                             ; number of cells in color table to be filled by the pattern
	call    FillColorTable_3thirds
ColorsTable_Addr_Rocks_Bottom_Start:	equ	ColorsTable_Addr_Rocks_Top_Start + (32*8);(TilePatterns_SmallBricks_Top_SizeInChars * 8)
	ld	    de, ColorsTable_Addr_Rocks_Bottom_Start								; VRAM color table start address
	ld	    hl, TileColors_Rocks_Bottom_Start                                   ; RAM start address of color pattern (8 bytes)
	ld      a, 32;TilePatterns_SmallBricks_Bottom_SizeInChars                          ; number of cells in color table to be filled by the pattern
	call    FillColorTable_3thirds

    ret

; LoadNamesTableBuffer:
;     ; load first column
;     ld      hl, NamesTableBuffer
;     ld      de, TileMap_LevelTest_Start
;     ld      c, 32

; .loopColumns: 
;     push    hl
;     ld      b, 24

; .loopLines:
;     ld      a, (de)
;     ld      (hl), a

;     inc     de
;     push    bc
;     ld      bc, 32
;     add     hl, bc
;     pop     bc

;     djnz    .loopLines

;     pop     hl
;     inc     hl

;     ;inc     de
;     dec     c
;     jp      nz, .loopColumns

;     ret