; commonroutines.s (can be used on other programs)

; depends on:
;   include/msxbios.s
;   include/vram.s



; ---------------------------------------------------------
; Self explanatory
Delay:
    push    bc
    push    de
    ; ld    c, 0x04                  ; 3 nested loops
    ld      d, 0x06                  
    ld      e, 0xff
.loop:                          ; 
    dec     e
    jp      nz, .loop                ; inner loop
    dec     d
    jp      nz, .loop                ; 
    ; dec   c
    ; jp    nz, .loop                ; outer loop
    
    pop     de
    pop     bc
    ret


; ---------------------------------------------------------
; Self explanatory
DelayWithParameters:
    ; ld c, 0x01                  ; inputs
    ; ld d, 0xff                  
    ; ld e, 0x80              
.loop:                          ; 
    dec e
    jp nz, .loop                ; inner loop
    dec d
    jp nz, .loop                ; 
    dec c
    jp nz, .loop                ; outer loop
    
    ret


; ---------------------------------------------------------
; Scrolling by rotating the tile pattern downwards
; 
; Inputs:
;   none
; Destroys:
;   hl, a, b, c, e
; RotateTile3Thirds:
;     ld      bc, PatternsTable                            ; first third
;     call    RotateTile

;     ld      bc, PatternsTable + (256 * 8)                ; second third
;     call    RotateTile

;     ld      bc, PatternsTable + (256 * 8) + (256 * 8)    ; last third
;     call    RotateTile

;     ret



; ---------------------------------------------------------
; Scrolling by rotating the pattern tile downwards
; Rotates only one tile pattern, so affects only one third of screen 2
; 
; Inputs:
;   bc: Patterns table address
; Destroys:
;   hl, a, b, e
RotateTile:
; 170 B = VPEEK(C+7)
; 180 FOR I=7 TO 1 STEP -1
; 190   VPOKE C+I, VPEEK(C+I-1)
; 200 NEXT
; 203 VPOKE C, B
; 205 GOTO 170

; B = VPEEK(C+7)
    push bc                     ; Saves entry address
    
    ld hl, 7                    ; Add 7 to patterns table address; HL = BC + 7
    add hl, bc
	;ld	hl, PatternsTable + 7   ; VRAM Address
	call BIOS_RDVRM		        ; Reads data from VRAM, as VPEEK (HL: address, output in A)
    ld e, a                     ; save pattern of the 8th (last) line

; FOR I=7 TO 1 STEP -1
    ld b, 7                     ; repeat 7 times

.loop:
; VPEEK(C+I-1)
	dec hl                      ; VRAM Address
	call BIOS_RDVRM		        ; Reads data from VRAM, as VPEEK (HL: address, output in A)

;VPOKE C+I, ...
    inc hl
	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)

    dec hl

    djnz .loop

;VPOKE C, B
    pop hl                      ; Retrieve entry address directly to hl
	; ld	h, b                    ; VRAM Address; ld hl, bc
	; ld	l, c
    ld a, e                     ; pattern of the last line will go to the first
	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)

    ret



; HL: address (should have the bit 6 set), A: value
Vpoke:
    push af

    ld a, l
    out (0x99), a
    ; set 6, h                    ; Set write flag
    ld a, h
    out (0x99), a
    
    pop af
    out (0x98), a

    ; res 6, h                    ; Reset write flag

    ret



; ---------------------------------------------------------
; Fills a range of cells in color table with a color pattern in RAM
; 
; Destroys:
;   All registers
;
; Inputs:
;   DE: VRAM color table start address
;   HL: RAM start address of tile pattern (8 bytes)
;   A: number of cells in color table to be filled by the pattern 
; Output:
;   
FillColorTable:
	; ld	de, ColorsTable+(Tile_Char_0_Number*8)     ; VRAM Address
	; ld	hl, Colors_Char        ; RAM Address
	; ld a, 10				; loop control variable
