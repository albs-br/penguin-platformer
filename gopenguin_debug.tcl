ram_watch   add     0xD02A      -type byte      -desc D_Above       -format dec
ram_watch   add     0xD02B      -type byte      -desc D_Right       -format dec
ram_watch   add     0xD02C      -type byte      -desc D_Below       -format dec
ram_watch   add     0xD02D      -type byte      -desc D_TileNumber  -format dec

ram_watch   add     0xD008      -type byte      -desc Player_Sprite_Number  -format dec
ram_watch   add     0xD00a      -type byte      -desc Player_IsGrounded     -format dec
ram_watch   add     0xD00d      -type word      -desc BgCurrentIndex        -format dec
ram_watch   add     0xD00F      -type byte      -desc FrameIndex            -format dec
ram_watch   add     0xD014      -type word      -desc FirstVisibleColumn    -format dec
ram_watch   add     0xD016      -type word      -desc LastVisibleColumn     -format dec


#ram_watch load gopenguin_debug