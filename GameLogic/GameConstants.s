
SCROLL_TILE_LINES_DURING_VBLANK:        equ 12
SCROLL_TILE_LINES_AFTER_VBLANK:         equ SCREEN_HEIGHT_IN_TILES - SCROLL_TILE_LINES_DURING_VBLANK


DIRECTION_LEFT:                         equ 2
DIRECTION_RIGHT:                        equ 1

TILE_MAP_WIDTH_IN_8X8_COLUMNS:          equ 512    


PENGUIN_WIDTH:                          equ 16
PENGUIN_HEIGHT:                         equ 16


; Sprite pattern numbers for animation frames:
PENGUIN_RIGHT_STANDING:                 equ 1 * 4
PENGUIN_RIGHT_WALKING_1:                equ 3 * 4
PENGUIN_RIGHT_WALKING_2:                equ 5 * 4
PENGUIN_RIGHT_WALKING_3:                equ 7 * 4
PENGUIN_RIGHT_WALKING_LAST_FRAME:       equ PENGUIN_RIGHT_WALKING_3


; Sprite pattern numbers for diamond disappearing animation frames:
DIAMOND_DISAPPEARING_FIRST_FRAME:       equ 9 * 4
DIAMOND_DISAPPEARING_LAST_FRAME:        equ 17 * 4


; Keyboard constants to current key(s) pressed
; KEY_LEFT:                               equ 1000 0000 b
; KEY_RIGHT:                              equ 0100 0000 b
; KEY_UP:                                 equ 0010 0000 b
; KEY_DOWN:                               equ 0001 0000 b
; KEY_JUMP:                               equ 0000 1000 b
; KEY_RUN:                                equ 0000 0100 b
; KEY_PAUSE:                              equ 0000 0010 b
