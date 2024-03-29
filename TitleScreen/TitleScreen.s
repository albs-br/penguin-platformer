ShowTitleScreen:

    call    BasicInitScreen2

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

    
    xor     a
    ld      (TitleScreen_Counter), a


.initTitle_1:
    ; revert left to right direction
    ld      a, (TitleScreen_Direction)
    cp      -1
    jp      z, .initTitle_LeftToRight

.initTitle_RightToLeft:

    call    .updateColors

    ; Set tile colors
    ; ld      hl, TitleColors_1
    ; ld      (TitleScreen_ColorsAddr), hl
    call    LoadTitleColors

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

    call    .updateColors

    ; Set tile colors
    ; ld      hl, TitleColors_1
    ; ld      (TitleScreen_ColorsAddr), hl
    call    LoadTitleColors

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



.updateColors:
    ld      a, (TitleScreen_Counter)
    inc     a
    ld      (TitleScreen_Counter), a

    and     0000 1100 b ; mask to change colors only at each n frames

    cp      0
    call    z, .setTitleColors_1
    cp      4
    call    z, .setTitleColors_2
    cp      8
    call    z, .setTitleColors_3
    cp      12
    call    z, .setTitleColors_4

    ld      (TitleScreen_ColorsAddr), hl

    ret
.setTitleColors_1:
    ld      hl, TitleColors_1
    ret
.setTitleColors_2:
    ld      hl, TitleColors_2
    ret
.setTitleColors_3:
    ld      hl, TitleColors_3
    ret
.setTitleColors_4:
    ld      hl, TitleColors_4
    ret



LoadTitleColors:
	; Repeat 8-bit color patterns 12x
    ld      b, 12
    ld		de, ColorsTable_1st_Third				        ; VRAM address (destiny)
    call    LoadColors_OneThird



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

    ld      ixh, 0
    call    ColumnsDown
    ld      ixh, 1
    call    ColumnsDown

    ret



; Input:
;   IXH: 0: even columns; 1: odd columns
ColumnsDown:
    ld      b, 24           ; number of frames
.loop:
    push    bc


        ld      b, 16           ; number of columns of screen
    .loopColumns:
        push    bc

            ld      hl, NamesTableBuffer + (32 * 23)
            ld      c, b
            ld      b, 0
            sla     c               ; multiply C x 2            (32-2, only even)
            dec     bc              ; column number:            (31-1, only odd)
            
            ; if (IXH == 0) Even else Odd
            ld      a, ixh
            or      a
            jp      nz, .odd
            dec     bc              ; column number:            (30-0, only even)
        .odd:

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

    ; call    WaitSomeSeconds

    ret
