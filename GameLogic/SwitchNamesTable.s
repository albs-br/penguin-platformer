SwitchNamesTable:
    ; Switch names table
    ld      hl, (CurrentNamesTable)
    ld      a, h
    cp      0x18                        ; Names Table 1 High byte
    jp      z, .setNameTable_2
; Set names table 1
    ; Writing to Names Table 1 while showing Names Table 2
    ld      hl, NamesTable
	ld	    b, 7	               		; Data To Write to VDP register
    jp      .continue
.setNameTable_2:
    ; Writing to Names Table 2 while showing Names Table 1
    ld      hl, NamesTable_2
	ld	    b, 6	               		; Data To Write to VDP register
.continue:
    ld      (CurrentNamesTable), hl
	ld	    c, 2	               		; VDP Register Number (0..27, 32..46)
    call    BIOS_WRTVDP        		    ; 
    
    ret