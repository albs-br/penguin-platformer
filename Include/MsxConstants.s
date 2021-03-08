; Screen 2 constants:
SCREEN_WIDTH_IN_TILES:          equ     32
SCREEN_HEIGHT_IN_TILES:         equ     24
SCREEN_WIDTH_IN_PIXELS:         equ     32 * 8
SCREEN_HEIGHT_IN_PIXELS:        equ     24 * 8


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