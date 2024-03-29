TitleScreen_Constants:
    .NUMBER_OF_COLUMNS:  equ 32         ; don't change
    .NUMBER_OF_LINES:    equ 16

    .FIRST_TILE:         equ 0
    .MID_TILE_1:         equ 3
    .MID_TILE_2:         equ 6
    .MID_TILE_3:         equ 9
    .LAST_TILE:          equ 11

TitlePatterns:
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      00000000 b

    ; db      00000000 b
    ; db      00000000 b
    ; db      00111110 b
    ; db      00111110 b
    ; db      01111110 b
    ; db      01111110 b
    ; db      11111110 b
    ; db      00000000 b

    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      00000110 b
    ; db      00111110 b
    ; db      11111110 b
    ; db      00000000 b

    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      11111110 b
    ; db      00000000 b

    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      00000110 b
    ; db      00111110 b
    ; db      11111110 b
    ; db      00000000 b

    ; db      00000000 b
    ; db      00000000 b
    ; db      00111110 b
    ; db      00111110 b
    ; db      01111110 b
    ; db      01111110 b
    ; db      11111110 b
    ; db      00000000 b

    ; -----------------------------

    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      00000000 b

    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      00000000 b

    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00000000 b

    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00000000 b

    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00000000 b

    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      00000000 b

    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      00000000 b

    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      00000000 b

    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00000000 b

    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00010000 b
    db      00000000 b

    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00111000 b
    db      00000000 b

    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      01111100 b
    db      00000000 b

    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      00000000 b

    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      11111110 b
    ; db      00000000 b

    ; db      00000000 b
    ; db      00000000 b
    ; db      00111000 b
    ; db      00111000 b
    ; db      00111000 b
    ; db      00000000 b
    ; db      00000000 b
    ; db      00000000 b
.size:  equ $ - TitlePatterns

TitleColors_1:
    db      0x70
    db      0x50
    db      0x50
    db      0x50
    db      0x40
    db      0x40
    db      0x40
    db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

    ; db      0x70
    ; db      0x50
    ; db      0x50
    ; db      0x50
    ; db      0x40
    ; db      0x40
    ; db      0x40
    ; db      0x40

.size:  equ $ - TitleColors_1

TitleColors_2:
    db      0x90
    db      0x80
    db      0x80
    db      0x80
    db      0x60
    db      0x60
    db      0x60
    db      0x60
.size:  equ $ - TitleColors_2

TitleColors_3:
    db      0x30
    db      0x20
    db      0x20
    db      0x20
    db      0xc0
    db      0xc0
    db      0xc0
    db      0xc0
.size:  equ $ - TitleColors_3

TitleColors_4:
    db      0xf0
    db      0xb0
    db      0xb0
    db      0xb0
    db      0xa0
    db      0xa0
    db      0xa0
    db      0xa0
.size:  equ $ - TitleColors_4

TitleNamesTable:
    ; db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      3, 0, 0, 3, 0, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      3, 0, 0, 0, 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      3, 0, 3, 3, 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      3, 0, 0, 3, 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      3, 3, 3, 3, 0, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0
    db      3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      3, 0, 0, 3, 0, 3, 3, 3, 3, 0, 3, 3, 3, 0, 0, 3, 3, 3, 3, 0, 3, 0, 0, 3, 0, 3, 3, 0, 3, 3, 3, 0
    db      3, 0, 0, 3, 0, 3, 0, 0, 3, 0, 0, 3, 0, 3, 0, 3, 0, 0, 3, 0, 3, 0, 0, 3, 0, 0, 3, 0, 0, 3, 0, 3
    db      3, 3, 3, 3, 0, 3, 3, 3, 3, 0, 0, 3, 0, 3, 0, 3, 0, 0, 3, 0, 3, 0, 0, 3, 0, 0, 3, 0, 0, 3, 0, 3
    db      3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 3, 0, 3, 3, 3, 3, 0, 3, 0, 0, 3, 0, 0, 3, 0, 0, 3, 0, 3
    db      3, 0, 0, 0, 0, 3, 3, 3, 3, 0, 0, 3, 0, 3, 0, 0, 0, 0, 3, 0, 0, 3, 3, 0, 0, 3, 3, 3, 0, 3, 0, 3
    db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
    db      255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
    db      255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
    db      255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
    db      255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
    db      255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
    db      255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
    db      255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
.size:  equ $ - TitleNamesTable
