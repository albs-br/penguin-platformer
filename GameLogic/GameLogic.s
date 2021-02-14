GameLogic:

    ld      hl, X
    inc     (hl)

    call    UpdateSpriteAttrTableBuffer

    ret


UpdateSpriteAttrTableBuffer:
    ld      a, (X)
    ld      hl, SpriteAttrTableBuffer + 1
    ld      (hl), a

    ret