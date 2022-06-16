; --------------- Data
SPRITE_ATT_TABLE_FRAME_0:
    ; Y, X, pat, color
    db (192/2)-8, (256/2)-8, 1*4, 4
    db (192/2)-8, (256/2)-8, 2*4, 15
.size: equ $ - SPRITE_ATT_TABLE_FRAME_0

; -----------------------------------------------------------
SPRITE_ATT_TABLE_FRAME_1:
    ; Y, X, pat, color
    db (192/2)-16, (256/2)-16, 1*4, 4
    db (192/2)-16, (256/2)-16, 2*4, 15
.size: equ $ - SPRITE_ATT_TABLE_FRAME_1

; -----------------------------------------------------------
PATTERN_TABLE_FRAME_2:
    INCLUDE "LevelScreen/Data/Frame_2/pattern_table.s"
.size: equ $ - PATTERN_TABLE_FRAME_2

COLOR_TABLE_FRAME_2:
    INCLUDE "LevelScreen/Data/Frame_2/color_table.s"
.size: equ $ - COLOR_TABLE_FRAME_2

NAMES_TABLE_FRAME_2:
    INCLUDE "LevelScreen/Data/Frame_2/names_table.s"
.size: equ $ - NAMES_TABLE_FRAME_2

; -----------------------------------------------------------
PATTERN_TABLE_FRAME_3:
    INCLUDE "LevelScreen/Data/Frame_3/pattern_table.s"
.size: equ $ - PATTERN_TABLE_FRAME_3

COLOR_TABLE_FRAME_3:
    INCLUDE "LevelScreen/Data/Frame_3/color_table.s"
.size: equ $ - COLOR_TABLE_FRAME_3

NAMES_TABLE_FRAME_3:
    INCLUDE "LevelScreen/Data/Frame_3/names_table.s"
.size: equ $ - NAMES_TABLE_FRAME_3
