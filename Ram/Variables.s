; These will be mapped to RAM, all values that will be modified need to be in RAM

                                                ; rb n  = reserve n bytes in RAM
                                                ; rw n  = reserve n words in RAM
SEED:                       rw 1            ; Seed for random number generator

Player_X:                   rb 1
Player_Y:                   rb 1

; BgScrollRegister:           rb 1
;NextBgLineAddr:             rw 1

BgAddrCurrentIndex:         rw 1        ; current position of screen in the background (0-TILE_MAP_WIDTH_IN_8X8_COLUMNS), currently (0-512)

FrameIndex:                 rb 1        ; frame index inside a tile (0-7)
BgAddrIndex:                rw 1
BgAddrIndexFirstFrame:      rw 1



ScrollDirection:            rb 1       ; 0: none, 1: left, 2 right



;test
Test_sprite_color: rb 1