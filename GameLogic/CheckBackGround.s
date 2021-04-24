
; Checks if a given XY coord is over a blank tile
;   Inputs:
;       H: x coordinate (0-255)
;       L: y coordinate (0-191)
;   Output:
;       z: is at empty space
;       nz: is not at empty space
CheckBackGround_Right:
    ; check if player is at empty space
    ; formula: COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)     (only first 4 rows)

    push    hl                  ; save h (x coord)

    ; b = LINE_NUMBER:
    ld      a, l
    srl     a                   ; divide by 8
    srl     a
    srl     a
    ld      c, a
    and     0000 0011 b         ; mask to get only lower 2 bits of line number and make it a line number 0-3
    ld      b, a
    
    ; hl = (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER
    ld      hl, 0
    jp      z, .continue
    ld      de, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8
.loopMulti:
    add     hl, de
    djnz    .loopMulti
.continue:

    ; Add FrameIndex - 7 to X to compensate for the scrolled tiles
    ld      a, (FrameIndex)
    sub     7
    ld      d, a

    ; de = COL_NUMBER:
    pop     af                  ; restore h (x coord)

    add     d

    ;ld      a, d
    srl     a                   ; divide by 8
    srl     a
    srl     a
    ld      d, 0
    ld      e, a

    ; de = COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)
    add     hl, de
    ex      de, hl


    ; set MegaROM page
    ; c = MegaROM Page number
    ld      a, c
    and     0001 1100 b         ; mask to get the page number (0-5)
    srl     a                   ; align to right
    srl     a
    inc     a                   ; pages are numbered 1-6, not 0-5
    ; ld      c, a
    ; ld      a, c
    ld	    (Seg_P8000_SW), a

    ld      hl, (BgAddrIndex)
    ;ld      de, 2 + (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * 2
    add     hl, de
    ld      a, (hl)
    or      a

    ret



; TODO: Refactoring: CheckBackGround_Left and Right has 95% code in common (!!!)

; Checks if a given XY coord is over a blank tile
;   Inputs:
;       H: x coordinate (0-255)
;       L: y coordinate (0-191)
;   Output:
;       z: is at empty space
;       nz: is not at empty space
CheckBackGround_Left:
    ; check if player is at empty space
    ; formula: COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)     (only first 4 rows)

    push    hl                  ; save h (x coord)

    ; b = LINE_NUMBER:
    ld      a, l
    srl     a                   ; divide by 8
    srl     a
    srl     a
    ld      c, a
    and     0000 0011 b         ; mask to get only lower 2 bits of line number and make it a line number 0-3
    ld      b, a
    
    ; hl = (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER
    ld      hl, 0
    jp      z, .continue
    ld      de, TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8
.loopMulti:
    add     hl, de
    djnz    .loopMulti
.continue:

    ; Add FrameIndex from X to compensate for the scrolled tiles
    ld      a, (FrameIndex)
    ld      d, a

    ; de = COL_NUMBER:
    pop     af                  ; restore h (x coord)

    add     d

    ;ld      a, d
    srl     a                   ; divide by 8
    srl     a
    srl     a
    ld      d, 0
    ld      e, a

    ; de = COL_NUMBER + ((TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * LINE_NUMBER)
    add     hl, de
    ex      de, hl


    ; set MegaROM page
    ; c = MegaROM Page number
    ld      a, c
    and     0001 1100 b         ; mask to get the page number (0-5)
    srl     a                   ; align to right
    srl     a
    inc     a                   ; pages are numbered 1-6, not 0-5
    ; ld      c, a
    ; ld      a, c
    ld	    (Seg_P8000_SW), a

    ld      hl, (BgAddrIndex)
    ;ld      de, 2 + (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * 2
    add     hl, de
    ld      a, (hl)
    or      a

    ret



; Check if there is a tile under the player
;   Output:
;       z: is at empty space
;       nz: is not at empty space
CheckIfPlayerIsGrounded:
    
    ; Check bottom left (x + 4, y + 15)
    ld      a, (Player_X)
    add     4
    ld      h, a
    
    ld      a, (Player_Y)
    add     PENGUIN_HEIGHT + 1
    ld      l, a
    
    push    hl
        call    CheckBackGround_Left
    pop     hl

    jp      nz, .isGrounded                  ; if grounded return


    ; Check bottom right (x + 12, y + 15)
    ; ld      a, h
    ; add     PENGUIN_WIDTH - 8
    ld      a, (Player_X)
    add     PENGUIN_WIDTH - 1 - 4
    ld      h, a

    call    CheckBackGround_Right

    ret     z

.isGrounded:
    ; push    af
    ;     ld      a, (Player_Y)
    ;     dec     a
    ;     ld      (Player_Y), a
    ; pop     af
    ret



; Check if there is a tile on the right
;   Output:
;       z: is at empty space
;       nz: is not at empty space
CheckIfPlayerHasTileOnTheRight:
    ld      a, (Player_X)
    add     PENGUIN_WIDTH - 1      ; PENGUIN_WIDTH - 1: x of last column;
    ld      h, a
    
    ; Check middle right
    ld      a, (Player_Y)
    add     8
    ld      l, a
    
    call    CheckBackGround_Right
    
    ret



; Check if there is a tile on the left
;   Output:
;       z: is at empty space
;       nz: is not at empty space
CheckIfPlayerHasTileOnTheLeft:
    ld      a, (Player_X)
    ld      h, a
    
    ; Check middle left
    ld      a, (Player_Y)
    add     8
    ld      l, a
    
    call    CheckBackGround_Left
    
    ;ret
    jp      nz, .hasTileOnTheLeft
    ret
    
.hasTileOnTheLeft:
    ; push    af
    ;     ld      a, (Player_X)
    ;     inc     a
    ;     ld      (Player_X), a
    ; pop     af
    ret
    


; Check if there is a tile above the player
;   Output:
;       z: is at empty space
;       nz: is not at empty space
CheckIfPlayerHasTileAbove:
    ; Check if there is a tile above the player (top left)
    ld      a, (Player_Y)
    ld      l, a

    ld      a, (Player_X)
    add     5
    ld      h, a

    call    CheckBackGround_Left
    ret     nz


    ; Check if there is a tile above the player (top right)
    ld      a, (Player_Y)
    ld      l, a

    ld      a, (Player_X)
    add     PENGUIN_WIDTH - 1 - 5
    ld      h, a
    call    CheckBackGround_Right
    
    ret