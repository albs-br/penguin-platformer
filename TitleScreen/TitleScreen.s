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
	ld		hl, TitlePatterns        				; RAM address (source)
	ld		de, PatternsTable_3rd_Third				; VRAM address (destiny)
	ld		bc, TitlePatterns.size					; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ; ; Load Colors
	; ld		hl, TitleColors_1        				    ; RAM address (source)
	; ld		de, ColorsTable_1st_Third				; VRAM address (destiny)
	; ld		bc, TitleColors_1.size					; Block length
    ; call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory
	; ld		hl, TitleColors_1        				    ; RAM address (source)
	; ld		de, ColorsTable_2nd_Third				; VRAM address (destiny)
	; ld		bc, TitleColors_1.size					; Block length
    ; call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory


    ; Load Names Table to buffer
    ld      hl, TitleNamesTable                                 ; source
    ld      de, NamesTableBuffer                                ; destiny
    ld      bc, TitleNamesTable.size                            ; size
    ldir                                                        ; Copy BC bytes from HL to DE

    ; Initial Load Names Table (768 bytes)
	ld		hl, NamesTableBuffer        	        ; RAM address (source)
	ld		de, NamesTable				            ; VRAM address (destiny)
	ld		bc, TitleNamesTable.size				; Block length
    call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

	call 	BIOS_ENASCR 


.initTitle_1:
    ; revert left to right direction
    ld      a, (TitleScreen_Direction)
    cp      -1
    jp      z, .initTitle_LeftToRight

.initTitle_RightToLeft:

    ; Set tile colors
    ld      hl, TitleColors_1
    ld      (TitleScreen_ColorsAddr), hl
    call    LoadColors

    ; Load Names Table to buffer
    ld      hl, TitleNamesTable                                 ; source
    ld      de, NamesTableBuffer                                ; destiny
    ld      bc, 512; TitleNamesTable.size                            ; size
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

    ; Set tile colors
    ld      hl, TitleColors_1
    ld      (TitleScreen_ColorsAddr), hl
    call    LoadColors

    ; Load Names Table to buffer (inverted)
    ld      hl, TitleNamesTable                                 ; source
    ld      de, NamesTableBuffer                                ; destiny
    ld      bc, 512 ; TitleNamesTable.size                            ; size
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


    ; read keyboard
    ld      a, 8                    ; 8th line
    call    SNSMAT_NO_DI_EI         ; Read Data Of Specified Line From Keyboard Matrix
    bit     0, a                    ; 0th bit (space bar)
    jp      z, EndTitleScreen



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

LoadColors:
	; Repeat 8-bit color patterns 12x
    ld      b, 12
    ld		de, ColorsTable_1st_Third				        ; VRAM address (destiny)
    call    LoadColors_OneThird
; .loop_1st:
;     push    bc
;         push    de
;             ld      hl, (TitleScreen_ColorsAddr)
;             ld		bc, 8 ; TitleColors_1.size			    ; Block length
;             call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory
;         pop     de

;         ex      de, hl
;         ld      bc, 8
;         add     hl, bc
;         ex      de, hl

;     pop     bc
;     djnz    .loop_1st



	; Repeat 8-bit color patterns 12x
    ld      b, 12
    ld		de, ColorsTable_2nd_Third				        ; VRAM address (destiny)
    call    LoadColors_OneThird

	; Repeat 8-bit color patterns 12x
    ld      b, 12
    ld		de, ColorsTable_3rd_Third				        ; VRAM address (destiny)
    call    LoadColors_OneThird

	; ;ld		hl, TitleColors_1        				; RAM address (source)
    ; ld      hl, (TitleScreen_ColorsAddr)
	; ld		de, ColorsTable_2nd_Third				; VRAM address (destiny)
	; ld		bc, TitleColors_1.size					; Block length
    ; call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ret


; Inputs:
;   DE: destiny addr on VRAM
;   B: number of 8-bit patterns
LoadColors_OneThird:
    push    bc
        push    de
            ld      hl, (TitleScreen_ColorsAddr)
            ld		bc, 8 ; TitleColors_1.size			    ; Block length
            call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory
        pop     de

        ex      de, hl
        ld      bc, 8
        add     hl, bc
        ex      de, hl

    pop     bc
    djnz    LoadColors_OneThird
    ret


EndTitleScreen:

    ld      b, 24           ; number of frames
.loop:
    push    bc


        ld      b, 16           ; number of columns of screen
    .loopColumns:
        push    bc

            ld      hl, NamesTableBuffer + (32 * 23)
            ld      c, b
            ld      b, 0
            sla     c               ; multiply C x 2
            dec     bc              ; column number is between 0 and 31
            add     hl, bc
            ld      b, 24           ; number of lines of screen
        .loopLines:
            
            ld      a, (hl)         ; read current line

            ld      d, a

            ld      a, 255
            ld      (hl), a         ; clear current line

            ld      a, d

            ld      de, 32
            add     hl, de
            ld      (hl), a         ; write to line above

            or      a
            ld      de, 64
            sbc     hl, de          ; go back 2 lines

            djnz    .loopLines
        
        pop     bc
        djnz    .loopColumns


    ;     ld      hl, BIOS_JIFFY              ; (v-blank sync)
    ;     ld      a, (hl)
    ; .waitVBlank:
    ;     cp      (hl)
    ;     jr      z, .waitVBlank

        ; Load Names Table from buffer to VRAM
        ld		hl, NamesTableBuffer        			; RAM address (source)
        ld		de, NamesTable				            ; VRAM address (destiny)
        ld		bc, NamesTableBuffer.size				; Block length
        call 	BIOS_LDIRVM        						; Block transfer to VRAM from memory

    pop     bc
    djnz    .loop



    call    WaitSomeSeconds

    ret
