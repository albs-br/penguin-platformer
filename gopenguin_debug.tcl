#ram_watch   add     0xD02b      -type byte      -desc D_Above       -format dec
#ram_watch   add     0xD02c      -type byte      -desc D_Right       -format dec
#ram_watch   add     0xD02d      -type byte      -desc D_Below       -format dec
#ram_watch   add     0xD02e      -type byte      -desc D_TileNumber  -format dec

#ram_watch   add     0xD00c      -type byte      -desc Player_IsGrounded     -format dec
#ram_watch   add     0xD00d      -type byte      -desc Player_IsJumping     -format dec
#ram_watch   add     0xD00e      -type word      -desc Player_Jumping_Addr     -format hex
#
#ram_watch   add     0xD06d      -type byte      -desc IsProcessingFrame     -format dec
#ram_watch   add     0xD06e      -type byte      -desc HasFrameSkiped     -format dec
#
#ram_watch   add     0xD028      -type byte      -desc UpdateBgObjects_X_Offset_Value     -format dec

ram_watch   add     0xD05a      -type byte      -desc Enemies_TypeA_Counter     -format dec
ram_watch   add     0xD073      -type byte      -desc Enemies_TypeB_Counter     -format dec





#ram_watch   add     0xD028      -type byte      -desc ScrollSpeed           -format dec
#ram_watch   add     0xD009      -type byte      -desc Player_Y              -format dec
#ram_watch   add     0xD00c      -type byte      -desc Player_IsGrounded     -format dec
#ram_watch   add     0xD00e      -type word      -desc BgCurrentIndex        -format dec
#ram_watch   add     0xD010      -type byte      -desc FrameIndex            -format dec
#ram_watch   add     0xD015      -type word      -desc FirstVisibleColumn    -format dec
#ram_watch   add     0xD017      -type word      -desc LastVisibleColumn     -format dec
#ram_watch   add     0xD019      -type word      -desc Addr_Screen_FirstVisibleColumn        -format hex
#ram_watch   add     0xD01B      -type word      -desc Addr_Screen_LastVisibleColumn         -format hex
#ram_watch   add     0xD011      -type word      -desc BgAddrIndex                           -format hex
#ram_watch   add     0xD013      -type word      -desc BgAddrIndexFirstFrame                 -format hex


#ram_watch   add     0xD031      -type word      -desc UpdateBgObjects_Enemy_1_Pattern_Addr   -format hex
#ram_watch   add     0xD021      -type word      -desc UpdateBgObjects_CurrentAddr_State   -format hex
#ram_watch   add     0xD025      -type byte      -desc UpdateBgObjects_X_Offset_Value   -format hex

#ram_watch   add     0xD025      -type byte      -desc UpdateBgObjects_X_Offset_Value   -format hex



#ram_watch   add     0xD066      -type byte      -desc Enemies_Counter       -format dec
#
#ram_watch   add     0xD04e      -type byte      -desc Enemy_1_X             -format dec
##ram_watch   add     0xD04D      -type byte      -desc Enemy_1_Pattern       -format dec
##ram_watch   add     0xD04F      -type word      -desc Enemy_1_Pattern_Addr  -format hex
#
#ram_watch   add      0xD056      -type byte      -desc Enemy_2_X             -format dec
##ram_watch   add     0xD053      -type byte      -desc Enemy_2_Pattern       -format dec
##ram_watch   add     0xD055      -type word      -desc Enemy_2_Pattern_Addr  -format hex
#
#ram_watch   add     0xD05e      -type byte      -desc Enemy_3_X             -format dec
##ram_watch   add     0xD059      -type byte      -desc Enemy_3_Pattern       -format dec
##ram_watch   add     0xD05b      -type word      -desc Enemy_3_Pattern_Addr  -format hex



#ram_watch   add     0xD05e      -type byte      -desc IsProcessingFrame     -format dec



#ram_watch load gopenguin_debug