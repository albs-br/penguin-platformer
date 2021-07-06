;       AKY music player - V1.0.
;       By Julien Névo a.k.a. Targhan/Arkos.
;       CPC PSG sending optimization trick by Madram/Overlanders.
;       December 2016.
;
;       This compiles with RASM. Please check the compatibility page on Arkos Tracker 2 website, there is a Source Converter (Disark) for ANY assembler!
;
;       The player uses the stack for optimizations. Make sure the interruptions are disabled before it is called.
;       The stack pointer is saved at the beginning and restored at the end.
;
;       Multi-PSG
;       ----------------------
;       This player only target 1 PSG, as it allows some nice optimizations.
;       For Multi-PSG hardware, such as PlayCity (CPC), TurboSound (Spectrum) or SpecNext, please check the PlayerAkyMultiPsg.asm!
;
;       Hardware target
;       ----------------------
;       This code can target Amstrad CPC, MSX, Spectrum and Pentagon. By default, it targets Amstrad CPC.
;       Simply use one of the follow line (BEFORE this player):
;       PLY_AKY_HARDWARE_CPC = 1
;       PLY_AKY_HARDWARE_MSX = 1
;       PLY_AKY_HARDWARE_SPECTRUM = 1
;       PLY_AKY_HARDWARE_PENTAGON = 1
;       Note that the PRESENCE of this variable is tested, NOT its value.
;
;       Sound effects
;       ----------------------
;       This player does not support sound effects. For this, use the AKY Multi-Psg (in the same folder).
;
;       ROM
;       ----------------------
;       To use a ROM player (no automodification, use of a small buffer to put in RAM):
;       PLY_AKY_ROM = 1
;       PLY_AKY_ROM_Buffer = #4000 (or wherever). The buffer is 29 bytes long (PLY_AKY_ROM_BufferSize).
;       This makes the player a bit slower and very slightly bigger.
;
;       Optimizations
;       ----------------------
;       - Use the Player Configuration of Arkos Tracker 2 to generate a configuration file to be included at the beginning of this player.
;         It will disable useless features according to your songs! Check the manual for more details, or more simply the testers.
;       - SIZE: The JP hooks at the beginning can be removed if you include this code in yours directly (see the PLY_AKY_UseHooks flag below).
;       - SIZE: If you don't play a song twice, all the code in PLY_AKY_Init can be removed, except the first lines that skip the header.
;       - SIZE: The header is only needed for players that want to load any song. Most of the time, you don't need it. Erase both the init code and the header bytes in the song.
;       - CPU:  We *could* save 3 NOPS by removing the first "jp PLY_AKY_ReadRegisterBlock" and stucking the whole code instead. But it would make the whole really ugly.
;
;       -------------------------------------------------------

PLY_AKY_Start:

        ;A nice trick to manage the offset using the same instructions, according to the player (ROM or not).
        IFDEF PLY_AKY_ROM
PLY_AKY_Offset1b: equ 0
        ELSE
PLY_AKY_Offset1b: equ 1
        ENDIF

        IFNDEF PLY_AKY_ROM
PLY_AKY_OPCODE_OR_A: equ #b7                        ;Opcode for "or a".
PLY_AKY_OPCODE_SCF: equ #37                         ;Opcode for "scf".
        ELSE
        ;Another trick for the ROM player. The original opcodes are converted to number, which will be multiplied by 2, provoking a carry or not.
PLY_AKY_OPCODE_OR_A: equ 0                          ;0 * 2 = 0, no carry.
PLY_AKY_OPCODE_SCF: equ #ff                         ;255 * 2 = carry.
        ENDIF

        ;Only 3 channels for this player.        
        PLY_AKY_ChannelCount = 3
        
        ;Checks the hardware. Only one must be selected.
PLY_AKY_HardwareCounter = 0
        IFDEF PLY_AKY_HARDWARE_CPC
                PLY_AKY_HardwareCounter = PLY_AKY_HardwareCounter + 1
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                PLY_AKY_HardwareCounter = PLY_AKY_HardwareCounter + 1
                PLY_AKY_HARDWARE_SPECTRUM_OR_MSX = 1
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM
                PLY_AKY_HardwareCounter = PLY_AKY_HardwareCounter + 1
                PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON = 1
                PLY_AKY_HARDWARE_SPECTRUM_OR_MSX = 1
        ENDIF
        IFDEF PLY_AKY_HARDWARE_PENTAGON
                PLY_AKY_HardwareCounter = PLY_AKY_HardwareCounter + 1
                PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON = 1
        ENDIF
        IF PLY_AKY_HARDWARECounter > 1
                FAIL 'Only one hardware must be selected!'
        ENDIF
        ;By default, selects the Amstrad CPC.
        IF PLY_AKY_HARDWARECounter == 0
                PLY_AKY_HARDWARE_CPC = 1
        ENDIF


