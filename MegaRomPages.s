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



; ----------------------------- Mega ROM page for level screen data ----------------
LEVEL_SCREEN_DATA_MEGAROM_PAGE:     equ 17
	org	0x8000, 0xBFFF

    INCLUDE "LevelScreen/Data.s"

	ds PageSize - ($ - 0x8000), 255
