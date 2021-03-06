
SCROLL_TILE_LINES_DURING_VBLANK:        equ 16
SCROLL_TILE_LINES_AFTER_VBLANK:         equ SCREEN_HEIGHT_IN_TILES - SCROLL_TILE_LINES_DURING_VBLANK


SCROLL_DIRECTION_LEFT:                  equ 2
SCROLL_DIRECTION_RIGHT:                 equ 1

TILE_MAP_WIDTH_IN_8X8_COLUMNS:          equ 512    


; Sprite pattern numbers for animation frames:
PENGUIN_RIGHT_STANDING:                 equ 1 * 4
PENGUIN_RIGHT_WALKING_1:                equ 3 * 4
PENGUIN_RIGHT_WALKING_2:                equ 5 * 4
PENGUIN_RIGHT_WALKING_3:                equ 7 * 4
PENGUIN_RIGHT_WALKING_LAST_FRAME:       equ PENGUIN_RIGHT_WALKING_3