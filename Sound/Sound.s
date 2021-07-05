
{
 10 SOUND 8,15:SOUND 0,93:SOUND 1,0:FOR F=0 TO 20:NEXT F
 20 SOUND 0,45:SOUND 1,0:FOR F=0 TO 29:NEXT F: SOUND 8,0

' mude o valor do registro 0 na linha 10 para alterar o timbre
}
SoundGetItem:
    call BIOS_GICINI

; Register 7 must always contain 10xxxxxx or possible damage could result to the PSG
    ld a, 8					; Channel A Volume (0-15)
    ld e, 15
    call BIOS_WRTPSG		



    ; for 0 to 20
    ld b, 255
.loop1:
    ld a, 0					; Channel A Period (low 8 bits)
    ld e, 93
    call BIOS_WRTPSG

    ld a, 1					; Channel A Period (high 4 bits)
    ld e, 0
    call BIOS_WRTPSG
    
    djnz .loop1


    ld b, 255
.loop2:
    ld a, 0					; Channel A Period (low 8 bits)
    ld e, 45
    call BIOS_WRTPSG

    ld a, 1					; Channel A Period (high 4 bits)
    ld e, 0
    call BIOS_WRTPSG

	djnz .loop2

    ld a, 8					; Channel A Volume (0-15)
    ld e, 0
    call BIOS_WRTPSG

    ret




MUSIC_MEGAROM_PAGE:     equ 7

AkgPlayer_InitPlayer:

    ; Switch to MegaROM page where the sound routine is located
    ld      a, MUSIC_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a

    ld      hl, JUSTADDCREAM_START                      ;The address of the music.
    ld      a, 0                                        ;What subsong to play (starts at 0)?
    call    PLY_AKG_Init                                ;Call the init method of the player. 

    ret


AkgPlayer_PlayMusic:

    ; Switch to MegaROM page where the sound routine is located
    ld      a, MUSIC_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a

    call    PLY_AKG_Play
    ret


AkgPlayer_StopMusic:

    ; Switch to MegaROM page where the sound routine is located
    ld      a, MUSIC_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a

    call    PLY_AKG_Stop
    ret