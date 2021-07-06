        ;Tests the AKY player, for MSX.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!
        
        ;A binary file (to load with the BLOAD MSX command) is generated.
        ;It can then be included inside a DSK file (using the DiskMgr software for example). Tested with the BlueMSX emulator.

	include "MusicExample_AKY.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL1_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL2_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL3_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL4_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\FFL5_playerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\GAMEOVERplayerconfig.asm.asm"
	; include "C:\Emulatori\Tools\phaze101\SFX_playerconfig.asm"


	include "MusicExample_AKY_playerconfig.asm"
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
 
        ;Selects the hardware. Mandatory, as Amstrad CPC is default.
        PLY_AKY_HARDWARE_MSX = 1
        
        ;Want a ROM player (a player without automodification)?
        PLY_AKY_Rom = 1                         ;Must be set BEFORE the player is included.
        
        include "PlayerAky.asm"

        ;Declares the buffer for the ROM player, if you're using it. You can declare it anywhere of course.
        IFDEF PLY_AKY_Rom
                PLY_AKY_ROM_Buffer = #e600              ;Can be set anywhere.
                ds PLY_AKY_ROM_BufferSize, 0            ;Reserves the buffer for the ROM player (not mandatory, but cleaner).
        ENDIF

        ;Includes here the Player Configuration source of the songs (you can generate them with AT2 while exporting the songs).
        ;If you don't have any, the player will use a default Configuration (full code used), which may not be optimal.
        ;If you have several songs, include all their configuration here, their flags will stack up!
        ;Warning, this must be included BEFORE the player is compiled.
        ;include "Mysong1_playerconfig.asm"
        ;include "Mysong2_playerconfig.asm"



