
; SCROLL_TILE_LINES_DURING_VBLANK:        equ 12
; SCROLL_TILE_LINES_AFTER_VBLANK:         equ SCREEN_HEIGHT_IN_TILES - SCROLL_TILE_LINES_DURING_VBLANK


DIRECTION_LEFT:                         equ 2
DIRECTION_RIGHT:                        equ 1

TILE_MAP_WIDTH_IN_8X8_COLUMNS:          equ 512    


PENGUIN_WIDTH:                          equ 16
PENGUIN_HEIGHT:                         equ 16


; Sprite pattern numbers for penguin animation frames:
TEST_SPRITE:                            equ 0 * 4   ; TODO: remove in prod version
PENGUIN_RIGHT_STANDING:                 equ 1 * 4
PENGUIN_RIGHT_WALKING_1:                equ 3 * 4
PENGUIN_RIGHT_WALKING_2:                equ 5 * 4
PENGUIN_RIGHT_WALKING_3:                equ 7 * 4
PENGUIN_RIGHT_WALKING_4:                equ 9 * 4
PENGUIN_RIGHT_WALKING_5:                equ 11 * 4
PENGUIN_RIGHT_WALKING_LAST_FRAME:       equ PENGUIN_RIGHT_WALKING_5
PENGUIN_LEFT_STANDING:                  equ 13 * 4
PENGUIN_LEFT_WALKING_1:                 equ 15 * 4
PENGUIN_LEFT_WALKING_2:                 equ 17 * 4
PENGUIN_LEFT_WALKING_3:                 equ 19 * 4
PENGUIN_LEFT_WALKING_LAST_FRAME:        equ PENGUIN_LEFT_WALKING_3

; These frames must be the last of the penguin frames
PENGUIN_TURNING_LEFT_TO_RIGHT_0:                 equ 21 * 4
PENGUIN_TURNING_LEFT_TO_RIGHT_1:                 equ 23 * 4
PENGUIN_TURNING_LEFT_TO_RIGHT_2:                 equ 25 * 4
PENGUIN_TURNING_LEFT_TO_RIGHT_3:                 equ 27 * 4
PENGUIN_TURNING_LEFT_TO_RIGHT_LAST_FRAME:        equ PENGUIN_TURNING_LEFT_TO_RIGHT_3


; Sprite pattern numbers for sparkles animation frames:
SPARKLES_FIRST_FRAME:       equ 29 * 4
SPARKLES_LAST_FRAME:        equ 37 * 4


; Sprite pattern numbers for sparkles animation frames:
HIT_FLASH_FIRST_FRAME:      equ 38 * 4
HIT_FLASH_LAST_FRAME:       equ 41 * 4


; Sprite patterns for enemies

; Ladybug
LADYBUG_SPRITE_LEFT:        equ 42 * 4
LADYBUG_SPRITE_RIGHT:       equ 43 * 4

; Snail
SNAIL_SPRITE_LEFT:          equ 44 * 4
SNAIL_SPRITE_RIGHT:         equ 45 * 4



; Test Score
TEST_PENGUIN_FACE_BLUE:                 equ 46 * 4
TEST_PENGUIN_FACE_WHITE:                equ 47 * 4
TEST_NUMBER_0_BIG:                      equ 48 * 4
TEST_SCORE_DOWN_LEFT:                   equ 49 * 4
TEST_SCORE_DOWN_RIGHT:                  equ 50 * 4


; ------------ Enemies type B
; Armadillo
ARMADILLO_1ST_SPRITE_LEFT:              equ 51 * 4
ARMADILLO_2ND_SPRITE_LEFT:              equ 52 * 4
ARMADILLO_3RD_SPRITE_LEFT:              equ 53 * 4
ARMADILLO_1ST_SPRITE_RIGHT:             equ 54 * 4
ARMADILLO_2ND_SPRITE_RIGHT:             equ 55 * 4
ARMADILLO_3RD_SPRITE_RIGHT:             equ 56 * 4

; Centipede
CENTIPEDE_1ST_SPRITE_LEFT:              equ 57 * 4
CENTIPEDE_2ND_SPRITE_LEFT:              equ 58 * 4
CENTIPEDE_3RD_SPRITE_LEFT:              equ 59 * 4
CENTIPEDE_1ST_SPRITE_RIGHT:             equ 60 * 4
CENTIPEDE_2ND_SPRITE_RIGHT:             equ 61 * 4
CENTIPEDE_3RD_SPRITE_RIGHT:             equ 62 * 4



; Keyboard constants to current key(s) pressed
; KEY_LEFT:                               equ 1000 0000 b
; KEY_RIGHT:                              equ 0100 0000 b
; KEY_UP:                                 equ 0010 0000 b
; KEY_DOWN:                               equ 0001 0000 b
; KEY_JUMP:                               equ 0000 1000 b
; KEY_RUN:                                equ 0000 0100 b
; KEY_PAUSE:                              equ 0000 0010 b

