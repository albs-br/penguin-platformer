ShowTitleScreen:
	call 	BIOS_DISSCR

    ld 		a, 0
    ld 		(BIOS_CLIKSW), a     ; Key Press Click Switch 0:Off 1:On (1B/RW)

    ; call BIOS_INIGRP        ; Screen 2


; Define screen colors and mode
    ld 		a, COLOR_WHITE       	; Foregoung color
    ld 		(BIOS_FORCLR), a    
    ld 		a, COLOR_BLACK   		; Backgroung color
    ld 		(BIOS_BAKCLR), a     
    ld 		a, COLOR_BLACK       	; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color


; Set screen 2
	ld		a, 2	               	; Screen Mode (0..3 for MSX 1)
    call 	BIOS_CHGMOD        		; 


	call 	BIOS_DISSCR

	call 	ClearVRAM



    ; Load Patterns
	ld		hl, TitlePatterns        				; RAM address (source)
	ld		de, PatternsTable_1st_Third				; VRAM address (destiny)
	ld		bc, TitlePatterns.size					; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory
	ld		hl, TitlePatterns        				; RAM address (source)
	ld		de, PatternsTable_2nd_Third				; VRAM address (destiny)
	ld		bc, TitlePatterns.size					; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ; Load Colors
	ld		hl, TitleColors        				    ; RAM address (source)
	ld		de, ColorsTable_1st_Third				; VRAM address (destiny)
	ld		bc, TitleColors.size					; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory
	ld		hl, TitleColors        				    ; RAM address (source)
	ld		de, ColorsTable_2nd_Third				; VRAM address (destiny)
	ld		bc, TitleColors.size					; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ; Load Names Table
	; ld		hl, TitleNamesTable        				; RAM address (source)
	; ld		de, NamesTable				            ; VRAM address (destiny)
	; ld		bc, TitleNamesTable.size				; Block length
    ; call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory



	call 	BIOS_ENASCR 


.initTitle_1:
    ; revert left to right direction
    ld      a, (TitleScreen_Direction)
    cp      -1
    jp      z, .initTitle_LeftToRight

.initTitle_RightToLeft:
    ; Load Names Table to buffer
    ld      hl, TitleNamesTable                                 ; source
    ld      de, NamesTableBuffer                                ; destiny
    ld      bc, TitleNamesTable.size                            ; size
    ldir                                                        ; Copy BC bytes from HL to DE

    ; Init Variables (right to left)
    ld      a, -1
    ld      (TitleScreen_Direction), a
    
    ld      a, -1                                               ; first column - 1
    ld      (TitleScreen_EndColumn), a
    
    ld      a, TitleScreen_Constants.NUMBER_OF_COLUMNS          ; last column + 1
    ld      (TitleScreen_StartColumn), a

    jp      .initTitle

.initTitle_LeftToRight:
    ; Load Names Table to buffer (inverted)
    ld      hl, TitleNamesTable                                 ; source
    ld      de, NamesTableBuffer                                ; destiny
    ld      bc, TitleNamesTable.size                            ; size
    ; ldir                                                        ; Copy BC bytes from HL to DE
.loop_10:
    ld      a, (hl)
    sub     3           ; if (a == 3) a = 0 else a = 3
    jp      z, .cont
    ld      a, 3
.cont:    
    ld      (de), a
    inc     hl
    inc     de
    dec     bc
    ld      a, b
    or      c
    jp      nz, .loop_10

    ; Init Variables (left to right)
    ld      a, +1
    ld      (TitleScreen_Direction), a
    
    ld      a, TitleScreen_Constants.NUMBER_OF_COLUMNS          ; last column + 1
    ld      (TitleScreen_EndColumn), a
    
    ld      a, -1                                               ; first column - 1
    ld      (TitleScreen_StartColumn), a



.initTitle:
    ; Init title vars
    ;ld      a, TitleScreen_Constants.NUMBER_OF_COLUMNS          ; last column
    ld      a, (TitleScreen_StartColumn)
    ld      (Title_Index), a


.titleScreenLoop:
    ld      hl, BIOS_JIFFY              ; (v-blank sync)
    ld      a, (hl)
.waitVBlank:
    cp      (hl)
    jr      z, .waitVBlank


    ; animation only at each four frames
    ld      a, (BIOS_JIFFY)
    and     0000 0011 b
    jp      nz, .skipAnimation



    ; loop through all tiles doing animation
    ld      hl, NamesTableBuffer
    ld      c, 2        ; 2*256 = 512 iterations
.loop_1:
        ld      b, 0    ; 256 iterations
    .loop_2:
        
        ld      a, (hl)
        ; ignore if (a == 0) or (a == 3)
        cp      TitleScreen_Constants.FIRST_TILE
        jp      z, .skip
        cp      TitleScreen_Constants.MID_TILE_1
        jp      z, .skip
        cp      TitleScreen_Constants.MID_TILE_2
        jp      z, .skip
        cp      TitleScreen_Constants.MID_TILE_3
        jp      z, .skip

        cp      TitleScreen_Constants.LAST_TILE
        jp      nz, .skip_set_0
        ld      a, -1           ; will be 0 after increment
.skip_set_0:

        ; case else increment
        inc     a
        ld      (hl), a

    .skip:
        inc     hl
        djnz    .loop_2
    dec     c
    jp      nz, .loop_1

.skipAnimation:


    ; ----------- Title screen logic
    ld      a, (Title_Index)
    
    ;dec     a
    ld      hl, TitleScreen_Direction
    add     (hl)

    ;cp      -1                      ; if first column, restart
    ld      hl, TitleScreen_EndColumn
    cp      (hl)


    jp      z, .initTitle_1
    ld      (Title_Index), a


    ld      hl, NamesTableBuffer
    ld      b, 0
    ld      c, a
    add     hl, bc

    ld      b, TitleScreen_Constants.NUMBER_OF_LINES
.loopLines:
    ld      a, (hl)

;   -- if(a == 0 || a == 3) inc a
    cp      TitleScreen_Constants.FIRST_TILE
    jp      z, .startAnimation
    cp      TitleScreen_Constants.MID_TILE_1
    jp      z, .startAnimation
    cp      TitleScreen_Constants.MID_TILE_2
    jp      z, .startAnimation
    cp      TitleScreen_Constants.MID_TILE_3
    jp      z, .startAnimation
    jp      .continue

.startAnimation:
    inc     a

.continue:
    ld      (hl), a

    ld      de, TitleScreen_Constants.NUMBER_OF_COLUMNS
    add     hl, de                                          ; next line

    djnz    .loopLines



    ; Load Names Table from buffer to VRAM
	ld		hl, NamesTableBuffer        			; RAM address (source)
	ld		de, NamesTable				            ; VRAM address (destiny)
	ld		bc, 512 ;NamesTableBuffer.size				; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory


    jp      .titleScreenLoop

    ret
