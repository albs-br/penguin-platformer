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


.titleScreenLoop:
    ld      hl, BIOS_JIFFY              ; (v-blank sync)
    ld      a, (hl)
.waitVBlank:
    cp      (hl)
    jr      z, .waitVBlank


    ; ----------- title screen logic here


    ; Load Names Table from buffer to VRAM
	ld		hl, NamesTableBuffer        			; RAM address (source)
	ld		de, NamesTable				            ; VRAM address (destiny)
	ld		bc, NamesTableBuffer.size				; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory


    jp      .titleScreenLoop

    ret

TitlePatterns:
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      00000000 b

    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      11111110 b
    db      00000000 b
.size:  equ $ - TitlePatterns

TitleColors:
    db      0xf0
    db      0xf0
    db      0xf0
    db      0xf0
    db      0xf0
    db      0xf0
    db      0xf0
    db      0xf0

    db      0x48
    db      0x48
    db      0x48
    db      0x48
    db      0x48
    db      0x48
    db      0x48
    db      0x48
.size:  equ $ - TitleColors

TitleNamesTable:
    ; db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ; db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
    db      1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db      1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0
    db      1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1
    db      1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1
    db      1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1
    db      1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1
    db      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ;db      0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1
.size:  equ $ - TitleNamesTable
