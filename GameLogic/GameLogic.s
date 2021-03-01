GameLogic:

    ; ld      hl, X
    ; inc     (hl)

    ; [debug]
    ; check if player is at empty space
    ; set MegaROM initial page
    ld      a, 1
    ld	    (Seg_P8000_SW), a
    ld      hl, (BgAddrIndex)
    ld      bc, 0 + (TILE_MAP_WIDTH_IN_8X8_COLUMNS * 8) * 2
    add     hl, bc
    ld      a, (hl)
    or      a
    call    z, .playerAtEmptySpace



    call    UpdateSpriteAttrTableBuffer

    ret


.playerAtEmptySpace:
    ld      hl, Player_Y
    inc     (hl)
    ret

UpdateSpriteAttrTableBuffer:
    ld      hl, SpriteAttrTableBuffer
    ld      a, (Player_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Player_X)
    ld      (hl), a

    ret