PLY_AKY_UseHooks: equ 1                             ;Use hooks for external calls? 0 if the Init/Play methods are directly called, will save a few bytes.

        ;Is there a loaded Player Configuration source? If no, use a default configuration.
        IFNDEF PLY_CFG_ConfigurationIsPresent
                PLY_CFG_UseHardwareSounds = 1
                PLY_CFG_UseRetrig = 1
                PLY_CFG_NoSoftNoHard = 1
                PLY_CFG_NoSoftNoHard_Noise = 1
                PLY_CFG_SoftOnly = 1
                PLY_CFG_SoftOnly_Noise = 1
                PLY_CFG_SoftToHard = 1
                PLY_CFG_SoftToHard_Noise = 1
                PLY_CFG_SoftToHard_Retrig = 1
                PLY_CFG_HardOnly = 1
                PLY_CFG_HardOnly_Noise = 1
                PLY_CFG_HardOnly_Retrig = 1
                PLY_CFG_SoftAndHard = 1
                PLY_CFG_SoftAndHard_Noise = 1
                PLY_CFG_SoftAndHard_Retrig = 1
        ENDIF
        
        
        ;Agglomerates the hardware sound configuration flags, because they are treated the same in this player.
        ;-------------------------------------------------------
        IFDEF PLY_CFG_SoftToHard
                PLY_AKY_USE_SoftAndHard_Agglomerated = 1
        ENDIF
        IFDEF PLY_CFG_SoftAndHard
                PLY_AKY_USE_SoftAndHard_Agglomerated = 1
        ENDIF
        IFDEF PLY_CFG_HardToSoft
                PLY_AKY_USE_SoftAndHard_Agglomerated = 1
        ENDIF
        
        IFDEF PLY_CFG_SoftToHard_Noise
                PLY_AKY_USE_SoftAndHard_Noise_Agglomerated = 1
        ENDIF
        IFDEF PLY_CFG_SoftAndHard_Noise
                PLY_AKY_USE_SoftAndHard_Noise_Agglomerated = 1
        ENDIF
        IFDEF PLY_CFG_HardToSoft_Noise
                PLY_AKY_USE_SoftAndHard_Noise_Agglomerated = 1
        ENDIF
        
        ;Any noise?
        IFDEF PLY_AKY_USE_SoftAndHard_Noise_Agglomerated
                PLY_AKY_USE_Noise = 1
        ENDIF
        IFDEF PLY_CFG_NoSoftNoHard_Noise
                PLY_AKY_USE_Noise = 1
        ENDIF
        IFDEF PLY_CFG_SoftOnly_Noise
                PLY_AKY_USE_Noise = 1
        ENDIF
        
        ;Disark macro: Word region Start.
        disarkCounter = 0
        IFNDEF dkws
        MACRO dkws
PLY_AKY_DisarkWordRegionStart_{disarkCounter}
        ENDM
        ENDIF
        ;Disark macro: Word region End.
        IFNDEF dkwe
        MACRO dkwe
PLY_AKY_DisarkWordRegionEnd_{disarkCounter}:
        disarkCounter = disarkCounter + 1
        ENDM
        ENDIF
        
        ;Disark macro: Pointer region Start.
        disarkCounter = 0
        IFNDEF dkps
        MACRO dkps
PLY_AKY_DisarkPointerRegionStart_{disarkCounter}
        ENDM
        ENDIF
        ;Disark macro: Pointer region End.
        IFNDEF dkpe
        MACRO dkpe
PLY_AKY_DisarkPointerRegionEnd_{disarkCounter}:
        disarkCounter = disarkCounter + 1
        ENDM
        ENDIF
        
        ;Disark macro: Byte region Start.
        disarkCounter = 0
        IFNDEF dkbs
        MACRO dkbs
PLY_AKY_DisarkByteRegionStart_{disarkCounter}
        ENDM
        ENDIF
        ;Disark macro: Byte region End.
        IFNDEF dkbe
        MACRO dkbe
PLY_AKY_DisarkByteRegionEnd_{disarkCounter}:
        disarkCounter = disarkCounter + 1
        ENDM
        ENDIF

        ;Disark macro: Force "No Reference Area" for 3 bytes (ld hl,xxxx).
        IFNDEF dknr3
        MACRO dknr3
PLY_AKY_DisarkForceNonReferenceDuring3_{disarkCounter}:
        disarkCounter = disarkCounter + 1
        ENDM
        ENDIF
        
        ;-------------------------------------------------------

        ;Hooks for external calls. Can be removed if not needed.
        if PLY_AKY_UseHooks
                assert PLY_AKY_Start == $               ;Makes sure no byte has been added before the hooks.
                jp PLY_AKY_Init             ;Player + 0.
                jp PLY_AKY_Play             ;Player + 3.
        endif

;       Initializes the player.
;       HL = music address.
PLY_AKY_InitDisarkGenerateExternalLabel:
PLY_AKY_Init:
        ;Skips the header.
        inc hl                          ;Skips the format version.
        ld a,(hl)                       ;Channel count.
        inc hl
dknr3 (void):  ld de,4
PLY_AKY_Init_SkipHeaderLoop:                ;There is always at least one PSG to skip.
        add hl,de
        sub 3                           ;A PSG is three channels.
        jr z,PLY_AKY_Init_SkipHeaderEnd
        jr nc,PLY_AKY_Init_SkipHeaderLoop   ;Security in case of the PSG channel is not a multiple of 3.
PLY_AKY_Init_SkipHeaderEnd:
        ld (PLY_AKY_PtLinker + PLY_AKY_Offset1b),hl        ;HL now points on the Linker.

        ld a,PLY_AKY_OPCODE_OR_A
        REPEAT PLY_AKY_ChannelCount, ChannelNumber
                ld (PLY_AKY_Channel{ChannelNumber}_RegisterBlockLineState_Opcode),a
        REND
dknr3 (void):  ld hl,1
        ld (PLY_AKY_PatternFrameCounter + PLY_AKY_Offset1b),hl

        ret

;       Plays the music. It must have been initialized before.
;       The interruption SHOULD be disabled (DI), as the stack is heavily used.
PLY_AKY_PlayDisarkGenerateExternalLabel:
PLY_AKY_Play:
        IFNDEF PLY_AKY_ROM
        ld (PLY_AKY_Exit + 1),sp
        ELSE
        ld (PLY_AKY_SaveSp),sp
        ENDIF


;Linker.
;----------------------------------------
        IFNDEF PLY_AKY_ROM
dknr3 (void):
PLY_AKY_PatternFrameCounter: ld hl,1                ;How many frames left before reading the next Pattern.
        ELSE
        ld hl,(PLY_AKY_PatternFrameCounter)
        ENDIF
        dec hl
        ld a,l
        or h
        jr z,PLY_AKY_PatternFrameCounter_Over
        ld (PLY_AKY_PatternFrameCounter + PLY_AKY_Offset1b),hl
        ;The pattern is not over.
        IFNDEF PLY_AKY_ROM
        jr PLY_AKY_Channel1_WaitBeforeNextRegisterBlock
        ELSE
        jr PLY_AKY_Channel1_WaitBeforeNextRegisterBlock_Start
        ENDIF

PLY_AKY_PatternFrameCounter_Over:

;The pattern is over. Reads the next one.
        IFNDEF PLY_AKY_ROM
