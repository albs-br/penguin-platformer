DIAMOND_FIRST_TILE:             equ 184 - 7 - 24


; Format:
;       position (1-255), based on 16x16 tiles; 0 is forbidden
;       object number
;       row number: n * 2 * 8, n is row number (4-11), based on 16x16 tiles, only 2nd and 3rd thirds of screen available
;       enabled: 1; disabled: 0
BgObjectsInitialState_Start:
    db      1,      DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    db      12,     DIAMOND_FIRST_TILE - 64,     9 * 2 * 8,      1
    db      14,     DIAMOND_FIRST_TILE - 128,     8 * 2 * 8,      1
    db      15,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      17,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      20,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      28,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      32,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      32,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      34,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      36,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      38,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      40,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      42,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     4 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     5 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db      44,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    
    db      48,     DIAMOND_FIRST_TILE,    10 * 2 * 8,      1
    db      49,     DIAMOND_FIRST_TILE,     9 * 2 * 8,      1
    db      50,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    db      51,     DIAMOND_FIRST_TILE,     7 * 2 * 8,      1
    db      52,     DIAMOND_FIRST_TILE,     6 * 2 * 8,      1
    
    db      66,     DIAMOND_FIRST_TILE,     8 * 2 * 8,      1
    
    db      127,    8,         16 * 8,      1
    db      130,    8,         16 * 8,      1
BgObjectsInitialState_End:
