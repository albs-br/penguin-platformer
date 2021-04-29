#ram_watch   add     0xD02b      -type byte      -desc D_Above       -format dec
#ram_watch   add     0xD02c      -type byte      -desc D_Right       -format dec
#ram_watch   add     0xD02d      -type byte      -desc D_Below       -format dec
#ram_watch   add     0xD02e      -type byte      -desc D_TileNumber  -format dec


ram_watch   add     0xD028      -type byte      -desc ScrollSpeed           -format dec
ram_watch   add     0xD007      -type byte      -desc Player_Y              -format dec
ram_watch   add     0xD008      -type byte      -desc Player_Sprite_Number  -format dec
ram_watch   add     0xD00a      -type byte      -desc Player_IsGrounded     -format dec
ram_watch   add     0xD00e      -type word      -desc BgCurrentIndex        -format dec
ram_watch   add     0xD010      -type byte      -desc FrameIndex            -format dec
ram_watch   add     0xD015      -type word      -desc FirstVisibleColumn    -format dec
ram_watch   add     0xD017      -type word      -desc LastVisibleColumn     -format dec
ram_watch   add     0xD019      -type word      -desc Addr_Screen_FirstVisibleColumn        -format hex
ram_watch   add     0xD01B      -type word      -desc Addr_Screen_LastVisibleColumn         -format hex
ram_watch   add     0xD011      -type word      -desc BgAddrIndex                           -format hex
ram_watch   add     0xD013      -type word      -desc BgAddrIndexFirstFrame                 -format hex


#ram_watch load gopenguin_debug