dknr3 (void):
PLY_AKY_PtLinker: ld sp,0                                   ;Points on the Pattern of the linker.
        ELSE
        ld sp,(PLY_AKY_PtLinker)                            ;Points on the Pattern of the linker.
        ENDIF
        pop hl                                          ;Gets the duration of the Pattern, or 0 if end of the song.
        ld a,l
        or h
        jr nz,PLY_AKY_LinkerNotEndSong
        ;End of the song. Where to loop?
        pop hl
        ;We directly point on the frame counter of the pattern to loop to.
        ld sp,hl
        ;Gets the duration again. No need to check the end of the song,
        ;we know it contains at least one pattern.
        pop hl
PLY_AKY_LinkerNotEndSong:
        ld (PLY_AKY_PatternFrameCounter + PLY_AKY_Offset1b),hl

        REPEAT PLY_AKY_ChannelCount, ChannelNumber
                pop hl
                ld (PLY_AKY_Channel{ChannelNumber}_PtTrack + PLY_AKY_Offset1b),hl
        REND
        ld (PLY_AKY_PtLinker + PLY_AKY_Offset1b),sp

        ;Resets the RegisterBlocks of the channel >1. The first one is skipped so there is no need to do so.
        ld a,1
        REPEAT PLY_AKY_ChannelCount - 1, ChannelNumber
                ld (PLY_AKY_Channel{ChannelNumber+1}_WaitBeforeNextRegisterBlock + PLY_AKY_Offset1b),a
        REND
        jr PLY_AKY_Channel1_WaitBeforeNextRegisterBlock_Over

;Reading the Tracks.
;----------------------------------------

        REPEAT PLY_AKY_ChannelCount, ChannelNumber                        ; ------------------------------------ REPEAT

        IFNDEF PLY_AKY_ROM
PLY_AKY_Channel{ChannelNumber}_WaitBeforeNextRegisterBlock: ld a,1        ;Frames to wait before reading the next RegisterBlock. 0 = finished.
        ELSE
PLY_AKY_Channel{ChannelNumber}_WaitBeforeNextRegisterBlock_Start:
        ld a,(PLY_AKY_Channel{ChannelNumber}_WaitBeforeNextRegisterBlock)
        ENDIF
        dec a
        jr nz,PLY_AKY_Channel{ChannelNumber}_RegisterBlock_Process
PLY_AKY_Channel{ChannelNumber}_WaitBeforeNextRegisterBlock_Over:
        ;This RegisterBlock is finished. Reads the next one from the Track.
        ;Obviously, starts at the initial state.
        ld a,PLY_AKY_OPCODE_OR_A
        ld (PLY_AKY_Channel{ChannelNumber}_RegisterBlockLineState_Opcode),a
        IFNDEF PLY_AKY_ROM
dknr3 (void):
PLY_AKY_Channel{ChannelNumber}_PtTrack: ld sp,0                   ;Points on the Track.
        ELSE
        ld sp,(PLY_AKY_Channel{ChannelNumber}_PtTrack)
        ENDIF
        dec sp                                  ;Only one byte is read. Compensate.
        pop af                                  ;Gets the duration.
        pop hl                                  ;Reads the RegisterBlock address.

        ld (PLY_AKY_Channel{ChannelNumber}_PtTrack + PLY_AKY_Offset1b),sp
        ld (PLY_AKY_Channel{ChannelNumber}_PtRegisterBlock + PLY_AKY_Offset1b),hl

        ;A is the duration of the block.
PLY_AKY_Channel{ChannelNumber}_RegisterBlock_Process:
        ;Processes the RegisterBlock, whether it is the current one or a new one.
        ld (PLY_AKY_Channel{ChannelNumber}_WaitBeforeNextRegisterBlock + PLY_AKY_Offset1b),a
        
        REND                                                            ; ------------------------------------ REPEAT END













;Reading the RegisterBlock.
;----------------------------------------
        ;Auxiliary registers are for the PSG access.
dknr3 (void):   ld hl,0 * 256 + 8                       ;H = first frequency register, L = first volume register.
        IFDEF PLY_AKY_HARDWARE_CPC
dknr3 (void):   ld de,#f4f6                             ;PSG ports.
dknr3 (void):   ld bc,#f690                             ;#90 used for both #80 for the PSG, and volume 16!

                ld a,#c0                                ;Used for PSG.
                out (c),a                               ;f6c0. Madram's trick requires to start with this. out (c),b works, but will activate K7's relay! Not clean.
        ex af,af'
        ENDIF

        IFDEF PLY_AKY_HARDWARE_MSX
                ld c,16                                 ;Hardware volume.
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
dknr3 (void):   ld de,#bfff                             ;PSG ports. E is also used for Volume = Hardware (bit 5 to 1).
dknr3 (void):   ld bc,#fffd
        ENDIF
        exx

        ;In B, R7 with default values: fully sound-open but noise-close.
        ;R7 has been shift twice to the left, it will be shifted back as the channels are treated.
dknr3 (void):  ld bc,%11100000 * 256 + 255                     ;C is 255 to prevent the following LDIs to decrease B.

        ld sp,PLY_AKY_RetTable_ReadRegisterBlock

        ;This macro takes care of reading the RegisterBlock for one channel.        
        MACRO PLY_AKY_ReadRegisterBlockMacro, ChannelNumber          ;-------------------------------------------------

        IFNDEF PLY_AKY_ROM
dknr3 (void):
PLY_AKY_Channel{ChannelNumber}_PtRegisterBlock: ld hl,0                   ;Points on the data of the RegisterBlock to read.
        ELSE
        ld hl,(PLY_AKY_Channel{ChannelNumber}_PtRegisterBlock)
        ENDIF

        IFNDEF PLY_AKY_ROM
