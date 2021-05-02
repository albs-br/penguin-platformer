;
; Penguin Platformer for MSX 1
; Andre Baptista (www.andrebaptista.com.br)
; 
; some code from MSXlib basic example
;

FNAME "penguin-platformer.rom"      ; output file


PageSize:	    equ	0x4000	        ; 16kB
Seg_P8000_SW:	equ	0x7000	        ; Segment switch for page 8000h-BFFFh (ASCII 16k Mapper)


DEBUG:          equ 255             ; defines debug mode, value is irrelevant (comment it out for production version)

; Compilation address
	org 0x4000, 0xbeff	                    ; 0x8000 can be also used here if Rom size is 16kB or less.
 
    INCLUDE "Include/RomHeader.s"

; Include common routines
CommonIncludes_Start:
    INCLUDE "Include/MsxBios.s"
    INCLUDE "Include/MsxConstants.s"
    INCLUDE "Include/Vram.s"
    INCLUDE "Include/CommonRoutines.s"
    INCLUDE "Include/Hook.s"
    INCLUDE "Include/CheckCollision.s"
CommonIncludes_Size:    equ $ - CommonIncludes_Start

; Include game routines
GameIncludes_Start:
    INCLUDE "GameLogic/GameLogic.s"
    INCLUDE "GameLogic/UpdateSpriteAttrTableBuffer.s"
    INCLUDE "GameLogic/ReadInput.s"
    INCLUDE "GameLogic/Scroll.s"
    INCLUDE "GameLogic/CheckBackGround.s"
    INCLUDE "GameLogic/InitVariables.s"
    INCLUDE "GameLogic/GameConstants.s"
    INCLUDE "GameLogic/UpdateBgObjects.s"
    INCLUDE "GameLogic/UpdateAnimations.s"
GameIncludes_Size:      equ $ - GameIncludes_Start

; Include game data
GameData_Start:
    INCLUDE "Graphics/Sprites/Sprites.s"
    INCLUDE "Graphics/Tiles/Patterns/Patterns.s"
    INCLUDE "Graphics/Tiles/Colors/Colors.s"
    INCLUDE "Graphics/TileMaps/BgObjects.s"
    INCLUDE "Sound/Sound.s"
GameData_Size:          equ $ - GameData_Start

; Program code entry point
Execute:
; init interrupt mode and stack pointer (in case the ROM isn't the first thing to be loaded)
	di                          ; disable interrupts
	im      1                   ; interrupt mode 1
    ld      sp, (BIOS_HIMEM)    ; init SP

    call    ClearRam

    call    InitVram

    call    EnableRomPage2

	; enable page 1
    ld	    a, 1
	ld	    (Seg_P8000_SW), a

; Install the interrupt routine
	di
	ld	    a, 0xc3 ; opcode for "JP nn"
	ld	    (HTIMI), a
	ld	    hl, HOOK
	ld	    (HTIMI + 1), hl
	ei
 
InitGame:
    ;call    NewGame

    call    InitVariables

    call    DrawBackground_3_Thirds

; Main loop
MainLoop:
	halt			                    ; (v-blank sync)

    
    
    ; [debug]
    ; Check if previous frame ended
    ld      a, (IsProcessingFrame)
    or      a
    jp      nz, .frameSkip

    inc     a
    ld      (IsProcessingFrame), a



    IFDEF DEBUG
        ld 		a, COLOR_YELLOW       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

	call	FAST_LDIRVM_SpriteAttrTable

; ----------------------------------------------------------------


    call    DrawStaticBg

; ----------------------------------------------------------------


    IFDEF DEBUG
        ld 		a, COLOR_GREY           ; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF


    ; call    UpdateBgObjects_SetupVariables
    ; call    UpdateBgObjects_Execute

    call    UpdateAnimations

; ----------------------------------------------------------------

    IFDEF DEBUG
        ld 		a, COLOR_LIGHT_GREEN    ; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF

	call	GameLogic


; ----------------------------------------------------------------


    IFDEF DEBUG
        ld 		a, COLOR_PURPLE       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    



    xor     a
    ld      (IsProcessingFrame), a


	jp	    MainLoop



.frameSkip:
    call    BIOS_BEEP
    
    ld 		a, COLOR_WHITE       	; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color
    
    di
    halt
    
    jp      .frameSkip              ; eternal loop

Finished:
	jr	    Finished	    ; Jump to itself endlessly.


End:

	ds PageSize - ($ - 4000h), 255	; Fill the unused area with 0FFh



; ------- Page 1 --------------------------------------
	org	8000h, 0BFFFh

TileMap_LevelTest_Start:
    INCLUDE "Graphics/TileMaps/TileMap_Page_1.s"
	ds PageSize - ($ - 8000h), 255

; ------- Page 2 --------------------------------------
	org	8000h, 0BFFFh

    INCLUDE "Graphics/TileMaps/TileMap_Page_2.s"
	ds PageSize - ($ - 8000h), 255

; ------- Page 3 --------------------------------------
	org	8000h, 0BFFFh

    INCLUDE "Graphics/TileMaps/TileMap_Page_3.s"
	ds PageSize - ($ - 8000h), 255

; ------- Page 4 --------------------------------------
	org	8000h, 0BFFFh

    INCLUDE "Graphics/TileMaps/TileMap_Page_4.s"
	ds PageSize - ($ - 8000h), 255

; ------- Page 5 --------------------------------------
	org	8000h, 0BFFFh

    INCLUDE "Graphics/TileMaps/TileMap_Page_5.s"
	ds PageSize - ($ - 8000h), 255

; ------- Page 6 --------------------------------------
	org	8000h, 0BFFFh

    INCLUDE "Graphics/TileMaps/TileMap_Page_6.s"
	ds PageSize - ($ - 8000h), 255





; Variables (mapped to RAM memory)
	org     0xc000, 0xefff                   ; for machines with 16kb of RAM (use it if you need 16kb RAM, will crash on 8kb machines, such as the Casio PV-7)
	; CAUTION: do not use 0xe000, it causes the game to crash on real machines with some SD mappers
    ;org 0xe000                          ; for machines with 8kb of RAM (use it if you need 8kb RAM or less, will work on any machine)

; use max addr for RAM:
;         ORG  4000h,7FFFh        ; start from 4000h, warn if exceeding 7FFFh

RamStart:

    INCLUDE "Ram/Variables.s"
    INCLUDE "Ram/VramBuffers.s"

RamEnd:
