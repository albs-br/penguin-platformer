; Input:
;   A: level number
LevelScreen:

    call    InitVram

    call    BIOS_ENASCR

    xor     a
    ld      (LevelScreen_Counter), a

.levelScreenLoop:
    ld      hl, BIOS_JIFFY              ; (v-blank sync)
    ld      a, (hl)
.waitVBlank:
    cp      (hl)
    jr      z, .waitVBlank




    ld      a, (LevelScreen_Counter)
    
    cp      0
    call    z, .frame_0
    
    cp      4
    call    z, .frame_1
    
    ; cp      8
    ; call    z, .frame_2
    
    cp      12              ; if(a >=12 && a<= 15)
    ; call    z, .frame_3
    
    cp      16              ; if(a >=16 && a<= 19)
    ; call    z, .frame_4
    
    cp      20              ; if(a >=20 && a<= 23)
    ; call    z, .frame_5
    
    ; cp      255
    ; jp    z, .end


    ld      hl, LevelScreen_Counter
    inc     (hl)

    jp      .levelScreenLoop



    ; -------------------- frame 0:  Sprite normal       (pixel size 1x1)
.frame_0:
	;call 	BIOS_DISSCR

    ; set sprites normal size
	ld		c, 1	               		; VDP Register Number (0..27, 32..46)
	ld		b, 1110 0010 b   	        ; Data To Write
    call 	BIOS_WRTVDP        		    ; 

    ; ; Create Sprites
	; ld		hl, SpritePatterns        				; RAM address (source)
	; ld		de, SpritePatternTable					; VRAM address (destiny)
	; ld		bc, 3*16 ; SpritePatterns.size					; Block length
    ; call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ; Load Sprite Attributes
	ld		hl, SPRITE_ATT_TABLE_FRAME_0			; RAM address (source)
	ld		de, SpriteAttrTable					    ; VRAM address (destiny)
	ld		bc, SPRITE_ATT_TABLE_FRAME_0.size		; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

	;call 	BIOS_ENASCR

    ret

    ; -------------------- frame 1:  Sprite magnified    (pixel size 2x2)
.frame_1:
    ; set sprites magnified
    ;   bit 0: MAG enlarges the sprites when 1 is written. (0 by default)
	ld		c, 1	               		; VDP Register Number (0..27, 32..46)
	ld		b, 1110 0011 b   	        ; Data To Write
    call 	BIOS_WRTVDP        		    ; 

    ; Load Sprite Attributes
	ld		hl, SPRITE_ATT_TABLE_FRAME_1			; RAM address (source)
	ld		de, SpriteAttrTable					    ; VRAM address (destiny)
	ld		bc, SPRITE_ATT_TABLE_FRAME_1.size		; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ret



    ; frame 2:  Tiles               (pixel size 4x4)
    ; frame 3:  Tiles               (pixel size 8x8)
    ; frame 4:  Tiles               (pixel size 16x16)
    ; frame 5:  Tiles               (pixel size 32x32)

    ; 6 frames x 4 = 24 frames (less than half second)




; --------------- Data
SPRITE_ATT_TABLE_FRAME_0:
    ; Y, X, pat, color
    db (192/2)-8, (256/2)-8, 1*4, 4
    db (192/2)-8, (256/2)-8, 2*4, 15
.size: equ $ - SPRITE_ATT_TABLE_FRAME_0

SPRITE_ATT_TABLE_FRAME_1:
    ; Y, X, pat, color
    db (192/2)-16, (256/2)-16, 1*4, 4
    db (192/2)-16, (256/2)-16, 2*4, 15
.size: equ $ - SPRITE_ATT_TABLE_FRAME_1
