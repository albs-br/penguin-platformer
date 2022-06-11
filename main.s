;
; Go Penguin (former Penguin Platformer) for MSX 1
; Andre Baptista (www.andrebaptista.com.br)
; 
; some code from MSXlib basic example
;

FNAME "go-penguin.rom"      ; output file


PageSize:	    equ	0x4000	        ; 16kB
Seg_P8000_SW:	equ	0x7000	        ; Segment switch for page 0x8000-BFFFh (ASCII 16k Mapper)


DEBUG:          equ 255             ; defines debug mode, value is irrelevant (comment it out for production version)

; Compilation address
; TODO: is this final address correct? Souldn't be 0x7fff ?
	org 0x4000, 0xbeff	                    ; 0x8000 can be also used here if Rom size is 16kB or less.
 
    INCLUDE "Include/RomHeader.s"

; Include common routines (~ 1 Kb)
CommonIncludes_Start:
    INCLUDE "Include/MsxBios.s"
    ;INCLUDE "Include/Symbols.s" ; commented out cos it has many names conflicting with other files
    INCLUDE "Include/MsxConstants.s"
    INCLUDE "Include/Vram.s"
    INCLUDE "Include/CommonRoutines.s"
    INCLUDE "Include/Hook.s"
    INCLUDE "Include/CheckCollision.s"
CommonIncludes_Start.size:      equ $ - CommonIncludes_Start

; Include game routines (~ 4.5 Kb)
GameIncludes_Start:
    INCLUDE "GameLogic/GameLogic.s"
    INCLUDE "GameLogic/Objects/Enemies/Enemies_Common.s"
    INCLUDE "GameLogic/Objects/Enemies/Enemy_TypeA_Logic.s"
    INCLUDE "GameLogic/Objects/Enemies/Enemy_TypeB_Logic.s"
    INCLUDE "GameLogic/Objects/SceneryLogic.s"
    INCLUDE "GameLogic/UpdateSpriteAttrTableBuffer.s"
    INCLUDE "GameLogic/ReadInput.s"
    INCLUDE "GameLogic/Scroll.s"
    INCLUDE "GameLogic/CheckBackGround.s"
    INCLUDE "GameLogic/InitVariables.s"
    INCLUDE "GameLogic/LoadLevel.s"
    INCLUDE "GameLogic/GameConstants.s"
    INCLUDE "GameLogic/UpdateBgObjects.s"
    INCLUDE "GameLogic/UpdateAnimations.s"
    INCLUDE "GameLogic/Score.s"
    INCLUDE "GameLogic/SwitchNamesTable.s"
    INCLUDE "GameLogic/CopyEnemyPatternsToVRAM.s"
    INCLUDE "TitleScreen/TitleScreen.s"
    INCLUDE "LevelScreen/LevelScreen.s"
GameIncludes_Start.size:      equ $ - GameIncludes_Start

; Include game data (~ 5.9 Kb)
GameData_Start:
    INCLUDE "Graphics/Sprites/Sprites.s"
    INCLUDE "Graphics/Tiles/Patterns/Patterns.s"
    INCLUDE "Graphics/Tiles/Colors/Colors.s"
    INCLUDE "Graphics/TileMaps/TileMaps_Constants.s"
    INCLUDE "Sound/Sound.s"
    INCLUDE "TitleScreen/Data.s"
GameData_Start.size:      equ $ - GameData_Start

