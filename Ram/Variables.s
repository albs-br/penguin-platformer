; These will be mapped to RAM, all values that will be modified need to be in RAM

                                                ; rb n  = reserve n bytes in RAM
                                                ; rw n  = reserve n words in RAM
SEED:                       rw 1            ; Seed for random number generator

X:                          rb 1

BgScrollRegister:           rb 1
;NextBgLineAddr:             rw 1


FrameIndex:                 rb 1
BgIndex:                    rw 1
BgIndexFirstFrame:          rw 1

;     LevelDataStart:             rb LevelDataChunckSize * 100        ; reserve 1600 bytes for level data (100 max enemies per level)
;     LevelDataEnd:               rb 1
;     LevelDataLastAddr:          rw 1


;     StartCurrentBackgroundDataAddress: rw 1            ; pointer to address of the background data currently in use

;     CurrentBackgroundData_Unpacked:    rb 32 * 150      ; max 150 lines for bg data


;     Level:                      rb 1            ; number of current level
    
;     Counter:                    rw 1            ; Global counter

        


; ; Player plane
;     Player_State:               rb 1            ; 0: alive, >0: explosion counter
;     ; Player_Shot:                rb 1            ; 0: dont shot, 1, 2 or 3: number of shots fired
;     Player_Lifes:               rb 1            ;
;     Player_Score:               rb 2            ; 2 bytes using BCD code, so the max score is 9999 (shown on screen as 99990
;     Player_Trigger_Pressed:     rb 1            ;
;     TypeLastShotTriggered:      rb 1            ; 0: Spacebar, 1: Joystick 1 button

; ; Player shots variables (using Struct_PlayerShot)
;     Player_Shot_0_Obj:          rb 4            ;
;     Player_Shot_1_Obj:          rb 4            ;
;     Player_Shot_2_Obj:          rb 4            ;


; ; Collision boxes (using Struct_CollisionBox)
;     Player_CollisionBox:        rb 4            ;
;     Player_Shot_CollisionBox:   rb 4            ;
;     EnemyTemp_CollisionBox:     rb 4            ;


; ; Enemy temp memory space
;     Enemy_Temp_Base_Address:
;     Enemy_Temp_Show:               rb 1            ;
;     Enemy_Temp_State:              rb 1            ; State, to control the explosion animation
;     Enemy_Temp_Type:               rb 1            ;
;     Enemy_Temp_1stColor:           rb 1            ;
;     Enemy_Temp_2ndColor:           rb 1            ;
;     Enemy_Temp_X:                  rb 1            ;
;     Enemy_Temp_Y:                  rb 1            ;
;     Enemy_Temp_2ndColorPattern:    rb 1            ;

;     ; Enemy_Temp_Layer2ndColor:      rb 1            ;
;     ; Enemy_Temp_Layer1stColor:      rb 1            ;
;     ; Enemy_Temp_LayerShadow:        rb 1            ;
;     TempAddr:                      rw 1            ;


; ; Enemy plane 0
;     Enemy_0_Base_Address:
;     Enemy_0_Show:               rb 1            ;
;     Enemy_0_State:              rb 1            ; State, to control the explosion animation
;     Enemy_0_Type:               rb 1            ;
;     Enemy_0_1stColor:           rb 1            ;
;     Enemy_0_2ndColor:           rb 1            ;
;     Enemy_0_X:                  rb 1            ;
;     Enemy_0_Y:                  rb 1            ;
;     Enemy_0_2ndColorPattern:    rb 1            ;0
; ; Enemy shot 0
;     Enemy_Shot_0_Show:          rb 1            ;
;     Enemy_Shot_0_X:             rb 1            ;
;     Enemy_Shot_0_Y:             rb 1            ;
;     Enemy_Shot_0_DeltaX:        rb 1            ;



; ; Enemy plane 1
;     Enemy_1_Base_Address:
;     Enemy_1_Show:               rb 1            ;
;     Enemy_1_State:              rb 1            ; State, to control the explosion animation
;     Enemy_1_Type:               rb 1            ;
;     Enemy_1_1stColor:           rb 1            ;
;     Enemy_1_2ndColor:           rb 1            ;
;     Enemy_1_X:                  rb 1            ;
;     Enemy_1_Y:                  rb 1            ;
;     Enemy_1_2ndColorPattern:    rb 1            ;

; ; Enemy shot 1
;     Enemy_Shot_1_Show:          rb 1            ;
;     Enemy_Shot_1_X:             rb 1            ;
;     Enemy_Shot_1_Y:             rb 1            ;
;     Enemy_Shot_1_DeltaX:        rb 1            ;



; ; Enemy plane 2
;     Enemy_2_Base_Address:
;     Enemy_2_Show:               rb 1            ;
;     Enemy_2_State:              rb 1            ; State, to control the explosion animation
;     Enemy_2_Type:               rb 1            ;
;     Enemy_2_1stColor:           rb 1            ;
;     Enemy_2_2ndColor:           rb 1            ;
;     Enemy_2_X:                  rb 1            ;
;     Enemy_2_Y:                  rb 1            ;
;     Enemy_2_2ndColorPattern:    rb 1            ;

; ; Enemy shot 2
;     Enemy_Shot_2_Show:          rb 1            ;
;     Enemy_Shot_2_X:             rb 1            ;
;     Enemy_Shot_2_Y:             rb 1            ;
;     Enemy_Shot_2_DeltaX:        rb 1            ;



; ; Enemy plane 3
;     Enemy_3_Base_Address:
;     Enemy_3_Show:               rb 1            ;
;     Enemy_3_State:              rb 1            ; State, to control the explosion animation
;     Enemy_3_Type:               rb 1            ;
;     Enemy_3_1stColor:           rb 1            ;
;     Enemy_3_2ndColor:           rb 1            ;
;     Enemy_3_X:                  rb 1            ;
;     Enemy_3_Y:                  rb 1            ;
;     Enemy_3_2ndColorPattern:    rb 1            ;3

; ; Enemy shot 3
;     Enemy_Shot_3_Show:          rb 1            ;
;     Enemy_Shot_3_X:             rb 1            ;
;     Enemy_Shot_3_Y:             rb 1            ;
;     Enemy_Shot_3_DeltaX:        rb 1            ;



; ; Enemy plane 4
;     Enemy_4_Base_Address:
;     Enemy_4_Show:               rb 1            ;
;     Enemy_4_State:              rb 1            ; State, to control the explosion animation
;     Enemy_4_Type:               rb 1            ;
;     Enemy_4_1stColor:           rb 1            ;
;     Enemy_4_2ndColor:           rb 1            ;
;     Enemy_4_X:                  rb 1            ;
;     Enemy_4_Y:                  rb 1            ;
;     Enemy_4_2ndColorPattern:    rb 1            ;

; ; Enemy shot 4
;     Enemy_Shot_4_Show:          rb 1            ;
;     Enemy_Shot_4_X:             rb 1            ;
;     Enemy_Shot_4_Y:             rb 1            ;
;     Enemy_Shot_4_DeltaX:        rb 1            ;


; ; Item
;     Item_Show:                  rb 1            ;


; ; Buffer for level title effect
;     ; LevelTitleBuffer_Line0:     rb 64 * 8
;     ; RamAddrSource:              rw 1
;     ; VramAddrDestiny:            rw 1


; ; Level title curtain
;     LeftCurtain_X:              rb 1
;     RightCurtain_X:             rb 1
;     BgSourceTileAddr:           rw 1
