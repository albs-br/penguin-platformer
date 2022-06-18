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
; Data common to frames 3 onwards
PATTERN_TABLE_FRAME_3_AND_ABOVE:
    INCLUDE "LevelScreen/Data/Common/pattern_table.s"
.size: equ $ - PATTERN_TABLE_FRAME_3_AND_ABOVE

COLOR_TABLE_FRAME_3_AND_ABOVE:
    INCLUDE "LevelScreen/Data/Common/color_table.s"
.size: equ $ - COLOR_TABLE_FRAME_3_AND_ABOVE
; -----------------------------------------------------------
NAMES_TABLE_FRAME_3:
    INCLUDE "LevelScreen/Data/Frame_3/names_table.s"
.size: equ $ - NAMES_TABLE_FRAME_3
; -----------------------------------------------------------
NAMES_TABLE_FRAME_4:
    INCLUDE "LevelScreen/Data/Frame_4/names_table.s"
.size: equ $ - NAMES_TABLE_FRAME_4
; -----------------------------------------------------------
NAMES_TABLE_FRAME_5:
    INCLUDE "LevelScreen/Data/Frame_5/names_table.s"
.size: equ $ - NAMES_TABLE_FRAME_5