.loop:
	ld	    bc, 8               ; Block length
	push    hl
    push    af
	push    de
	call    BIOS_LDIRVM        ; Block transfer to VRAM from memory
	pop     de
	pop     af
	
	ld	    bc, 8               ; increment register pair de by 8
	ld      h, d					; 
	ld      l, e					;
	add     hl, bc
	ld      d, h
	ld      e, l
	
	pop     hl
	
	dec     a
	jr      nz, .loop
	
	ret

FillColorTable_3thirds:
    ; Top third of screen
    push    hl
        push    de
            push    af
                call    FillColorTable
            pop     af
        pop     hl              ; from de to hl
        ld      bc, 256 * 8     ; go to next color table
        add     hl, bc
        ld      d, h
        ld      e, l
    pop     hl

    ; Middle third of screen
    push    hl
        push    de
            push    af
                call    FillColorTable
            pop     af
        pop     hl              ; from de to hl
        ld      bc, 256 * 8     ; go to next color table
        add     hl, bc
        ld      d, h
        ld      e, l
    pop     hl
    
    ; Bottom third of screen
    call    FillColorTable
    
    ret

WaitSomeSeconds:
    ; Wait some seconds
    ld hl, 3000
    ld b, 255
.wait:
    djnz .wait

    dec hl
    ld a, h
    or l                                                ; h OR l, to check zero

    ld b, 255
    jp nz, .wait

    ret


; Fill all VRAM with 0x00
ClearVRAM:
	ld	    hl, 0x0000 			; VRAM start address
    ld      bc, 16768           ; number of bytes
    ld      a, 0x00             ; value
    call    BIOS_FILVRM         ; Fill VRAM
    
    ret


; Fill all RAM with 0x00
ClearRam:
    ld      hl, RamStart        ; RAM start address
    ld      de, RamEnd + 1      ; RAM end address

.loop:
    xor     a                   ; same as ld a, 0, but faster
    ld      (hl), a

    inc     hl
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    ret     z
    jp      .loop




; Typical routine to select the ROM on page 8000h-BFFFh from page 4000h-7FFFh
EnableRomPage2:
; source: https://www.msx.org/wiki/Develop_a_program_in_cartridge_ROM#Typical_examples_to_make_a_32kB_ROM

	call	BIOS_RSLREG
	rrca
	rrca
	and	    3	;Keep bits corresponding to the page 4000h-7FFFh
	ld	    c,a
	ld	    b,0
	ld	    hl, BIOS_EXPTBL
	add	    hl,bc
	ld	    a,(hl)
	and	    80h
	or	    c
	ld	    c,a
	inc	    hl
	inc	    hl
	inc	    hl
	inc	    hl
	ld	    a,(hl)
	and	    0Ch
	or	    c
	ld	    h,080h
	call	BIOS_ENASLT		; Select the ROM on page 8000h-BFFFh

    ret



;Random number generator:
; In: nothing
; Out: A with a random number
; Destroys: nothing
;Author: Ricardo Bittencourt aka RicBit (BrMSX, Tetrinet and several other projects)
; choose a random number in the set [0,255] with uniform distribution
RandomNumber:
    push    hl
        ld      hl, (Seed)
        add     hl, hl
        sbc     a, a
        and     0x83
        xor     l
        ld      l, a
        ld      (Seed), hl
    pop     hl
    ret

    ; The random number generated will be any number from 0 to FFh.
    ; Despite be a random number generator routine, your results will pass in several statistical tests.
    ; Before the first call, the SEED value must be initiated with a value different of 0.
    ; For a deterministic behavior (the sequence of values will be the same if the program was initiated), use a fixed SEED value.
    ; For a somewhat more random sequence, use:
    ; LD A,(JIFFY);MSX BIOS time variable
    ; OR 80H ;A value different of zero is granted
    ; LD A,(SEED)

    ; The values obtained from this method is much more *random* that what you get from LD A,R.

; ---------------------

; FC9Eh	JIFFY	1	Contains value of the software clock, each interrupt of the VDP it is increased by 1.
; The contents can be read or changed by the function 'TIME' or instruction 'TIME'.

