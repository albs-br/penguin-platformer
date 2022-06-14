; Set up VRAM for normal gameplay
InitVram:

    call    BasicInitScreen2


    call    LoadTilePatterns
    call    LoadTileColors



    ; Create Sprites
	ld		hl, SpritePatterns        				; RAM address (source)
	ld		de, SpritePatternTable					; VRAM address (destiny)
	ld		bc, SpritePatterns.size					; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ; ; Set sprite attributes [debug]
	; ; Y
    ; ld	    hl, SpriteAttrTableBuffer                   ; VRAM Address
	; ; ld	    a, 192-32-1                                 ; Value
	; ; ld      (hl), a
    ; ; X
    ; inc     hl
	; ; ld	    a, 0                                        ; Value
	; ; ld      (hl), a
    ; ; Pattern number
    ; inc     hl
	; ld	    a, 0 * 4                                       ; Value
	; ld      (hl), a
    ; ; Color
    ; ; inc     hl
	; ; ld	    a, COLOR_GREEN                              ; Value
	; ; ld      (hl), a


	call 	BIOS_ENASCR		; 

	ret


LoadTilePatterns:
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

	; Load tile for score (penguin face details)
	ld	    bc, TilePatterns_Score_PenguinFace.size    								; Block length
	ld	    de, PatternsTable_1st_Third + (TILE_PENGUIN_FACE_DETAILS * 8)           ; VRAM Address
	ld	    hl, TilePatterns_Score_PenguinFace                                      ; RAM Address
    call    BIOS_LDIRVM                                                             			; Block transfer to VRAM from memory


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






LoadTileColors:

    ld		ix, ColorTableStructure_1st_Third										; Source on RAM (Start)
	ld		iy, ColorTableStructure_1st_Third_End									; Source on RAM (End)
	ld	    de, ColorsTable_1st_Third                                             	; VRAM Address
	call	LoadTileColors_OneThird

    ld		ix, ColorTableStructure_2nd_Third										; Source on RAM (Start)
	ld		iy, ColorTableStructure_2nd_Third_End									; Source on RAM (End)
	ld	    de, ColorsTable_2nd_Third                                             	; VRAM Address
	call	LoadTileColors_OneThird

    ld		ix, ColorTableStructure_3rd_Third										; Source on RAM (Start)
	ld		iy, ColorTableStructure_3rd_Third_End									; Source on RAM (End)
	ld	    de, ColorsTable_3rd_Third                                             	; VRAM Address
	call	LoadTileColors_OneThird

	; Load colors for score (penguin face details)
	ld	    bc, 8    																			; Block length
	ld	    de, ColorsTable_1st_Third + (TILE_PENGUIN_FACE_DETAILS * 8)                                  				; VRAM Address
	ld	    hl, TileColors_Score_PenguinFace_Start                                         		; RAM Address
    call    BIOS_LDIRVM                                                             			; Block transfer to VRAM from memory

	ret

LoadTileColors_OneThird:
.loop:
	; Get start address of colors
	ld		l, (ix)
	ld		h, (ix + 1)
	
	; Get size in chars
	ld		a, (ix + 2)

	; Do the copy
	;push	bc
		push	de
			call    FillColorTable
		pop		hl	; from DE to HL
	;pop		bc

	; Get size in chars
	ld		c, (ix + 2)
	ld		b, (ix + 3)

	; Multiply by 8 to get the size in bytes
    sla 	c
    rl		b
    sla 	c
    rl		b
    sla 	c
    rl		b

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


SetNameTable_1:
; Write to VDP register 2 (determines the base address of the Name Table which constitutes the foreground.)
; Screen 2: set it to 6144 (1024 x 6)
	ld	c, 2	               		; VDP Register Number (0..27, 32..46)
	ld	b, 6	               		; Data To Write
    call BIOS_WRTVDP        		; Block transfer to VRAM from memory
	ret

SetNameTable_2:
; Write to VDP register 2 (determines the base address of the Name Table which constitutes the foreground.)
; Screen 2: set it to 7168 (1024 x 7)
	ld	c, 2	               		; VDP Register Number (0..27, 32..46)
	ld	b, 7	               		; Data To Write
    call BIOS_WRTVDP        		; Block transfer to VRAM from memory
	ret



BasicInitScreen2:
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

    ret