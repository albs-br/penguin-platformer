; Input:
;   A: level number
LevelScreen:

    call    InitVram

    xor     a
    ld      (LevelScreen_Counter), a

.levelScreenLoop:
    ld      hl, BIOS_JIFFY              ; (v-blank sync)
    ld      a, (hl)
.waitVBlank:
    cp      (hl)
    jr      z, .waitVBlank




    ld      a, (LevelScreen_Counter)
    
    cp      4               ; if(a >=0 && a<= 3)
    jp      c, .frame_0
    
    cp      8               ; if(a >=4 && a<= 7)
    ; jp      c, .frame_1
    
    cp      12              ; if(a >=8 && a<= 11)
    ; jp      c, .frame_2
    
    cp      16              ; if(a >=12 && a<= 15)
    ; jp      c, .frame_3
    
    cp      20              ; if(a >=16 && a<= 19)
    ; jp      c, .frame_4
    
    cp      24              ; if(a >=20 && a<= 23)
    ; jp      c, .frame_5
    
.eternalLoop:
    jp      .eternalLoop


    ; -------------------- frame 0:  Sprite normal       (pixel size 1x1)
.frame_0:
	call 	BIOS_DISSCR

    ; Create Sprites
	ld		hl, SpritePatterns        				; RAM address (source)
	ld		de, SpritePatternTable					; VRAM address (destiny)
	ld		bc, 3*16 ; SpritePatterns.size					; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ; Load Sprite Attributes
	ld		hl, SPRITE_ATT_TABLE_FRAME_0			; RAM address (source)
	ld		de, SpriteAttrTable					    ; VRAM address (destiny)
	ld		bc, SPRITE_ATT_TABLE_FRAME_0.size		; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

	call 	BIOS_ENASCR

.eternalLoop1:
    jp      .eternalLoop1

    ret

SPRITE_ATT_TABLE_FRAME_0:
    ; Y, X, pat, color
    db (192/2)-8, (256/2)-8, 1*4, 4
    db (192/2)-8, (256/2)-8, 2*4, 15
.size: equ $ - SPRITE_ATT_TABLE_FRAME_0

    ; frame 1:  Sprite magnified    (pixel size 2x2)
    ; frame 2:  Tiles               (pixel size 4x4)
    ; frame 3:  Tiles               (pixel size 8x8)
    ; frame 4:  Tiles               (pixel size 16x16)
    ; frame 5:  Tiles               (pixel size 32x32)

    ; 6 frames x 4 = 24 frames (less than half second)

    ld      hl, LevelScreen_Counter
    inc     (hl)

    ret