; These will be mapped to RAM, all values that will be modified need to be in RAM

                                                ; rb n  = reserve n bytes in RAM
                                                ; rw n  = reserve n words in RAM

; Table aligned to 0xC000
; --- Background objects with state (diamonds for example)
BgObjects_Start:            rb 256 * 16   ; bytes per page * number of pages

; BgObjects_1st_Third_Start:  rb 64 * 16   ; bytes per page * number of pages
; BgObjects_2nd_Third_Start:  rb 96 * 16   ; bytes per page * number of pages
; BgObjects_3rd_Third_Start:  rb 96 * 16   ; bytes per page * number of pages

BgObjects_End:



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
Player_Facing:              rb 1        ; 1: left, 2: right


CurrentMegaRomPage:         rb 1

BgCurrentIndex:             rw 1        ; current position of screen in the background (0 - (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8)), that is (0-4095)
FrameIndex:                 rb 1        ; frame index inside a tile (0-7)
BgAddrIndex:                rw 1
BgAddrIndexFirstFrame:      rw 1


FirstVisibleColumn:                     rw 1            ; column index based on 8x8 tiles (0-511)
LastVisibleColumn:                      rw 1            ; column index based on 8x8 tiles (0-511)
Addr_Screen_FirstVisibleColumn:         rw 1            ; addr of RAM objects of the screen of the first visible column
Addr_Screen_LastVisibleColumn:          rw 1

UpdateBgObjects_CurrentAddr:            rw 1
UpdateBgObjects_PosObjOnBG:             rw 1
UpdateBgObjects_X:                      rb 1
UpdateBgObjects_Y:                      rb 1
UpdateBgObjects_StartAddr:              rw 1

ScrollDirection:                        rb 1       ; 0: none, 1: left, 2: right
ScrollSpeed:                            rb 1       ; 1: normal (1px / frame), 2: fast (2px / frame)



; Animation for sparkles
Sparkles_X:                  rb 1
Sparkles_Y:                  rb 1
Sparkles_FrameNumber:        rb 1
Sparkles_Counter:            rb 1        ; counter for each animation frame



; [debug]
D_Above:    rb 1
D_Right:    rb 1
D_Below:    rb 1
D_TileNumber:   rb 1


; [debug]
;test
Test_Sprite_Color:          rb 1
Test_Sprite_X:              rb 1
Test_Sprite_Y:              rb 1
