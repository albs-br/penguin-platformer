; These will be mapped to RAM, all values that will be modified need to be in RAM

                                                ; rb n  = reserve n bytes in RAM
                                                ; rw n  = reserve n words in RAM


CurrentNamesTable:                  rw 1



Seed:                       rw 1            ; Seed for random number generator


DirectionKeyPressed:        rb 1
JumpKeyPressed:             rb 1
RunKeyPressed:              rb 1

Player_IsAlive:             rb 1
Player_X:                   rb 1
Player_Y:                   rb 1
Player_Sprite_Number:       rb 1
Player_Animation_Frame:     rb 1
Player_IsGrounded:          rb 1        ; 0: not grounded (falling); 1: grounded
Player_IsJumping:           rb 1        ; 0: not jumping; 1: jumping
Player_Jumping_Addr:        rw 1        ; Jumping/falling current address on the Delta Y table
Player_Facing:              rb 1        ; 1: left, 2: right
Player_DeathAnimation:      rb 1

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
UpdateBgObjects_CurrentAddr_RowNumber_Value:    rb 1
UpdateBgObjects_CurrentAddr_State:      rw 1
UpdateBgObjects_CurrentAddr_X_Offset:   rw 1
UpdateBgObjects_X_Offset_Value:         rb 1
UpdateBgObjects_X_Offset_Value_Adjusted:        rb 1
UpdateBgObjects_CurrentAddr_EnemyType:  rw 1
UpdateBgObjects_PosObjOnBG:             rw 1
UpdateBgObjects_X:                      rb 1
UpdateBgObjects_Y:                      rb 1
UpdateBgObjects_StartAddr:              rw 1
UpdateBgObjects_NameTable_Addr:         rw 1
UpdateBgObjects_Enemy_Color_Addr:       rw 1
UpdateBgObjects_Enemy_Sprite_Number:    rb 1
UpdateBgObjects_Enemy_Sprite_Color:     rb 1
UpdateBgObjects_FrameIndex_Enemy:       rb 1

UpdateBgObjects_Enemy_Return_Addr:          rw 1
UpdateBgObjects_VRAM_ColorsTable_Addr:      rw 1
UpdateBgObjects_VRAM_NamesTable_Position:   rb 1

; Local properties for subroutine (enemy type A)
UpdateBgObjects_Enemy_TypeA_n_BaseAddress:
UpdateBgObjects_Enemy_TypeA_n_X:                      rb 1
UpdateBgObjects_Enemy_TypeA_n_Y:                      rb 1
UpdateBgObjects_Enemy_TypeA_n_Pattern:                rb 1
UpdateBgObjects_Enemy_TypeA_n_Color:                  rb 1
UpdateBgObjects_Enemy_TypeA_n_RAM_Pattern_Addr:       rw 1
UpdateBgObjects_Enemy_TypeA_n_VRAM_Pattern_Addr:      rw 1
ENEMY_TYPE_A_STRUCT_SIZE:                      equ $ - UpdateBgObjects_Enemy_TypeA_n_BaseAddress

; Local properties for subroutine (enemy type B)
UpdateBgObjects_Enemy_TypeB_n_BaseAddress:
UpdateBgObjects_Enemy_TypeB_n_X:                      rb 1
UpdateBgObjects_Enemy_TypeB_n_Y:                      rb 1
UpdateBgObjects_Enemy_TypeB_n_1st_Sprite_Pattern:     rb 1
UpdateBgObjects_Enemy_TypeB_n_1st_Sprite_Color:       rb 1
UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Pattern:     rb 1
UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Color:       rb 1
UpdateBgObjects_Enemy_TypeB_n_2nd_Sprite_Y:           rb 1
UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Pattern:     rb 1
UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Color:       rb 1
UpdateBgObjects_Enemy_TypeB_n_3rd_Sprite_Y:           rb 1
ENEMY_TYPE_B_STRUCT_SIZE:                      equ $ - UpdateBgObjects_Enemy_TypeB_n_BaseAddress


; Type of enemeis that are currently on the VRAM Sprite Pattern Table (only two enemies allowed at same time)
EnemyTypeB_1_CurrentSpriteLoaded:                     rb 1
EnemyTypeB_2_CurrentSpriteLoaded:                     rb 1



ScrollDirection:                        rb 1       ; 0: none, 1: left, 2: right
ScrollSpeed:                            rb 1       ; 1: normal (1px / frame), 2: fast (2px / frame)


; Animation for sparkles
Sparkles_X:                             rb 1
Sparkles_Y:                             rb 1
Sparkles_FrameNumber:                   rb 1
Sparkles_Counter:                       rb 1        ; counter for each animation frame


; Animation for hit flash (when player jumps over enemy)
HitFlash_X:                             rb 1
HitFlash_Y:                             rb 1
HitFlash_FrameNumber:                   rb 1
HitFlash_Counter:                       rb 1        ; counter for each animation frame


; Score
ScoreBottom_Color:                      rb 1

