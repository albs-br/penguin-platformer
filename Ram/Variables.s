; These will be mapped to RAM, all values that will be modified need to be in RAM

                                                ; rb n  = reserve n bytes in RAM
                                                ; rw n  = reserve n words in RAM
SEED:                       rw 1            ; Seed for random number generator


DirectionKeyPressed:        rb 1
JumpKeyPressed:             rb 1
RunKeyPressed:              rb 1

Player_IsAlive:             rb 1
Player_X:                   rb 1
Player_Y:                   rb 1
Player_Sprite_Number:       rb 1
Player_Animation_Frame:     rb 1
Player_IsGrounded:          rb 1
Player_JumpCounter:         rb 1


BgCurrentIndex:             rw 1        ; current position of screen in the background (0 - (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8)), that is (0-4095)
BgCurrentIndex_InTiles:     rw 1        ; current position of screen in the background (0 - (TILE_MAP_WIDTH_IN_8X8_COLUMNS)), that is (0-511)
FrameIndex:                 rb 1        ; frame index inside a tile (0-7)
BgAddrIndex:                rw 1
BgAddrIndexFirstFrame:      rw 1



FirstVisibleColumn:         rw 1
LastVisibleColumn:          rw 1

UpdateBgObjects_CurrentAddr:            rw 1
UpdateBgObjects_PosObjOnBG:             rw 1
UpdateBgObjects_X:                      rb 1
UpdateBgObjects_Y:                      rb 1


ScrollDirection:            rb 1       ; 0: none, 1: left, 2: right
ScrollSpeed:                rb 1       ; 0: normal (1px), 1: fast (2px)



; --- Background objects with state (diamonds for example)
NUMBER_OF_BG_OBJS:          equ 256     ; TODO: should these constants be moved to constants file?
BG_OBJ_STRUCT_SIZE:         equ 4
BgObjects_Start:            rb NUMBER_OF_BG_OBJS * BG_OBJ_STRUCT_SIZE
BgObjects_End:



; Animation for diamond disappearing
DiamondDisappearing_X:                  rb 1
DiamondDisappearing_Y:                  rb 1
DiamondDisappearing_FrameNumber:        rb 1
DiamondDisappearing_Counter:            rb 1        ; counter for each animation frame




;test
Test_Sprite_Color:          rb 1
Test_Sprite_X:              rb 1
Test_Sprite_Y:              rb 1



