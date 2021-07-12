; code from MSX lib

; =============================================================================
; 	Interrupt routine (H.TIMI hook) 
; =============================================================================

	CFG_RAM_HOOK:	equ 1

; -----------------------------------------------------------------------------
; H.TIMI hook
; 1. Invokes the replayer
; 2. Reads the inputs
; 3. Tricks BIOS' KEYINT to skip keyboard scan, TRGFLG, OLDKEY/NEWKEY, ON STRIG...
; 4. Invokes the previously existing hook
HOOK:

	push	af ; Preserves VDP status register S#0 (a)
		; push	bc
		; 	push	de
		; 		push	hl
					; ----------------------------------------------------------------

					; IFDEF DEBUG
					; 	ld 		a, COLOR_GREY       	; Border color
					; 	ld 		(BIOS_BDRCLR), a    
					; 	call 	BIOS_CHGCLR        		; Change Screen Color
					; ENDIF

					; call    AkgPlayer_PlayMusic
					; ;call    AkyPlayer_PlayMusic

					; ; ----------------------------------------------------------------

					; call    ReadInput

					; Reads the inputs
					; call	READ_KEYBOARD
					; call	READ_INPUT

					; Tricks BIOS' KEYINT to skip keyboard scan, TRGFLG, OLDKEY/NEWKEY, ON STRIG...
					xor		a
					ld		(BIOS_SCNCNT), a
					ld		(BIOS_INTCNT), a

		; 		pop		hl
		; 	pop		de
		; pop		bc
	pop		af ; Restores VDP status register S#0 (a)


	ret


; IFDEF CFG_INIT_USE_HIMEM_KEEP_HOOKS
; ; Invokes the previously existing hook
; 	jp	old_htimi_hook
; ELSE
;  	ret
; ENDIF ; IFDEF CFG_INIT_USE_HIMEM_KEEP_HOOKS
; -----------------------------------------------------------------------------