; --------------------- Enemies type A
Enemies_TypeA_Counter:                        rb 1

Enemy_TypeA_1_BaseAddress:
Enemy_TypeA_1_X:                              rb 1
Enemy_TypeA_1_Y:                              rb 1
Enemy_TypeA_1_Pattern:                        rb 1
Enemy_TypeA_1_Color:                          rb 1
Enemy_TypeA_1_RAM_Pattern_Addr:               rw 1
Enemy_TypeA_1_VRAM_Pattern_Addr:              rw 1

Enemy_TypeA_2_BaseAddress:
Enemy_TypeA_2_X:                              rb 1
Enemy_TypeA_2_Y:                              rb 1
Enemy_TypeA_2_Pattern:                        rb 1
Enemy_TypeA_2_Color:                          rb 1
Enemy_TypeA_2_RAM_Pattern_Addr:               rw 1
Enemy_TypeA_2_VRAM_Pattern_Addr:              rw 1

Enemy_TypeA_3_BaseAddress:
Enemy_TypeA_3_X:                              rb 1
Enemy_TypeA_3_Y:                              rb 1
Enemy_TypeA_3_Pattern:                        rb 1
Enemy_TypeA_3_Color:                          rb 1
Enemy_TypeA_3_RAM_Pattern_Addr:               rw 1
Enemy_TypeA_3_VRAM_Pattern_Addr:              rw 1



; --------------------- Enemies type B
Enemies_TypeB_Counter:                  rb 1

Enemy_TypeB_1_BaseAddress:
Enemy_TypeB_1_X:                        rb 1
Enemy_TypeB_1_Y:                        rb 1
Enemy_TypeB_1_1st_Sprite_Pattern:       rb 1
Enemy_TypeB_1_1st_Sprite_Color:         rb 1
Enemy_TypeB_1_2nd_Sprite_Pattern:       rb 1
Enemy_TypeB_1_2nd_Sprite_Color:         rb 1
Enemy_TypeB_1_2nd_Sprite_Y:             rb 1
Enemy_TypeB_1_3rd_Sprite_Pattern:       rb 1
Enemy_TypeB_1_3rd_Sprite_Color:         rb 1
Enemy_TypeB_1_3rd_Sprite_Y:             rb 1


Enemy_TypeB_2_BaseAddress:
Enemy_TypeB_2_X:                        rb 1
Enemy_TypeB_2_Y:                        rb 1
Enemy_TypeB_2_1st_Sprite_Pattern:       rb 1
Enemy_TypeB_2_1st_Sprite_Color:         rb 1
Enemy_TypeB_2_2nd_Sprite_Pattern:       rb 1
Enemy_TypeB_2_2nd_Sprite_Color:         rb 1
Enemy_TypeB_2_2nd_Sprite_Y:             rb 1
Enemy_TypeB_2_3rd_Sprite_Pattern:       rb 1
Enemy_TypeB_2_3rd_Sprite_Color:         rb 1
Enemy_TypeB_2_3rd_Sprite_Y:             rb 1


Enemy_TypeB_3_BaseAddress:
Enemy_TypeB_3_X:                        rb 1
Enemy_TypeB_3_Y:                        rb 1
Enemy_TypeB_3_1st_Sprite_Pattern:       rb 1
Enemy_TypeB_3_1st_Sprite_Color:         rb 1
Enemy_TypeB_3_2nd_Sprite_Pattern:       rb 1
Enemy_TypeB_3_2nd_Sprite_Color:         rb 1
Enemy_TypeB_3_2nd_Sprite_Y:             rb 1
Enemy_TypeB_3_3rd_Sprite_Pattern:       rb 1
Enemy_TypeB_3_3rd_Sprite_Color:         rb 1
Enemy_TypeB_3_3rd_Sprite_Y:             rb 1


Enemy_TypeB_4_BaseAddress:
Enemy_TypeB_4_X:                        rb 1
Enemy_TypeB_4_Y:                        rb 1
Enemy_TypeB_4_1st_Sprite_Pattern:       rb 1
Enemy_TypeB_4_1st_Sprite_Color:         rb 1
Enemy_TypeB_4_2nd_Sprite_Pattern:       rb 1
Enemy_TypeB_4_2nd_Sprite_Color:         rb 1
Enemy_TypeB_4_2nd_Sprite_Y:             rb 1
Enemy_TypeB_4_3rd_Sprite_Pattern:       rb 1
Enemy_TypeB_4_3rd_Sprite_Color:         rb 1
Enemy_TypeB_4_3rd_Sprite_Y:             rb 1

    ; add enemies here


; ---------------------
FramesSkipped:                          rb 1
CurrentJiffy:                           rb 1


; [debug]
; D_Above:    rb 1
; D_Right:    rb 1
; D_Below:    rb 1
; D_TileNumber:   rb 1


; [debug]
;test
; Test_Sprite_Color:          rb 1
; Test_Sprite_X:              rb 1
; Test_Sprite_Y:              rb 1

Temp_Addr:                              rw 1
