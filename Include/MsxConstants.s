; Screen 2 constants:
SCREEN_WIDTH_IN_TILES:          equ     32
SCREEN_HEIGHT_IN_TILES:         equ     24
SCREEN_WIDTH_IN_PIXELS:         equ     32 * 8
SCREEN_HEIGHT_IN_PIXELS:        equ     24 * 8


; VRAM memory mapping (Screen 2)
NamesTable:	                    equ 6144	; 6 * 1024 - 0x1800 - Base address for names table (6144 to 6911); 256 * 3 = 768 bytes
NamesTable_2:	                equ 7168	; 7 * 1024 - 0x1c00 - Alternative address for names table

PatternsTable_1st_Third:	    equ 0	    ; 0x0000 - Base address for 3 patterns tables (0 to 6143); 256 * 8 * 3 = 6144 bytes
PatternsTable_2nd_Third:	    equ PatternsTable_1st_Third + (256 * 8)
PatternsTable_3rd_Third:	    equ PatternsTable_2nd_Third + (256 * 8)

ColorsTable_1st_Third:	        equ 8192	; 0x2000 - Base address for colors table (8192 to 14335); 256 * 8 * 3 = 6144 bytes
ColorsTable_2nd_Third:	        equ ColorsTable_1st_Third + (256 * 8)
ColorsTable_3rd_Third:	        equ ColorsTable_2nd_Third + (256 * 8)

; Sprite attr table: 6912
; sprite 0:
;     6192 Y
; 	  6193 X
; 	  6194 N
; 	  6195 C
; sprite 1:
;       6196 Y
; (...)

; Sprite formation table: 14336
SpriteAttrTable:                equ 6912	; 0x1b00 - Base address for sprite attributes table (6912 to 7040); 32 * 4 = 128 bytes
SpritePatternTable:             equ 14336	; 0x3800 - Base address for sprite patterns table (14336 to 16383); 256 * 8 = 2048 bytes for 8x8, 64 * 32 = 2048 bytes for 16x16




; MSX1 colors:
COLOR_TRANSPARENT:	equ 0
COLOR_BLACK:		equ 1
COLOR_GREEN:		equ 2
COLOR_LIGHT_GREEN:	equ 3
COLOR_DARK_BLUE:	equ 4
COLOR_BLUE:			equ 5
COLOR_DARK_RED:		equ 6
COLOR_LIGHT_BLUE:	equ 7
COLOR_RED:			equ 8
COLOR_LIGHT_RED:	equ 9
COLOR_DARK_YELLOW:	equ 10
COLOR_YELLOW:		equ 11
COLOR_DARK_GREEN:	equ 12
COLOR_PURPLE:		equ 13
COLOR_GREY:			equ 14
COLOR_WHITE:		equ 15



; -----------------------------------------------------------------------------
; PPI (Programmable Peripheral Interface)
PPI.A: equ $a8 ; PPI port A: primary slot selection register
    ; 33221100: number of slot to select on page n
PPI.B: equ $a9 ; PPI port B: read the keyboard matrix row specified via the PPI port C ($AA)
PPI.C: equ $aa ; PPI port C: control keyboard CAP LED, data recorder signals, and keyboard matrix row
    ; bits 0-3: Row number of specified keyboard matrix to read via port B
    ; bit 4: Data recorder motor (reset to turn on)
    ; bit 5: Set to write on tape
    ; bit 6: Keyboard LED CAPS (reset to turn on)
    ; bit 7: 1, then 0 shortly thereafter to make a clicking sound (used for the keyboard)
PPI.R: equ $ab ; PPI ports control register (write only)
    ; bit 0 = Bit status to change
    ; bit 1-3 = Number of the bit to change at port C of the PPI
    ; bit 4-6 = Unused
    ; bit 7 = Must be always reset on MSX
; -----------------------------------------------------------------------------