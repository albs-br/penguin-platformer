; Format:
;       position (0-255)
;       object
;       row number (0-22) only even, then multiplied by 8
;       to be defined
BgObjectsInitialState_Start:
    db      1,      184-7,      8 * 8,      0
    db      4,      184-7,     16 * 8,      0
    db      12,     184-7,     16 * 8,      0
    db      13,     184-7,     18 * 8,      0
    db      17,     184-7,     20 * 8,      0
    db      20,     184-7,     16 * 8,      0
    db      28,     184-7,     16 * 8,      0
    db      32,     184-7,     16 * 8,      0
    db      40,     8,         16 * 8,      0
    db      127,    8,         16 * 8,      0
    db      130,    8,         16 * 8,      0
BgObjectsInitialState_End:
