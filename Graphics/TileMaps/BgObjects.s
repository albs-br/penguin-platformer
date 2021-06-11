DIAMOND_FIRST_TILE:             equ 184 - 7 - 24

; test objects, just to show it's possible use objects other than diamonds
OTHER_OBJECT:                   equ DIAMOND_FIRST_TILE - 64
ANOTHER_OBJECT:                 equ DIAMOND_FIRST_TILE - 128
ENEMY:                          equ 255


; enemy types (highest bit means direction - facing left or right):
ENEMY_FACING_RIGHT:             equ 1000 0000 b
ENEMY_TYPE_LADYBUG_LEFT:        equ 0
ENEMY_TYPE_LADYBUG_RIGHT:       equ ENEMY_TYPE_LADYBUG_LEFT + ENEMY_FACING_RIGHT
ENEMY_TYPE_SNAIL_LEFT:          equ 1
ENEMY_TYPE_SNAIL_RIGHT:         equ ENEMY_TYPE_SNAIL_LEFT + ENEMY_FACING_RIGHT



; Format:
;       column position (1-255), based on 16x16 tiles; 0 is forbidden
;       object tile first frame number (255 = enemy)

;---> TODO: test rows 0-3 (now with 2 name tables as double buffer, it must work perfectly)
;       row number: n * 2 * 8, n is row number (4-11), based on 16x16 tiles, caution with first rows

;       state: enabled: 1; disabled: 0; > 1 : animation for enemy dying

; -- these properties are only for enemies:
;       x offset (0-15)
;       enemy type (bit 7: 0-facing left; 1-facing right)
;       left limit (1-255), based on 16x16 tiles
;       right limit (1-255), based on 16x16 tiles
BgObjectsInitialState_Start:

; screen / page 0 (0-15)
    ; db      1,      DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    ; db      12,     OTHER_OBJECT,           9 * 2 * 8,      1
    ; db      14,     ANOOTHER_OBJECT,        8 * 2 * 8,      1
    ; db      15,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	; ds     256 - ($ - (BgObjectsInitialState_Start + 0x0000)), 0                 ; fill with 0s until end of page

; screen / page 0 (columns 0-15)
    ; 1st third (lines 0-3) - 64 bytes
    ;db      5,      DIAMOND_FIRST_TILE,     2 * 2 * 8,      1,  0,  0,  0,  0
    ;db      1,      DIAMOND_FIRST_TILE,     3 * 2 * 8,      1,  0,  0,  0,  0
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0000)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db      1,      DIAMOND_FIRST_TILE,     4 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0040)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    ;db      10,     ENEMY,                  9 * 2 * 8,      1,  0,  0,  0,  0
    db      11,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,                          0,  0
    ;db      12,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,                          0,  0
    
    db      13,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_LADYBUG_LEFT,    0,  0

    db      15,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,                          0,  0
    db      15,     ENEMY,                  9 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_LEFT,      0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x00a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 1 (16-31)
;     db      17,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      20,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db      28,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0100)), 0                 ; fill with 0s until end of page

; screen / page 1 (columns 16-31)
    ; 1st third (lines 0-3) - 64 bytes
    db      17,     DIAMOND_FIRST_TILE,    0 * 2 * 8,      1,  0,  0,  0,  0
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0100)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db      18,     DIAMOND_FIRST_TILE,    4 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0140)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes

    db      17,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    db      20,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0

    db      27,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,                          0,  0

    db      29,     ENEMY,                  8 * 2 * 8,      1,  0,  ENEMY_TYPE_LADYBUG_LEFT,    0,  0

	ds     96 - ($ - (BgObjectsInitialState_Start + 0x01a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 2 (32-47)
;     db      32,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db      32,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      32,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
;     db      34,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      34,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
;     db      36,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      36,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
;     db      38,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      38,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
;     db      40,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      40,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
;     db      42,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      42,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
;     db      44,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
;     db      44,     DIAMOND_FIRST_TILE,     5 * 2 * 8,      1
;     db      44,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
;     db      44,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db      44,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db      44,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0200)), 0                 ; fill with 0s until end of page

; screen / page 2 (columns 32-47)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0200)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db      32,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    db      34,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    db      36,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    db      38,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    db      40,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    db      42,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    ;db      44,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    ;db      44,     DIAMOND_FIRST_TILE,     5 * 2 * 8,      1
    ; db      44,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0240)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    db      32,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    ; db      32,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      34,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      36,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      38,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      40,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      42,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db      36,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_LADYBUG_LEFT,    0,  0
    db      42,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_LADYBUG_LEFT,    0,  0
    ;db      44,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    ;db      44,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    ; db      44,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x02a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 3 (48-63)
