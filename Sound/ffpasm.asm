        ;Tests the AKG player, for MSX.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!
        

        ;Include here the Player Configuration source of the songs (you can generate them with AT2 while exporting the songs).
        ;If you don't have any, the player will use a default Configuration (full code used), which may not be optimal.
        ;If you have several songs, include all their configuration here, their flags will stack up!
        ;Warning, this must be included BEFORE the player is compiled.

	include "MusicExample.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL1_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL2_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL3_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL4_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL5_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\GAMEOVERplayerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\SFX_playerconfig.asm"


	include "MusicExample_playerconfig.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL1.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL2.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL3.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL4.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL5.asm"
	; include "C:\Emulatori\Tools\phaze101\GAMEOVER.asm"
        ; include "C:\Emulatori\Tools\phaze101\SFX.asm"
        ; include "C:\Emulatori\Tools\phaze101\EMPTY.asm"
        ; include "C:\Emulatori\Tools\phaze101\Intro.asm"
        ; include "C:\Emulatori\Tools\phaze101\Prologue.asm"
        ; include "C:\Emulatori\Tools\phaze101\Epilogue.asm"
 
        ;Selects the hardware. Mandatory, as CPC is default.
        PLY_AKG_HARDWARE_MSX = 1
        
        ;Want a ROM player (a player without automodification)?
        PLY_AKG_Rom = 1                         ;Must be set BEFORE the player is included.
        
        ;Declares the buffer for the ROM player, if you're using it. You can declare it anywhere of course.
        ;LIMITATION: the SIZE of the buffer (PLY_AKG_ROM_BufferSize) is only known *after* ther player is compiled.
        ;A bit annoying, but you can compile once, get the buffer size, and hardcode it to put the buffer wherever you want.
        ;Note that the size of the buffer shrinks when using the Player Configuration feature. Use the largest size and you'll be safe.
        IFDEF PLY_AKG_Rom
                PLY_AKG_ROM_Buffer = #e600                  ;Can be set anywhere.
        ENDIF

	PLY_AKG_MANAGE_SOUND_EFFECTS = 1

        include "PlayerAkg.asm"


