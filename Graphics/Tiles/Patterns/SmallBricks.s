; TilePatterns_SmallBricks_SizeInChars:           equ ((TilePatterns_SmallBricks_End - TilePatterns_SmallBricks_Start) / 8)
; TilePatterns_SmallBricks_Top_SizeInChars:       equ TilePatterns_SmallBricks_SizeInChars / 2
; TilePatterns_SmallBricks_Bottom_SizeInChars:    equ TilePatterns_SmallBricks_SizeInChars / 2

;TilePatterns_SmallBricks_Start:
; -------- Tile transitions from Black to Small brick - top
;Frame # 0
        db      00000000 b
        db      00000001 b
        db      00000001 b
        db      00000001 b
        db      00000000 b
        db      00000001 b
        db      00000001 b
        db      00000001 b

;Frame # 1
        db      00000000 b
        db      00000011 b
        db      00000011 b
        db      00000011 b
        db      00000000 b
        db      00000011 b
        db      00000011 b
        db      00000011 b

;Frame # 2
        db      00000000 b
        db      00000111 b
        db      00000111 b
        db      00000111 b
        db      00000000 b
        db      00000111 b
        db      00000111 b
        db      00000111 b

;Frame # 3
        db      00000000 b
        db      00001111 b
        db      00001111 b
        db      00001111 b
        db      00000000 b
        db      00001110 b
        db      00001110 b
        db      00001110 b

;Frame # 4
        db      00000000 b
        db      00011111 b
        db      00011111 b
        db      00011111 b
        db      00000000 b
        db      00011101 b
        db      00011101 b
        db      00011101 b

;Frame # 5
        db      00000000 b
        db      00111111 b
        db      00111111 b
        db      00111111 b
        db      00000000 b
        db      00111011 b
        db      00111011 b
        db      00111011 b

;Frame # 6
        db      00000000 b
        db      01111111 b
        db      01111111 b
        db      01111111 b
        db      00000000 b
        db      01110111 b
        db      01110111 b
        db      01110111 b

;Frame # 7
        db      00000000 b
        db      11111110 b
        db      11111110 b
        db      11111110 b
        db      00000000 b
        db      11101111 b
        db      11101111 b
        db      11101111 b

; ----------------------------
; -------- Tile transitions from Small brick - top to Small brick - top
;Frame # 0
        db      00000000 b
        db      11111101 b
        db      11111101 b
        db      11111101 b
        db      00000000 b
        db      11011111 b
        db      11011111 b
        db      11011111 b

;Frame # 1
        db      00000000 b
        db      11111011 b
        db      11111011 b
        db      11111011 b
        db      00000000 b
        db      10111111 b
        db      10111111 b
        db      10111111 b

;Frame # 2
        db      00000000 b
        db      11110111 b
        db      11110111 b
        db      11110111 b
        db      00000000 b
        db      01111111 b
        db      01111111 b
        db      01111111 b

;Frame # 3
        db      00000000 b
        db      11101111 b
        db      11101111 b
        db      11101111 b
        db      00000000 b
        db      11111110 b
        db      11111110 b
        db      11111110 b

;Frame # 4
        db      00000000 b
        db      11011111 b
        db      11011111 b
        db      11011111 b
        db      00000000 b
        db      11111101 b
        db      11111101 b
        db      11111101 b

;Frame # 5
        db      00000000 b
        db      10111111 b
        db      10111111 b
        db      10111111 b
        db      00000000 b
        db      11111011 b
        db      11111011 b
        db      11111011 b

;Frame # 6
        db      00000000 b
        db      01111111 b
        db      01111111 b
        db      01111111 b
        db      00000000 b
        db      11110111 b
        db      11110111 b
        db      11110111 b

;Frame # 7
        db      00000000 b
        db      11111110 b
        db      11111110 b
        db      11111110 b
        db      00000000 b
        db      11101111 b
        db      11101111 b
        db      11101111 b

; ----------------------------
; -------- Tile transitions from Small brick - top to Black
;Frame # 0
        db      00000000 b
        db      11111100 b
        db      11111100 b
        db      11111100 b
        db      00000000 b
        db      11011110 b
        db      11011110 b
        db      11011110 b

;Frame # 1
        db      00000000 b
        db      11111000 b
        db      11111000 b
        db      11111000 b
        db      00000000 b
        db      10111100 b
        db      10111100 b
        db      10111100 b

;Frame # 2
        db      00000000 b
        db      11110000 b
        db      11110000 b
        db      11110000 b
        db      00000000 b
        db      01111000 b
        db      01111000 b
        db      01111000 b

;Frame # 3
        db      00000000 b
        db      11100000 b
        db      11100000 b
        db      11100000 b
        db      00000000 b
        db      11110000 b
        db      11110000 b
        db      11110000 b

;Frame # 4
        db      00000000 b
        db      11000000 b
        db      11000000 b
        db      11000000 b
        db      00000000 b
        db      11100000 b
        db      11100000 b
        db      11100000 b

;Frame # 5
        db      00000000 b
        db      10000000 b
        db      10000000 b
        db      10000000 b
        db      00000000 b
        db      11000000 b
        db      11000000 b
        db      11000000 b

