; Input:
;   A: level number
LevelScreen:

.levelScreenLoop:
    ld      hl, BIOS_JIFFY              ; (v-blank sync)
    ld      a, (hl)
.waitVBlank:
    cp      (hl)
    jr      z, .waitVBlank


    ; frame 0:  Sprite normal       (pixel size 1x1)
    ; frame 1:  Sprite magnified    (pixel size 2x2)
    ; frame 2:  Tiles               (pixel size 4x4)
    ; frame 3:  Tiles               (pixel size 8x8)
    ; frame 4:  Tiles               (pixel size 16x16)
    ; frame 5:  Tiles               (pixel size 32x32)

    ; 6 frames x 4 = 24 frames (less than half second)

    ret