PLY_AKY_Channel{ChannelNumber}_RegisterBlockLineState_Opcode: or a        ;"or a" if initial state, "scf" (#37) if non-initial state.
        ELSE
        ld a,(PLY_AKY_Channel{ChannelNumber}_RegisterBlockLineState_Opcode)
        add a,a                                             ;Carry is set according to the opcode.
        ENDIF
        jp PLY_AKY_ReadRegisterBlock
PLY_AKY_Channel{ChannelNumber}_RegisterBlock_Return:
        ld a,PLY_AKY_OPCODE_SCF
        ld (PLY_AKY_Channel{ChannelNumber}_RegisterBlockLineState_Opcode),a
        ld (PLY_AKY_Channel{ChannelNumber}_PtRegisterBlock + PLY_AKY_Offset1b),hl        ;This is new pointer on the RegisterBlock.
        
        ENDM                                                    ;--------------------------------------------------

        ;Channel 1
        PLY_AKY_ReadRegisterBlockMacro 1

        ;Channel 2
        ;Shifts the R7 for the next channels.
        srl b           ;Not RR, because we have to make sure the b6 is 0, else no more keyboard (on CPC)!
                        ;Also, on MSX, bit 6 must be 0.

        PLY_AKY_ReadRegisterBlockMacro 2
        
        ;Channel 3
        ;Shifts the R7 for the next channels.
        IFDEF PLY_AKY_HARDWARE_MSX
                scf             ;On MSX, bit 7 must be 1.
                rr b
        ELSE
                rr b            ;Safe to use RR, we don't care if b7 of R7 is 0 or 1.
        ENDIF

        PLY_AKY_ReadRegisterBlockMacro 3
        
        ;Register 7 to A.
        ld a,b

;Almost all the channel specific registers have been sent. Now sends the remaining registers (6, 7, 11, 12, 13).

;Register 7. Note that managing register 7 before 6/11/12 is done on purpose (the 6/11/12 registers are filled using OUTI).
        exx
        IFDEF PLY_AKY_HARDWARE_CPC
                inc h           ;Was 6, so now 7!

                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'

;Register 6
                        IFDEF PLY_AKY_USE_Noise         ;CONFIG SPECIFIC
                dec h

                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.

                ld hl,PLY_AKY_PsgRegister6
                dec b           ; -1, not -2 because of OUTI does -1 before doing the out.
                outi            ;f400 + value
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
                        ELSE
                        ;No noise. Still, makes HL points on the data after the noise.
                        ld hl,PLY_AKY_PsgRegister6 + 1
                        ENDIF ;PLY_AKY_USE_Noise

                        IFDEF PLY_CFG_UseHardwareSounds         ;CONFIG SPECIFIC
;Register 11
                ld a,11         ;Next register

                ld b,d
                out (c),a       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                dec b
                outi            ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'


;Register 12
                inc a           ;Next register

                ld b,d
                out (c),a       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                dec b
                outi            ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
                        ENDIF ;PLY_CFG_UseHardwareSounds
                
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                inc h           ;Was 6, so now 7!
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value
                ld b,e
        
                ;Register 6.
                        IFDEF PLY_AKY_USE_Noise         ;CONFIG SPECIFIC
                dec h
                out (c),h       ;#fffd + register.
                ld b,d
                ld a,(PLY_AKY_PsgRegister6)     ;COULD be optimized, but I didn't want to change the code structure from one platform to another one.
                out (c),a       ;#bffd + value
                ld b,e
                        ENDIF ;PLY_AKY_USE_Noise

                        IFDEF PLY_CFG_UseHardwareSounds         ;CONFIG SPECIFIC

                ;Register 11.
                ld h,11
                out (c),h       ;#fffd + register.
                ld b,d
                ld a,(PLY_AKY_PsgRegister11)
                out (c),a       ;#bffd + value
                ld b,e
                
                ;Register 12.
                inc h
                out (c),h       ;#fffd + register.
                ld b,d
                ld a,(PLY_AKY_PsgRegister12)
                out (c),a       ;#bffd + value
                ld b,e
                        ENDIF ;PLY_CFG_UseHardwareSounds
                
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a          ;Preserves R7.
                ld a,7
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        
                        IFDEF PLY_AKY_USE_Noise         ;CONFIG SPECIFIC
                ld a,6
                out (#a0),a     ;Register.
                ld a,(PLY_AKY_PsgRegister6)     ;COULD be optimized, but I didn't want to change the code structure from one platform to another one.
                out (#a1),a     ;Value.
                        ENDIF ;PLY_AKY_USE_Noise
                
                        IFDEF PLY_CFG_UseHardwareSounds         ;CONFIG SPECIFIC
                ld a,11
                out (#a0),a     ;Register.
                ld a,(PLY_AKY_PsgRegister11)
                out (#a1),a     ;Value.
                
                ld a,12
                out (#a0),a     ;Register.
                ld a,(PLY_AKY_PsgRegister12)
                out (#a1),a     ;Value.
                        ENDIF ;PLY_CFG_UseHardwareSounds
        ENDIF

;Register 13
                        IFDEF PLY_CFG_UseHardwareSounds         ;CONFIG SPECIFIC
PLY_AKY_PsgRegister13_Code
        IFDEF PLY_AKY_ROM
                ld a,(PLY_AKY_PsgRegister13_Retrig)     ;ROM: needs to keep retrig in a register to compare A with it later.
                ld b,a
        ENDIF

        IFDEF PLY_AKY_HARDWARE_CPC
                ld a,(hl)
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                ld a,(PLY_AKY_PsgRegister13)
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld a,(PLY_AKY_PsgRegister13)
        ENDIF
        
        IFNDEF PLY_AKY_ROM
PLY_AKY_PsgRegister13_Retrig: cp 255                         ;If IsRetrig?, force the R13 to be triggered.
        ELSE
                cp b
        ENDIF
                jr z,PLY_AKY_PsgRegister13_End
                ld (PLY_AKY_PsgRegister13_Retrig + PLY_AKY_Offset1b),a


        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                ld l,13
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ;ex af,af'
                
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                IFDEF PLY_AKY_ROM
                        ld b,e  ;B has been modified if ROM.
                ENDIF
                ld l,13
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value
                
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,13
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.           
        ENDIF
PLY_AKY_PsgRegister13_End:

                        ENDIF ;PLY_CFG_UseHardwareSounds

        IFNDEF PLY_AKY_ROM
dknr3 (void):
PLY_AKY_Exit: ld sp,0
        ELSE
        ld sp,(PLY_AKY_SaveSp)
        ENDIF
        ret








;Generic code interpreting the RegisterBlock
;IN:    HL = First byte.
;       Carry = 0 = initial state, 1 = non-initial state.
;----------------------------------------------------------------
PLY_AKY_ReadRegisterBlock:
        ;Gets the first byte of the line. What type? Jump to the matching code.
        ld a,(hl)
        inc hl
        jp c,PLY_AKY_RRB_NonInitialState
        ;Initial state.
        rra
        jr c,PLY_AKY_RRB_IS_SoftwareOnlyOrSoftwareAndHardware
        rra
                        IFDEF PLY_CFG_HardOnly  ;CONFIG SPECIFIC
        jr c,PLY_AKY_RRB_IS_HardwareOnly
                        ENDIF ;PLY_CFG_HardOnly
        ;jr PLY_AKY_RRB_IS_NoSoftwareNoHardware

;Generic code interpreting the RegisterBlock - Initial state.
;----------------------------------------------------------------
;IN:    HL = Points after the first byte.
;       A = First byte, twice shifted to the right (type removed).
;       B = Register 7. All sounds are open (0) by default, all noises closed (1). The code must put ONLY bit 2 and 5 for sound and noise respectively. NOT any other bits!
;       C = May be used as a temp. BUT must NOT be 0, as ldi will decrease it, we do NOT want B to be decreased!!
;       DE = free to use.
;       IX = free to use (not used!).
;       IY = free to use (not used!).

;       A' = free to use (not used).
;       DE' = f4f6
;       BC' = f680
;       L' = Volume register.
;       H' = LSB frequency register.

;OUT:   HL MUST point after the structure.
;       B = updated (ONLY bit 2 and 5).
;       L' = Volume register increased of 1 (*** IMPORTANT! The code MUST increase it, even if not using it! ***)
;       H' = LSB frequency register, increased of 2 (see above).
;       DE' = unmodified (f4f6)
;       BC' = unmodified (f680)

PLY_AKY_RRB_NoiseChannelBit: equ 5          ;Bit to modify to set/reset the noise channel.
PLY_AKY_RRB_SoundChannelBit: equ 2          ;Bit to modify to set/reset the sound channel.

                        IFDEF PLY_CFG_NoSoftNoHard        ;CONFIG SPECIFIC
PLY_AKY_RRB_IS_NoSoftwareNoHardware:
        ;No software no hardware.
        rra                     ;Noise?
                        IFDEF PLY_CFG_NoSoftNoHard_Noise        ;CONFIG SPECIFIC
        jr nc,PLY_AKY_RRB_NIS_NoSoftwareNoHardware_ReadVolume
        ;There is a noise. Reads it.
        ld de,PLY_AKY_PsgRegister6
        ldi                     ;Safe for B, C is not 0. Preserves A.

        ;Opens the noise channel.
        res PLY_AKY_RRB_NoiseChannelBit, b
PLY_AKY_RRB_NIS_NoSoftwareNoHardware_ReadVolume:
                        ENDIF ;PLY_CFG_NoSoftNoHard_Noise
        ;The volume is now in b0-b3.
        ;and %1111      ;No need, the bit 7 was 0.

        exx
                ;Sends the volume.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,l
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value
                ld b,e
        ENDIF
                inc l           ;Increases the volume register.
                inc h           ;Increases the frequency register.
                inc h
        exx

        ;Closes the sound channel.
        set PLY_AKY_RRB_SoundChannelBit, b
        ret
                        ENDIF ;PLY_CFG_NoSoftNoHard


;---------------------
                        IFDEF PLY_CFG_HardOnly  ;CONFIG SPECIFIC
PLY_AKY_RRB_IS_HardwareOnly:
        ;Retrig?
        rra
                        IFDEF PLY_CFG_HardOnly_Retrig   ;CONFIG SPECIFIC
        jr nc,PLY_AKY_RRB_IS_HO_NoRetrig
        set 7,a                         ;A value to make sure the retrig is performed, yet A can still be use.
        ld (PLY_AKY_PsgRegister13_Retrig + PLY_AKY_Offset1b),a
PLY_AKY_RRB_IS_HO_NoRetrig:
                        ENDIF ;PLY_CFG_HardOnly_Retrig

        ;Noise?
        rra
                        IFDEF PLY_CFG_HardOnly_Noise   ;CONFIG SPECIFIC
        jr nc,PLY_AKY_RRB_IS_HO_NoNoise
        ;Reads the noise.
        ld de,PLY_AKY_PsgRegister6
        ldi                     ;Safe for B, C is not 0. Preserves A.
        ;Opens the noise channel.
        res PLY_AKY_RRB_NoiseChannelBit, b
PLY_AKY_RRB_IS_HO_NoNoise:
                        ENDIF ;PLY_CFG_HardOnly_Noise

        ;The envelope.
        and %1111
        ld (PLY_AKY_PsgRegister13),a

        ;Copies the hardware period.
        ld de,PLY_AKY_PsgRegister11
        ldi
        ldi

        ;Closes the sound channel.
        set PLY_AKY_RRB_SoundChannelBit, b

        exx
                ;Sets the hardware volume.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),c       ;f400 + value (volume to 16).
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF

        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),e       ;#bffd + value (volume to 16).
                ld b,e        
        ENDIF

        IFDEF PLY_AKY_HARDWARE_MSX
                ld a,l
                out (#a0),a     ;Register.
                ld a,c
                out (#a1),a     ;Value (volume to 16).
        ENDIF

                inc l           ;Increases the volume register.
                inc h           ;Increases the frequency register (mandatory!).
                inc h
        exx
        ret
                        ENDIF ;PLY_CFG_HardOnly


;---------------------
PLY_AKY_RRB_IS_SoftwareOnlyOrSoftwareAndHardware:
        ;Another decision to make about the sound type.
        rra
                        IFDEF PLY_AKY_USE_SoftAndHard_Agglomerated      ;CONFIG SPECIFIC
        jr c,PLY_AKY_RRB_IS_SoftwareAndHardware
                        ENDIF ;PLY_AKY_USE_SoftAndHard_Agglomerated

        ;Software only. Structure: 0vvvvntt.
        ;Noise?
        rra
                        IFDEF PLY_CFG_SoftOnly_Noise    ;CONFIG SPECIFIC
        jr nc,PLY_AKY_RRB_IS_SoftwareOnly_NoNoise
        ;Noise. Reads it.
        ld de,PLY_AKY_PsgRegister6
        ldi                     ;Safe for B, C is not 0. Preserves A.
        ;Opens the noise channel.
        res PLY_AKY_RRB_NoiseChannelBit, b
PLY_AKY_RRB_IS_SoftwareOnly_NoNoise:
                        ENDIF ;PLY_CFG_SoftOnly_Noise
        ;Reads the volume (now b0-b3).
        ;Note: we do NOT peform a "and %1111" because we know the bit 7 of the original byte is 0, so the bit 4 is currently 0. Else the hardware volume would be on!
        exx
                ;Sends the volume.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value.
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,l
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                inc l           ;Increases the volume register.
        exx

        ;Reads the software period.
        ld a,(hl)
        inc hl
        exx
                ;Sends the LSB software frequency.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,h
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                inc h           ;Increases the frequency register.
        exx

        ld a,(hl)
        inc hl
        exx
                ;Sends the MSB software frequency.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,h
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                inc h           ;Increases the frequency register.
        exx

        ret





;---------------------
                        IFDEF PLY_AKY_USE_SoftAndHard_Agglomerated      ;CONFIG SPECIFIC
PLY_AKY_RRB_IS_SoftwareAndHardware:
        ;Retrig?
        rra
                                IFDEF PLY_CFG_UseRetrig      ;CONFIG SPECIFIC
        jr nc,PLY_AKY_RRB_IS_SAH_NoRetrig
        set 7,a                         ;A value to make sure the retrig is performed, yet A can still be use.
        ld (PLY_AKY_PsgRegister13_Retrig + PLY_AKY_Offset1b),a
PLY_AKY_RRB_IS_SAH_NoRetrig:
                                ENDIF ;PLY_CFG_UseRetrig

        ;Noise?
        rra
                                IFDEF PLY_AKY_USE_SoftAndHard_Noise_Agglomerated
        jr nc,PLY_AKY_RRB_IS_SAH_NoNoise
        ;Reads the noise.
        ld de,PLY_AKY_PsgRegister6
        ldi                     ;Safe for B, C is not 0. Preserves A.
        ;Opens the noise channel.
        res PLY_AKY_RRB_NoiseChannelBit, b
PLY_AKY_RRB_IS_SAH_NoNoise:
                                ENDIF ;PLY_AKY_USE_SoftAndHard_Noise_Agglomerated

        ;The envelope.
        and %1111
        ld (PLY_AKY_PsgRegister13),a

        ;Reads the software period.
        ld a,(hl)
        inc hl
        exx
                ;Sends the LSB software frequency.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,h
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                inc h           ;Increases the frequency register.
        exx

        ld a,(hl)
        inc hl
        exx
        IFDEF PLY_AKY_HARDWARE_CPC
                ;Sends the MSB software frequency.
                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,h
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                inc h           ;Increases the frequency register.

                ;Sets the hardware volume.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),c       ;f400 + value (volume to 16).
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
                
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),e       ;#bffd + value (volume to 16).
                ld b,e
                
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld a,l
                out (#a0),a     ;Register.
                ld a,c
                out (#a1),a     ;Value (volume to 16).
                        
        ENDIF
                inc l           ;Increases the volume register.
        exx

        ;Copies the hardware period.
        ld de,PLY_AKY_PsgRegister11
        ldi
        ldi
        ret
                        ENDIF ;PLY_AKY_USE_SoftAndHard_Agglomerated







        ;Manages the loop. This code is put here so that no jump needs to be coded when its job is done.
PLY_AKY_RRB_NIS_NoSoftwareNoHardware_Loop
        ;Loops. Reads the next pointer to this RegisterBlock.
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a

        ;Makes another iteration to read the new data.
        ;Since we KNOW it is not an initial state (because no jump goes to an initial state), we can directly go to the right branching.
        ;Reads the first byte.
        ld a,(hl)
        inc hl
        ;jr PLY_AKY_RRB_NonInitialState

;Generic code interpreting the RegisterBlock - Non initial state. See comment about the Initial state for the registers ins/outs.
;----------------------------------------------------------------
PLY_AKY_RRB_NonInitialState:
        rra
        jr c,PLY_AKY_RRB_NIS_SoftwareOnlyOrSoftwareAndHardware
        rra
                        IFDEF PLY_CFG_HardOnly  ;CONFIG SPECIFIC
        jp c,PLY_AKY_RRB_NIS_HardwareOnly
                        ENDIF ;PLY_CFG_HardOnly

        ;No software, no hardware, OR loop.

        ld e,a
        and %11         ;Bit 3:loop?/volume bit 0, bit 2: volume?
        cp %10          ;If no volume, yet the volume is >0, it means loop.
        jr z,PLY_AKY_RRB_NIS_NoSoftwareNoHardware_Loop

        ;No loop: so "no software no hardware".
                        IFDEF PLY_CFG_NoSoftNoHard        ;CONFIG SPECIFIC

        ;Closes the sound channel.
        set PLY_AKY_RRB_SoundChannelBit, b

        ;Volume? bit 2 - 2.
        ld a,e
        rra
        jr nc,PLY_AKY_RRB_NIS_NoVolume
        and %1111
        exx
                ;Sends the volume.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value.
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,l
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
        exx
PLY_AKY_RRB_NIS_NoVolume:
        ;Sadly, have to lose a bit of CPU here, as this must be done in all cases.
        exx
                inc l           ;Next volume register.
                inc h           ;Next frequency registers.
                inc h
        exx

        ;Noise? Was on bit 7, but there has been two shifts. We can't use A, it may have been modified by the volume AND.
                        IFDEF PLY_CFG_NoSoftNoHard_Noise        ;CONFIG SPECIFIC
        bit 7 - 2, e
        ret z
        ;Noise.
        ld a,(hl)
        ld (PLY_AKY_PsgRegister6),a
        inc hl
        ;Opens the noise channel.
        res PLY_AKY_RRB_NoiseChannelBit, b
                        ENDIF ;PLY_CFG_NoSoftNoHard_Noise
        ret
                        ENDIF ;PLY_CFG_NoSoftNoHard






PLY_AKY_RRB_NIS_SoftwareOnlyOrSoftwareAndHardware:
        ;Another decision to make about the sound type.
        rra
                        IFDEF PLY_AKY_USE_SoftAndHard_Agglomerated      ;CONFIG SPECIFIC
        jp c,PLY_AKY_RRB_NIS_SoftwareAndHardware
                        ENDIF


;---------------------
                        IFDEF PLY_CFG_SoftOnly  ;CONFIG SPECIFIC
        ;Software only. Structure: mspnoise lsp v  v  v  v  (0  1).
        ld e,a
        ;Gets the volume (already shifted).
        and %1111
        exx
                ;Sends the volume.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value.
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,l
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                inc l           ;Increases the volume register.
        exx

        ;LSP? (Least Significant byte of Period). Was bit 6, but now shifted.
        bit 6 - 2, e
        jr z,PLY_AKY_RRB_NIS_SoftwareOnly_NoLSP
        ld a,(hl)
        inc hl
        exx
        IFDEF PLY_AKY_HARDWARE_CPC
                ;Sends the LSB software frequency.
                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value.
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,h
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                ;H not incremented on purpose.
        exx
PLY_AKY_RRB_NIS_SoftwareOnly_NoLSP:

        ;MSP AND/OR (Noise and/or new Noise)? (Most Significant byte of Period).
        bit 7 - 2, e
        jr nz,PLY_AKY_RRB_NIS_SoftwareOnly_MSPAndMaybeNoise
        ;Bit of loss of CPU, but has to be done in all cases.
        exx
                inc h
                inc h
        exx
        ret
PLY_AKY_RRB_NIS_SoftwareOnly_MSPAndMaybeNoise:
        ;MSP and noise?, in the next byte. in--pppp (i = isNoise? n = newNoise? p = MSB period).
        ld a,(hl)       ;Useless bits at the end, not a problem.
        inc hl
        exx
                ;Sends the MSB software frequency.
                inc h           ;Was not increased before.

        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value.
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,h
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                inc h           ;Increases the frequency register.
        exx
                                IFDEF PLY_CFG_SoftOnly_Noise  ;CONFIG SPECIFIC
        rla     ;Carry is isNoise?
        ret nc

        ;Opens the noise channel.
        res PLY_AKY_RRB_NoiseChannelBit, b

        ;Is there a new noise value? If yes, gets the noise.
        rla
        ret nc
        ;Gets the noise.
        ld de,PLY_AKY_PsgRegister6
        ldi
                                ENDIF ;PLY_CFG_SoftOnly_Noise
        ret
                        ENDIF ;PLY_CFG_SoftOnly


;---------------------
                        IFDEF PLY_CFG_HardOnly  ;CONFIG SPECIFIC
PLY_AKY_RRB_NIS_HardwareOnly
        ;Gets the envelope (initially on b2-b4, but currently on b0-b2). It is on 3 bits, must be encoded on 4. Bit 0 must be 0.
        rla
        ld e,a
        and %1110
        ld (PLY_AKY_PsgRegister13),a

        ;Closes the sound channel.
        set PLY_AKY_RRB_SoundChannelBit, b

        ;Hardware volume.
        exx
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),c       ;f400 + value (16, hardware volume).
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),e       ;#bffd + value (volume to 16).
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld a,l
                out (#a0),a     ;Register.
                ld a,c
                out (#a1),a     ;Value (16, hardware volume).
        ENDIF

                inc l           ;Increases the volume register.

                inc h           ;Increases the frequency register.
                inc h
        exx

        ld a,e

        ;LSB for hardware period? Currently on b6.
        rla
        rla
        jr nc,PLY_AKY_RRB_NIS_HardwareOnly_NoLSB
        ld de,PLY_AKY_PsgRegister11
        ldi
PLY_AKY_RRB_NIS_HardwareOnly_NoLSB:

        ;MSB for hardware period?
        rla
        jr nc,PLY_AKY_RRB_NIS_HardwareOnly_NoMSB
        ld de,PLY_AKY_PsgRegister12
        ldi
PLY_AKY_RRB_NIS_HardwareOnly_NoMSB:

        ;Noise or retrig?
        rla
        jr c,PLY_AKY_RRB_NIS_Hardware_Shared_NoiseOrRetrig_AndStop          ;The retrig/noise code is shared.

        ret
                        ENDIF ;PLY_CFG_HardOnly


;---------------------
                        IFDEF PLY_AKY_USE_SoftAndHard_Agglomerated      ;CONFIG SPECIFIC
PLY_AKY_RRB_NIS_SoftwareAndHardware:
        ;Hardware volume.
        exx
                ;Sends the volume.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),l       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),c       ;f400 + value (16 = hardware volume).
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),l       ;#fffd + register.
                ld b,d
                out (c),e       ;#bffd + value (volume to 16).
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a          ;A must be preserved.
                ld a,l
                out (#a0),a     ;Register.
                ld a,c
                out (#a1),a     ;Value (16 = hardware volume).
                ld a,b
        ENDIF
        
                inc l           ;Increases the volume register.
        exx

        ;LSB of hardware period?
        rra
        jr nc,PLY_AKY_RRB_NIS_SAHH_AfterLSBH
        ld de,PLY_AKY_PsgRegister11
        ldi
PLY_AKY_RRB_NIS_SAHH_AfterLSBH:
        ;MSB of hardware period?
        rra
        jr nc,PLY_AKY_RRB_NIS_SAHH_AfterMSBH
        ld de,PLY_AKY_PsgRegister12
        ldi
PLY_AKY_RRB_NIS_SAHH_AfterMSBH:

        ;LSB of software period?
        rra
        jr nc,PLY_AKY_RRB_NIS_SAHH_AfterLSBS
        ld e,a
        ld a,(hl)
        inc hl
        exx
                ;Sends the LSB software frequency.
        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value.
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,h
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                ;H not increased on purpose.
        exx
        ld a,e
PLY_AKY_RRB_NIS_SAHH_AfterLSBS:

        ;MSB of software period?
        rra
        jr nc,PLY_AKY_RRB_NIS_SAHH_AfterMSBS
        ld e,a
        ld a,(hl)
        inc hl
        exx
                ;Sends the MSB software frequency.
                inc h

        IFDEF PLY_AKY_HARDWARE_CPC
                ld b,d
                out (c),h       ;f400 + register.
                ld b,e
                out (c),0       ;f600.
                ld b,d
                out (c),a       ;f400 + value.
                ld b,e
                out (c),c       ;f680
                ex af,af'
                out (c),a       ;f6c0.
                ex af,af'
        ENDIF
        IFDEF PLY_AKY_HARDWARE_SPECTRUM_OR_PENTAGON
                out (c),h       ;#fffd + register.
                ld b,d
                out (c),a       ;#bffd + value.
                ld b,e
        ENDIF
        IFDEF PLY_AKY_HARDWARE_MSX
                ld b,a
                ld a,h
                out (#a0),a     ;Register.
                ld a,b
                out (#a1),a     ;Value.
        ENDIF
                dec h           ;Yup. Will be compensated below.
        exx
        ld a,e
PLY_AKY_RRB_NIS_SAHH_AfterMSBS:
        ;A bit of loss of CPU, but this has to be done every time!
        exx
                inc h
                inc h
        exx

        ;New hardware envelope?
        rra
        jr nc,PLY_AKY_RRB_NIS_SAHH_AfterEnvelope
        ld de,PLY_AKY_PsgRegister13
        ldi
PLY_AKY_RRB_NIS_SAHH_AfterEnvelope:

        ;Retrig and/or noise?
        rra
        ret nc
                        ENDIF ;PLY_AKY_USE_SoftAndHard_Agglomerated

                        IFDEF PLY_CFG_UseHardwareSounds         ;CONFIG SPECIFIC
        ;This code is shared with the HardwareOnly. It reads the Noise/Retrig byte, interprets it and exits.
        ;------------------------------------------
PLY_AKY_RRB_NIS_Hardware_Shared_NoiseOrRetrig_AndStop:
        ;Noise or retrig. Reads the next byte.
        ld a,(hl)
        inc hl

        ;Retrig?
        rra
                        IFDEF PLY_CFG_UseRetrig         ;CONFIG SPECIFIC
        jr nc,PLY_AKY_RRB_NIS_S_NOR_NoRetrig
        set 7,a                         ;A value to make sure the retrig is performed, yet A can still be use.
        ld (PLY_AKY_PsgRegister13_Retrig + PLY_AKY_Offset1b),a
PLY_AKY_RRB_NIS_S_NOR_NoRetrig:
                        ENDIF ;PLY_CFG_UseRetrig

                        IFDEF PLY_AKY_USE_SoftAndHard_Noise_Agglomerated        ;CONFIG SPECIFIC
        ;Noise? If no, nothing more to do.
        rra
        ret nc
        ;Noise. Opens the noise channel.
        res PLY_AKY_RRB_NoiseChannelBit, b
        ;Is there a new noise value? If yes, gets the noise.
        rra
        ret nc
        ;Sets the noise.
        ld (PLY_AKY_PsgRegister6),a
                        ENDIF ;PLY_AKY_USE_SoftAndHard_Noise_Agglomerated
        ret
                        ENDIF ;PLY_CFG_UseHardwareSounds


        IFNDEF PLY_AKY_ROM
;Some stored PSG registers. They MUST be consecutive.
dkbs (void):
PLY_AKY_PsgRegister6: db 0
                IFDEF PLY_CFG_UseHardwareSounds
PLY_AKY_PsgRegister11: db 0
PLY_AKY_PsgRegister12: db 0
PLY_AKY_PsgRegister13: db 0
                ENDIF
dkbe (void):
                IFDEF PLY_CFG_UseHardwareSounds
        assert (PLY_AKY_PsgRegister11 - PLY_AKY_PsgRegister6) == 1
        assert (PLY_AKY_PsgRegister12 - PLY_AKY_PsgRegister11) == 1
        assert (PLY_AKY_PsgRegister13 - PLY_AKY_PsgRegister12) == 1
                ENDIF
        ENDIF

;RET table for the Read RegisterBlock code to know where to return.
PLY_AKY_RetTable_ReadRegisterBlock:
dkps (void):
        REPEAT PLY_AKY_ChannelCount, ChannelNumber
                dw PLY_AKY_Channel{ChannelNumber}_RegisterBlock_Return
        REND
dkpe (void):
        
        
;Buffer used for the ROM player. This part needs to be set to RAM.
        IFDEF PLY_AKY_ROM
dkbs (void):
        ;Bytes first.
PLY_AKY_ROM_BufferSize = 0
                REPEAT PLY_AKY_ChannelCount, ChannelNumber
PLY_AKY_Channel{ChannelNumber}_WaitBeforeNextRegisterBlock:     equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 1
                REND
                REPEAT PLY_AKY_ChannelCount, ChannelNumber
PLY_AKY_Channel{ChannelNumber}_RegisterBlockLineState_Opcode:   equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 1
                REND
;Some stored PSG registers. They MUST be consecutive (assertion don't work in this case...).
PLY_AKY_PsgRegister6:                                           equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 1
                IFDEF PLY_CFG_UseHardwareSounds
PLY_AKY_PsgRegister11:                                          equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 1
PLY_AKY_PsgRegister12:                                          equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 1
PLY_AKY_PsgRegister13:                                          equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 1
PLY_AKY_PsgRegister13_Retrig:                                   equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 1
                ENDIF
dkbe (void):
        ;Words.
dkws (void):
PLY_AKY_PtLinker:                                               equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
PLY_AKY_SaveSp:                                                 equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
PLY_AKY_PatternFrameCounter:                                    equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
PLY_AKY_Channel1_PtTrack:                                       equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
PLY_AKY_Channel2_PtTrack:                                       equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
PLY_AKY_Channel3_PtTrack:                                       equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
PLY_AKY_Channel1_PtRegisterBlock:                               equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
PLY_AKY_Channel2_PtRegisterBlock:                               equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
PLY_AKY_Channel3_PtRegisterBlock:                               equ PLY_AKY_ROM_Buffer + PLY_AKY_ROM_BufferSize : PLY_AKY_ROM_BufferSize = PLY_AKY_ROM_BufferSize + 2
dkwe (void):
                        IFDEF PLY_CFG_UseHardwareSounds
        assert PLY_AKY_ROM_BufferSize == 29
                        ELSE
        assert PLY_AKY_ROM_BufferSize == 25
                        ENDIF

        ENDIF