; -----------------------


;-----------------------------------------------
; hl: source data
; de: target address in the VDP
; bc: amount to copy
fast_LDIRVM:
    ex de,hl    ; this is wasteful, but it's to maintain the order of parameters of the original LDIRVM...
                ; For things that require real speed, this function should not be used anyway, and you should use specialized loops
    push de
    push bc
    call BIOS_SETWRT
    pop bc
    pop hl
copy_to_VDP:
    ld e,b
    ld a,c
    or a
    jr z, copy_to_VDP_lsb_0
    inc e
copy_to_VDP_lsb_0:
    ld b,c
    ; get the VDP write register:
    ld a, (BIOS_VDP_DW)
    ld c,a
    ld a,e
copy_to_VDP_loop2:
copy_to_VDP_loop:
    outi
    jp nz,copy_to_VDP_loop
    dec a
    jp nz,copy_to_VDP_loop2
    ret


; ; LDIRVM the NAMTBL buffer
; ;UpdateNamesTable:
; FAST_LDIRVM_NamesTable:
; ; Sets the VRAM pointer
; 	ld	    hl, (CurrentNamesTable)
; 	call    BIOS_SETWRT
; ; Initializes the OUTI loop
; 	ld	    hl, NamesTableBuffer
; 	ld	    a, (BIOS_VDP_DW)
; 	ld	    c, a
; ; Uses 3x256 = 768 OUTIs to blit the NAMTBL buffer

; ; OUTIs inside loop (use anytime)
; 	;ld	    b, 0 ; (ensures 256 bytes for the first bank)
; ; .loop_0:
; ; 	outi
; ; 	jp	    nz, .loop_0
; ; .loop_1:
; ; 	outi
; ; 	jp	    nz, .loop_1
; ; .loop_2:
; ; 	outi
; ; 	jp	    nz, .loop_2

; ; Unrolled OUTIs (use only during v-blank)
;     OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI 
; 	ret



; LDIRVM the SpriteAttrTable buffer
FAST_LDIRVM_SpriteAttrTable:
; Sets the VRAM pointer
	ld	    hl, SpriteAttrTable
	call	BIOS_SETWRT
; Initializes the OUTI loop
	ld	    hl, SpriteAttrTableBuffer
	ld	    a, (BIOS_VDP_DW)
	;ld	    b, 128	        ; size of SpriteAttrTable (4 x 32)
	ld	    c, a

; Uses 128 OUTIs to blit the SpriteAttrTable buffer

; OUTIs inside loop (use anytime)
; .loop_0:
; 	outi
; 	jp	    nz, .loop_0

; Unrolled OUTIs (use only during v-blank)
    OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI OUTI
    ret


; How to know if is 50 or 60 Hz

; https://www.msx.org/pt-br/node/50159?page=2

; So the best way to know the current refresh frequency is:

; 1. Check the MSX version number at 002DH of the BIOS
; 2. If it’s 0, read the frequency from bit 7 of 002BH of the BIOS (0 = 60 Hz)
; 3. Otherwise, read the frequency from bit 1 of 0FFE8H of the system area (0 = 60 Hz)



; hide all sprites (208 on Y value hides the sprite and all following)
HideAllSprites:
    ld      hl, SpriteAttrTable
    ld      a, 208
    call    BIOS_WRTVRM		                            ; Writes data in VRAM (HL: address, A: value)

    ret


; From MSX Lib
; -----------------------------------------------------------------------------
; Alternative implementation of BIOS' SNSMAT without DI and EI
; param a/c: the keyboard matrix row to be read
; ret a: the keyboard matrix row read
SNSMAT_NO_DI_EI:
	ld	    c, a
.C_OK:
; Initializes PPI.C value
	in	    a, (PPI.C)
	and	    $f0 ; (keep bits 4-7)
	or	    c
; Reads the keyboard matrix row
	out	    (PPI.C), a
	in	    a, (PPI.B)
	ret