;Frame # 6
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      10000000 b
        db      10000000 b
        db      10000000 b

;Frame # 7
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b

; ----------------------------
; -------- Tile transitions from Black to Small brick - bottom
;Frame # 0
        db      00000000 b
        db      00000001 b
        db      00000001 b
        db      00000001 b
        db      00000000 b
        db      00000001 b
        db      00000001 b
        db      00000001 b

;Frame # 1
        db      00000000 b
        db      00000011 b
        db      00000011 b
        db      00000011 b
        db      00000000 b
        db      00000011 b
        db      00000011 b
        db      00000011 b

;Frame # 2
        db      00000000 b
        db      00000111 b
        db      00000111 b
        db      00000111 b
        db      00000000 b
        db      00000111 b
        db      00000111 b
        db      00000111 b

;Frame # 3
        db      00000000 b
        db      00001111 b
        db      00001111 b
        db      00001111 b
        db      00000000 b
        db      00001110 b
        db      00001110 b
        db      00001110 b

;Frame # 4
        db      00000000 b
        db      00011111 b
        db      00011111 b
        db      00011111 b
        db      00000000 b
        db      00011101 b
        db      00011101 b
        db      00011101 b

;Frame # 5
        db      00000000 b
        db      00111111 b
        db      00111111 b
        db      00111111 b
        db      00000000 b
        db      00111011 b
        db      00111011 b
        db      00111011 b

;Frame # 6
        db      00000000 b
        db      01111111 b
        db      01111111 b
        db      01111111 b
        db      00000000 b
        db      01110111 b
        db      01110111 b
        db      01110111 b

;Frame # 7
        db      00000000 b
        db      11111110 b
        db      11111110 b
        db      11111110 b
        db      00000000 b
        db      11101111 b
        db      11101111 b
        db      11101111 b

; ----------------------------
; -------- Tile transitions from Small brick - bottom to Small brick - bottom
;Frame # 0
        db      00000000 b
        db      11111101 b
        db      11111101 b
        db      11111101 b
        db      00000000 b
        db      11011111 b
        db      11011111 b
        db      11011111 b

;Frame # 1
        db      00000000 b
        db      11111011 b
        db      11111011 b
        db      11111011 b
        db      00000000 b
        db      10111111 b
        db      10111111 b
        db      10111111 b

;Frame # 2
        db      00000000 b
        db      11110111 b
        db      11110111 b
        db      11110111 b
        db      00000000 b
        db      01111111 b
        db      01111111 b
        db      01111111 b

;Frame # 3
        db      00000000 b
        db      11101111 b
        db      11101111 b
        db      11101111 b
        db      00000000 b
        db      11111110 b
        db      11111110 b
        db      11111110 b

;Frame # 4
        db      00000000 b
        db      11011111 b
        db      11011111 b
        db      11011111 b
        db      00000000 b
        db      11111101 b
        db      11111101 b
        db      11111101 b

;Frame # 5
        db      00000000 b
        db      10111111 b
        db      10111111 b
        db      10111111 b
        db      00000000 b
        db      11111011 b
        db      11111011 b
        db      11111011 b

;Frame # 6
        db      00000000 b
        db      01111111 b
        db      01111111 b
        db      01111111 b
        db      00000000 b
        db      11110111 b
        db      11110111 b
        db      11110111 b

;Frame # 7
        db      00000000 b
        db      11111110 b
        db      11111110 b
        db      11111110 b
        db      00000000 b
        db      11101111 b
        db      11101111 b
        db      11101111 b

; ----------------------------
; -------- Tile transitions from Small brick - bottom to Black
;Frame # 0
        db      00000000 b
        db      11111100 b
        db      11111100 b
        db      11111100 b
        db      00000000 b
        db      11011110 b
        db      11011110 b
        db      11011110 b

;Frame # 1
        db      00000000 b
        db      11111000 b
        db      11111000 b
        db      11111000 b
        db      00000000 b
        db      10111100 b
        db      10111100 b
        db      10111100 b

;Frame # 2
        db      00000000 b
        db      11110000 b
        db      11110000 b
        db      11110000 b
        db      00000000 b
        db      01111000 b
        db      01111000 b
        db      01111000 b

;Frame # 3
        db      00000000 b
        db      11100000 b
        db      11100000 b
        db      11100000 b
        db      00000000 b
        db      11110000 b
        db      11110000 b
        db      11110000 b

;Frame # 4
        db      00000000 b
        db      11000000 b
        db      11000000 b
        db      11000000 b
        db      00000000 b
        db      11100000 b
        db      11100000 b
        db      11100000 b

;Frame # 5
        db      00000000 b
        db      10000000 b
        db      10000000 b
        db      10000000 b
        db      00000000 b
        db      11000000 b
        db      11000000 b
        db      11000000 b

;Frame # 6
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      10000000 b
        db      10000000 b
        db      10000000 b

;Frame # 7
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b
        db      00000000 b

; ----------------------------
;TilePatterns_SmallBricks_End:
