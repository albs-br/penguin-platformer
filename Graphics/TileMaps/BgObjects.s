DIAMOND_FIRST_TILE:             equ 184 - 7 - 24

; test objects, just to show it's possible use objects other than diamonds
OTHER_OBJECT:                   equ DIAMOND_FIRST_TILE - 64
ANOOTHER_OBJECT:                equ DIAMOND_FIRST_TILE - 128


; Format:
;       position (1-255), based on 16x16 tiles; 0 is forbidden
;       object number
;       row number: n * 2 * 8, n is row number (4-11), based on 16x16 tiles, only 2nd and 3rd thirds of screen available
;       enabled: 1; disabled: 0
BgObjectsInitialState_Start:

; screen / page 0 (0-15)
    db      1,      DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    db      12,     OTHER_OBJECT,           9 * 2 * 8,      1
    db      14,     ANOOTHER_OBJECT,        8 * 2 * 8,      1
    db      15,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0000)), 0                 ; fill with 0s until end of page

; screen / page 1 (16-31)
    db      17,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      20,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      28,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0100)), 0                 ; fill with 0s until end of page

; screen / page 2 (32-47)
    db      32,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      32,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      32,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      34,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      34,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      36,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      36,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      38,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      38,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      40,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      40,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      42,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      42,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     5 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0200)), 0                 ; fill with 0s until end of page

; screen / page 3 (48-63)
    db      48,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      49,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db      50,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      51,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
    db      52,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0300)), 0                 ; fill with 0s until end of page

; screen / page 4 (64-79)
    db      66,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      66,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
    db      66,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    
    db      72,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      72,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db      72,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1

    db      74,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      74,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db      74,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1

    db      76,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      76,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db      76,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0400)), 0                 ; fill with 0s until end of page

; screen / page 5 (80-95)
    db      82,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    db      84,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    db      86,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0500)), 0                 ; fill with 0s until end of page

; screen / page 6 (96-111)
    db      95,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      96,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db      97,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1

    db     101,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db     102,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db     103,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db     103,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db     104,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db     105,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db     105,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db     106,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db     107,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    
    db     110,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0600)), 0                 ; fill with 0s until end of page

; screen / page 7 (112-127)
    db     115,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db     119,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db     123,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1

    db     127,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0700)), 0                 ; fill with 0s until end of page

; screen / page 8 (128-143)
    db     130,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0800)), 0                 ; fill with 0s until end of page

; screen / page 9 (144-159)
    db     149,     DIAMOND_FIRST_TILE,    7 * 2 * 8,      1
    
    db     160,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0900)), 0                 ; fill with 0s until end of page

; screen / page 10 (160-175)
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0a00)), 0                 ; fill with 0s until end of page
    
; screen / page 11 (176-191)
    db     190,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0b00)), 0                 ; fill with 0s until end of page
    
; screen / page 12 (192-207)
    db     206,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0c00)), 0                 ; fill with 0s until end of page
    
; screen / page 13 (208-223)
    db     224,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0d00)), 0                 ; fill with 0s until end of page

; screen / page 14 (224-239)
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0e00)), 0                 ; fill with 0s until end of page

; screen / page 15 (240-255)
    db     248,     DIAMOND_FIRST_TILE,    5 * 2 * 8,      1
	ds     256 - ($ - (BgObjectsInitialState_Start + 0x0f00)), 0                 ; fill with 0s until end of page
BgObjectsInitialState_End:
