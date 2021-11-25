; ----------------------- Format:

;       column position (1-255), based on 16x16 tiles; 0 is forbidden

;       object tile first frame number (254 or 255 = enemy)

;       row number in pixels (same as Y coord): n * 2 * 8, n is row number (0-11), based on 16x16 tiles

;       state: enabled: 1; disabled: 0; > 1 : animation for enemy dying

; -- these properties are only for enemies type A/B:
;       x offset (0-15)
;       enemy type (bit 7: 0-facing left; 1-facing right)
;       y coord 2nd sprite (usually the same as Y coord MINUS a few pixels)
;       y coord 3rd sprite (usually the same as Y coord PLUS a few pixels)

        ;                   Y position (used to make it possible 3-color sprites with only 2 at any given line)
        ; First sprite:     0 px (main sprite)
        ; Second sprite:   +m px
        ; Third sprite:    -n px

        ; Patterns loaded flag (zero until enemy shows on screen, after 1); only used on Type B enemy
        ; not used
        ; not used
        ; not used

; ENEMY_TYPE_B (enemies of same number cannot be together on same screen):
; 	1: Armadillo / Dino
; 	2: Centipede / Elephant


DIAMOND_FIRST_TILE:             equ 184 - 7 - 24

; test objects, just to show it's possible to use objects other than diamonds
OTHER_OBJECT:                   equ DIAMOND_FIRST_TILE - 64
ANOTHER_OBJECT:                 equ DIAMOND_FIRST_TILE - 128

ENEMY_TYPE_A:                   equ 255 ; Enemy formed by 4 8x8 tiles + one sprite; only horiz. movement; possible 2 per line
ENEMY_TYPE_B:                   equ 254 ; Enemy formed by 2 or 3 sprites (only 2 on the same horiz.); only horizontal movement; only one per line
SCENERY:                        equ 250 ; 


; ---- Enemy types (highest bit means direction - 0: facing left or 1: right):

ENEMY_FACING_RIGHT:             equ 1000 0000 b

; Type A
ENEMY_TYPE_LADYBUG_LEFT:        equ 0
ENEMY_TYPE_LADYBUG_RIGHT:       equ ENEMY_TYPE_LADYBUG_LEFT + ENEMY_FACING_RIGHT

ENEMY_TYPE_SNAIL_LEFT:          equ 1
ENEMY_TYPE_SNAIL_RIGHT:         equ ENEMY_TYPE_SNAIL_LEFT + ENEMY_FACING_RIGHT



; Type B
ENEMY_TYPE_ARMADILLO:           equ 0
ENEMY_TYPE_ARMADILLO_LEFT:      equ ENEMY_TYPE_ARMADILLO
ENEMY_TYPE_ARMADILLO_RIGHT:     equ ENEMY_TYPE_ARMADILLO_LEFT + ENEMY_FACING_RIGHT

ENEMY_TYPE_CENTIPEDE:           equ 1
ENEMY_TYPE_CENTIPEDE_LEFT:      equ ENEMY_TYPE_CENTIPEDE
ENEMY_TYPE_CENTIPEDE_RIGHT:     equ ENEMY_TYPE_CENTIPEDE_LEFT + ENEMY_FACING_RIGHT

ENEMY_TYPE_DINO:                equ 2
ENEMY_TYPE_DINO_LEFT:           equ ENEMY_TYPE_DINO
ENEMY_TYPE_DINO_RIGHT:          equ ENEMY_TYPE_DINO_LEFT + ENEMY_FACING_RIGHT

ENEMY_TYPE_ELEPHANT:            equ 3
ENEMY_TYPE_ELEPHANT_LEFT:       equ ENEMY_TYPE_ELEPHANT
ENEMY_TYPE_ELEPHANT_RIGHT:      equ ENEMY_TYPE_ELEPHANT_LEFT + ENEMY_FACING_RIGHT



SCENERY_TYPE_BUSH:              equ 32
SCENERY_TYPE_FENCE:             equ 33