; Program code entry point
Execute:
; init interrupt mode and stack pointer (in case the ROM isn't the first thing to be loaded)
	di                          ; disable interrupts
	im      1                   ; interrupt mode 1
    ld      sp, (BIOS_HIMEM)    ; init SP

    call    ClearRam

    ; call    InitVram

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
 
    ; Get VDP Version (will be used to make unrolled OUTI's if possible)
    call    VDP_GetVersion
    ld      a, (VDP_Version)
    jp      z, .vdpIs9918
    xor     a
    jp      .continue
.vdpIs9918:
    ld      a, 1
.continue:
    ld      (VDP_Is9918), a

    ; TODO: it looks like the turbo is enabled on WSX, but it has no effect over the speed
    call    EnableTurboMode             ; test


TitleScreen:
    call    ShowTitleScreen

InitGame:
    call    InitVram
    ;call    NewGame

    call    InitVariables

    ld      a, 2
    call    LoadLevel

    call    AkgPlayer_InitPlayer
    ;call    AkyPlayer_InitPlayer

    call    DrawBackground_3_Thirds


; Main loop
MainLoop:
    ld      hl, BIOS_JIFFY              ; (v-blank sync)
    ld      a, (hl)
.waitVBlank:
    cp      (hl)
    jr      z, .waitVBlank

    ; ----------------------------------------------------------------

    IFDEF DEBUG
        ; Save Jiffy to check if previous frame ended
        ld      a, (hl)
        ld      (CurrentJiffy), a
    ENDIF    

    ; ----------------------------------------------------------------


    IFDEF DEBUG
        ld 		a, COLOR_RED       	    ; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    


    call    SwitchNamesTable


    call    CopyEnemyPatternsToVRAM



    ; ----------------------------------------------------------------



    IFDEF DEBUG
        ld 		a, COLOR_YELLOW       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

	call	FAST_LDIRVM_SpriteAttrTable

; ----------------------------------------------------------------


    ; this routines uses most of CPU (blue and light blue borders)
    call    DrawStaticBg


; ----------------------------------------------------------------

    IFDEF DEBUG
        ld 		a, COLOR_GREY       	; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF

    call    AkgPlayer_PlayMusic
    ;call    AkyPlayer_PlayMusic


; ----------------------------------------------------------------

    call    ReadInput

; ----------------------------------------------------------------

    
    IFDEF DEBUG
        ld 		a, COLOR_DARK_YELLOW    ; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF    

    call    Score

; ----------------------------------------------------------------

    IFDEF DEBUG
        ld 		a, COLOR_GREY           ; Border color
        ld 		(BIOS_BDRCLR), a    
        call 	BIOS_CHGCLR        		; Change Screen Color
    ENDIF

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

    IFDEF DEBUG
        ; Checks if main loop takes more than one frame to run
        ld      a, (BIOS_JIFFY)
        ld      b, a
        ld      a, (CurrentJiffy)
        cp      b
        call    nz, .frameSkip
    ENDIF


	jp	    MainLoop



.frameSkip:
   
    ld      hl, FramesSkipped
    inc     (hl)

    ret

Finished:
	jr	    Finished	    ; Jump to itself endlessly.


End:

    db      "End ROM started at 0x4000"

	ds PageSize - ($ - 0x4000), 255	; Fill the unused area with 0FFh



; ------------------------------ Mega ROM pages for level tilemap ------------------------------------------


; ---------------------- Test Level 1 -------------------------------
TEST_LEVEL_1_MEGAROM_PAGE:     equ 1

; ------- Page 1 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_1/TileMap_Page_1.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 2 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_1/TileMap_Page_2.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 3 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_1/TileMap_Page_3.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 4 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_1/TileMap_Page_4.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 5 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_1/TileMap_Page_5.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 6 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_1/TileMap_Page_6.s"
	ds PageSize - ($ - 0x8000), 255





; ---------------------- Test Level 2 -------------------------------
TEST_LEVEL_2_MEGAROM_PAGE:     equ 7
; ------- Page 7 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_2/TileMap_Page_1.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 8 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_2/TileMap_Page_2.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 9 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_2/TileMap_Page_3.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 10 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_2/TileMap_Page_4.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 11 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_2/TileMap_Page_5.s"
	ds PageSize - ($ - 0x8000), 255

; ------- Page 12 --------------------------------------
	org	0x8000, 0xBFFF

    INCLUDE "Graphics/TileMaps/TestLevel_2/TileMap_Page_6.s"
	ds PageSize - ($ - 0x8000), 255






; ------------------------------ Mega ROM pages for music ------------------------------------------

AKG_MUSIC_MEGAROM_PAGE:     equ 13
; ------- Page 13 --------------------------------------
	org	0x8000, 0xBFFF

MusicAKG_Start:
    INCLUDE "Sound/playerAKG/disassembled.asm"
MusicAKG_Start.size:      equ $ - MusicAKG_Start

	ds PageSize - ($ - 0x8000), 255


AKY_MUSIC_MEGAROM_PAGE:     equ 14
; ------- Page 14 --------------------------------------
	org	0x8000, 0xBFFF

MusicAKY_Start:
    INCLUDE "Sound/playerAKY/disassembled.asm"
MusicAKY_Start.size:      equ $ - MusicAKY_Start

	ds PageSize - ($ - 0x8000), 255


; ----------------------------- Mega ROM page for some sprites ----------------

; TODO: change this name, as it now has enemies and scenery
SPRITES_ENEMY_TYPE_B_MEGAROM_PAGE:     equ 15
; ------- Page 15 --------------------------------------
	org	0x8000, 0xBFFF

; --------- Type B enemies
    INCLUDE "Graphics/Sprites/Armadillo.s"
    INCLUDE "Graphics/Sprites/Centipede.s"
    INCLUDE "Graphics/Sprites/Dino.s"
    INCLUDE "Graphics/Sprites/Elephant.s"

; --------- Scenery
    INCLUDE "Graphics/Sprites/Bush.s"
    INCLUDE "Graphics/Sprites/Fence.s"

	ds PageSize - ($ - 0x8000), 255



; ----------------------------- Mega ROM page for BgObjects data of levels ----------------
BG_OBJECTS_MEGAROM_PAGE:     equ 16
; ------- Page 16 --------------------------------------
	org	0x8000, 0xBFFF

    ; Each file has 16 screens * 256 bytes = 4096 bytes
    ; Each MegaROM page fits 4 BgObjects files (many more if compacted with pletter/zx0)
    INCLUDE "Graphics/TileMaps/TestLevel_1/BgObjects.s"
    INCLUDE "Graphics/TileMaps/TestLevel_2/BgObjects.s"

	ds PageSize - ($ - 0x8000), 255




; Variables (mapped to RAM memory)
	org     0xc000, 0xe5ff                   ; for machines with 16kb of RAM (use it if you need 16kb RAM, will crash on 8kb machines, such as the Casio PV-7)
	; CAUTION: do not use 0xe000, it causes the game to crash on real machines with some SD mappers
    ;org 0xe000                          ; for machines with 8kb of RAM (use it if you need 8kb RAM or less, will work on any machine)

; use max addr for RAM:
;         ORG  0x4000, 0x7FFF        ; start from 0x4000, warn if exceeding 0x7FFF

RamStart:

    INCLUDE "Ram/BgObjects.s"           ; CAUTION: this must be the first one on RAM, as it is table aligned to 0xC000
    INCLUDE "Ram/Variables.s"
    INCLUDE "Ram/VramBuffers.s"

RamEnd:
