DIAMOND_FIRST_TILE:             equ 184 - 7 - 24

; test objects, just to show it's possible use objects other than diamonds
OTHER_OBJECT:                   equ DIAMOND_FIRST_TILE - 64
ANOTHER_OBJECT:                 equ DIAMOND_FIRST_TILE - 128
ENEMY:                          equ 255


; enemy types (highest bit means direction - 0: facing left or 1: right):
ENEMY_FACING_RIGHT:             equ 1000 0000 b
ENEMY_TYPE_LADYBUG_LEFT:        equ 0
ENEMY_TYPE_LADYBUG_RIGHT:       equ ENEMY_TYPE_LADYBUG_LEFT + ENEMY_FACING_RIGHT
ENEMY_TYPE_SNAIL_LEFT:          equ 1
ENEMY_TYPE_SNAIL_RIGHT:         equ ENEMY_TYPE_SNAIL_LEFT + ENEMY_FACING_RIGHT



; Format:
;       column position (1-255), based on 16x16 tiles; 0 is forbidden
;       object tile first frame number (255 = enemy)

;       row number: n * 2 * 8, n is row number (0-11), based on 16x16 tiles

;       state: enabled: 1; disabled: 0; > 1 : animation for enemy dying

; -- these properties are only for enemies:
;       x offset (0-15)
;       enemy type (bit 7: 0-facing left; 1-facing right)
;       not used
;       not used
BgObjectsInitialState_Start:

; screen / page 0 (columns 0-15)
    ;db      5,      DIAMOND_FIRST_TILE,     2 * 2 * 8,      1,  0,  0,  0,  0
    ;db      1,      DIAMOND_FIRST_TILE,     3 * 2 * 8,      1,  0,  0,  0,  0
    
    db      1,      DIAMOND_FIRST_TILE,     4 * 2 * 8,      1,  0,  0,  0,  0

    ;db      10,     ENEMY,                  9 * 2 * 8,      1,  0,  0,  0,  0
    db      11,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,                          0,  0
    ;db      12,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,                          0,  0
    
    db      11,     ENEMY,                 0 * 2 * 8,      1,  0,  ENEMY_TYPE_LADYBUG_LEFT,    0,  0

    db      15,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,                          0,  0
    db      11,     ENEMY,                  6 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_LEFT,      0,  0
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0000)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 1 (columns 16-31)
    db      17,     DIAMOND_FIRST_TILE,    0 * 2 * 8,      1,  0,  0,  0,  0
    
    db      18,     DIAMOND_FIRST_TILE,    4 * 2 * 8,      1,  0,  0,  0,  0

    db      17,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    db      20,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0

    db      27,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,                          0,  0

    ;db      29,     ENEMY,                  8 * 2 * 8,      1,  0,  ENEMY_TYPE_LADYBUG_LEFT,    0,  0

    ;db      36,     ENEMY,                  * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_RIGHT,    0,  0

	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0100)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 2 (columns 32-47)
    
    ; db      32,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    ; db      34,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    ; db      36,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    ; db      38,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    ; db      40,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    ; db      42,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    
    ;db      44,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    ;db      44,     DIAMOND_FIRST_TILE,     5 * 2 * 8,      1
    ; db      44,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1

    db      32,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    ; db      32,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      34,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      36,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      38,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      40,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      42,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db      34,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_RIGHT,    0,  0

    db      36,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_LADYBUG_LEFT,    0,  0
    db      42,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_LEFT,    0,  0
    ;db      44,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    ;db      44,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    ; db      44,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0200)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 3 (columns 48-63)
    
    db      51,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,  0,  0
    db      52,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    ;db      48,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
    ; db      49,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    ; db      50,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1,  0,  0,  0,  0
    db      63,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_LEFT,    0,  0
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0300)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 4 (columns 64-79)
    
    db      66,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1,  0,  0,  0,  0
    db      66,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,  0,  0

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
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0400)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 5 (columns 80-95)
    
    db      82,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1,  0,  0,  0,  0
    db      84,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1,  0,  0,  0,  0
    db      86,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1,  0,  0,  0,  0

	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0500)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 6 (columns 96-111)
    
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
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0600)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 7 (columns 112-127)
    
    db     127,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,  0,  0

    db     111,     ENEMY,                 10 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_LEFT,    0,  0
    db     115,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db     119,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
    db     123,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0700)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 8 (columns 128-143)
    
    db     130,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1,  0,  0,  0,  0

	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0800)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 9 (columns 144-159)
    
    db     149,     DIAMOND_FIRST_TILE,    7 * 2 * 8,       1,  0,  0,  0,  0
    db     160,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0900)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 10 (columns 160-175)
    
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0a00)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 11 (columns 176-191)

    db     190,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0b00)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 12 (columns 192-207)
    
    db     206,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0c00)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 13 (columns 208-223)
    
    db     224,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0d00)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 14 (columns 224-239)
    
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0e00)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

; screen / page 15 (columns 240-255)
    
    db     248,     DIAMOND_FIRST_TILE,    5 * 2 * 8,      1,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0f00)), 0                 ; fill with 0s until end of block

; -----------------------------------------------------------

BgObjectsInitialState_End:
