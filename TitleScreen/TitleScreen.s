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

    ; Load Names Table to buffer
    ld      hl, TitleNamesTable                                 ; source
    ld      de, NamesTableBuffer                                ; destiny
    ld      bc, TitleNamesTable.size                            ; size
    ldir                                                        ; Copy BC bytes from HL to DE


	call 	BIOS_ENASCR 

.initTitle:
    ; Init title vars
    ld      a, 32                       ; last column
    ld      (Title_Index), a


.titleScreenLoop:
    ld      hl, BIOS_JIFFY              ; (v-blank sync)
    ld      a, (hl)
.waitVBlank:
    cp      (hl)
    jr      z, .waitVBlank

    ; call    WaitSomeSeconds


    ; loop through all tiles doing animation
    ld      hl, NamesTableBuffer
    ld      c, 2        ; 2*256 = 512 iterations
.loop_1:
        ld      b, 0    ; 256 iterations
    .loop_2:
        
        ld      a, (hl)
        ; ignore if (a == 0) or (a == 3)
        cp      FIRST_TILE
        jp      z, .skip
        cp      MID_TILE
        jp      z, .skip

        cp      LAST_TILE
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



    ; ----------- Title screen logic
    ld      a, (Title_Index)
    dec     a
    cp      FIRST_TILE - 1
    jp      z, .initTitle
    ld      (Title_Index), a


    ld      hl, NamesTableBuffer
    ld      b, 0
    ld      c, a
    add     hl, bc

    ld      b, 16           ; number of lines
.loopLines:
    ld      a, (hl)

;   --- switch 0/1 logic
;     cp      1
;     jp      z, .set_0
; ;set_1
;     ld      a, 1
;     jp      .continue
; .set_0:
;     ld      a, 0

;   --- loop 0-3 logic
;     inc     a
;     cp      6
;     jp      z, .set_0
;     jp      .continue
; .set_0:
;     ld      a, 0

;   -- if(a == 0 || a == 3) inc a
    cp      FIRST_TILE
    jp      z, .startAnimation
    cp      MID_TILE
    jp      z, .startAnimation
    jp      .continue

.startAnimation:
    inc     a

.continue:
    ld      (hl), a

    ld      de, 32
    add     hl, de

    djnz    .loopLines



    ; Load Names Table from buffer to VRAM
	ld		hl, NamesTableBuffer        			; RAM address (source)
	ld		de, NamesTable				            ; VRAM address (destiny)
	ld		bc, 512 ;NamesTableBuffer.size				; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory


    jp      .titleScreenLoop

    ret