;     db      48,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      49,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db      50,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db      51,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
;     db      52,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0300)), 0                 ; fill with 0s until end of page

; screen / page 3 (columns 48-63)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0300)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db      51,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,  0,  0
    db      52,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0340)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    ;db      48,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    ; db      49,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      50,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    db      63,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_LEFT,    0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x03a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 4 (64-79)
;     db      66,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
;     db      66,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
;     db      66,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    
;     db      72,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db      72,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db      72,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1

;     db      74,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db      74,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db      74,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1

;     db      76,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db      76,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db      76,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0400)), 0                 ; fill with 0s until end of page

; screen / page 4 (columns 64-79)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0400)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db      66,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    db      66,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0440)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    db      66,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0

    db      72,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    db      72,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db      72,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0

    db      74,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    db      74,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db      74,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0

    db      76,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    db      76,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db      76,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x04a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 5 (80-95)
;     db      82,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
;     db      84,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
;     db      86,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0500)), 0                 ; fill with 0s until end of page

; screen / page 5 (columns 80-95)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0500)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db      82,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1,  0,  0,  0,  0
    db      84,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1,  0,  0,  0,  0
    db      86,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0540)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x05a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 6 (96-111)
;     db      95,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db      96,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db      97,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1

;     db     101,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db     102,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db     103,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db     103,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db     104,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db     105,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
;     db     105,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
;     db     106,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db     107,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    
;     db     110,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0600)), 0                 ; fill with 0s until end of page

; screen / page 6 (columns 96-111)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0600)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0640)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    db      95,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    db      96,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db      97,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0

    db     101,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    db     102,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db     103,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    db     103,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    db     104,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db     105,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    db     105,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    db     106,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ;db     107,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    
    ; WARNING: Watch the max size here
    db     109,     DIAMOND_FIRST_TILE,    11 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x06a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 7 (112-127)
;     db     115,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db     119,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
;     db     123,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1

;     db     127,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0700)), 0                 ; fill with 0s until end of page

; screen / page 7 (columns 112-127)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0700)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db     127,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0740)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    db     111,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_LEFT,    0,  0
    db     115,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db     119,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db     123,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x07a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 8 (128-143)
;     db     130,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0800)), 0                 ; fill with 0s until end of page

; screen / page 8 (columns 128-143)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0800)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db     130,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0840)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x08a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 9 (144-159)
;     db     149,     DIAMOND_FIRST_TILE,    7 * 2 * 8,      1
    
;     db     160,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0900)), 0                 ; fill with 0s until end of page

; screen / page 9 (columns 144-159)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0900)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db     149,     DIAMOND_FIRST_TILE,    7 * 2 * 8,       1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0940)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    db     160,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x09a0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 10 (160-175)
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0a00)), 0                 ; fill with 0s until end of page

; screen / page 10 (columns 160-175)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0a00)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0a40)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0aa0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 11 (176-191)
;     db     190,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0b00)), 0                 ; fill with 0s until end of page

; screen / page 11 (columns 176-191)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0b00)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0b40)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    db     190,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0ba0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 12 (192-207)
;     db     206,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0c00)), 0                 ; fill with 0s until end of page

; screen / page 12 (columns 192-207)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0c00)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0c40)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    db     206,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0ca0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 13 (208-223)
;     db     224,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0d00)), 0                 ; fill with 0s until end of page

; screen / page 13 (columns 208-223)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0d00)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0d40)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
    db     224,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0da0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 14 (224-239)
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0e00)), 0                 ; fill with 0s until end of page

; screen / page 14 (columns 224-239)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0e00)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0e40)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0ea0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; ; screen / page 15 (240-255)
;     db     248,     DIAMOND_FIRST_TILE,    5 * 2 * 8,      1
; 	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0f00)), 0                 ; fill with 0s until end of page

; screen / page 15 (columns 240-255)
    ; 1st third (lines 0-3) - 64 bytes
	ds     64 - ($ - (BgObjectsInitialState_Start + 0x0f00)), 0                 ; fill with 0s until end of block
    
    ; 2nd third (lines 4-7) - 96 bytes
    db     248,     DIAMOND_FIRST_TILE,    5 * 2 * 8,      1,  0,  0,  0,  0
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0f40)), 0                 ; fill with 0s until end of block

    ; 3rd third (lines 8-11) - 96 bytes
	ds     96 - ($ - (BgObjectsInitialState_Start + 0x0fa0)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

BgObjectsInitialState_End:
