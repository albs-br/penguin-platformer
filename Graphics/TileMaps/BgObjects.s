; Format:
;       position (0-255)
;       object
;       row number (0-22) only even, then multiplied by 8
;       enabled: 1; disabled: 0
BgObjectsInitialState_Start:
    db      1,      184-7,      8 * 8,      1
    db      4,      184-7,     16 * 8,      1
    db      12,     184-7,     18 * 8,      1
    db      14,     184-7,     16 * 8,      1
    db      17,     184-7,     20 * 8,      1
    db      20,     184-7,     16 * 8,      1
    db      28,     184-7,     16 * 8,      1
    db      32,     184-7,     16 * 8,      1
    db      40,     8,         16 * 8,      1
    db      127,    8,         16 * 8,      1
    db      130,    8,         16 * 8,      1
BgObjectsInitialState_End:
