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
    
    cp      8
    call    z, .frame_2
    
    cp      12
    ; call    z, .frame_3
    
    cp      16
    ; call    z, .frame_4
    
    cp      20
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



    ; -------------------- frame 2:  Tiles               (pixel size 4x4)
.frame_2:
    
    call    HideAllSprites

    ; set sprites normal size
	ld		c, 1	               		; VDP Register Number (0..27, 32..46)
	ld		b, 1110 0010 b   	        ; Data To Write
    call 	BIOS_WRTVDP        		    ; 

    ; Load Tile Patterns
	ld		hl, PATTERN_TABLE_FRAME_2			    ; RAM address (source)
	ld		de, PatternsTable_2nd_Third + (8 * 1)   ; VRAM address (destiny)
	ld		bc, PATTERN_TABLE_FRAME_2.size		    ; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ; Load Tile Colors
	ld		hl, COLOR_TABLE_FRAME_2			        ; RAM address (source)
	ld		de, ColorsTable_2nd_Third + (8 * 1)     ; VRAM address (destiny)
	ld		bc, COLOR_TABLE_FRAME_2.size		    ; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ; Load Names Table
	ld		hl, NAMES_TABLE_FRAME_2			        ; RAM address (source)
	ld		de, NamesTable + 256 + (32/2) - (8/2)   ; VRAM address (destiny)
    ld      b, 8
.loop_NamesTable:
    push    bc
        push    hl
            push    de
                ld		bc, 8 ;NAMES_TABLE_FRAME_2.size		    ; Block length
                call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory
            pop     de

            ex      de, hl
            ld      bc, 32
            add     hl, bc  ; next namestable line
            ex      de, hl
        pop     hl
        
        ld      bc, 8
        add     hl, bc  ; next pattern line

    pop     bc
    djnz    .loop_NamesTable

    ret    

    ; frame 3:  Tiles               (pixel size 8x8)
    ; frame 4:  Tiles               (pixel size 16x16)
    ; frame 5:  Tiles               (pixel size 32x32)

    ; 6 frames x 4 = 24 frames (less than half second)

