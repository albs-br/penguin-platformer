JUSTADDCREAM_START
PLY_AKG_OFFSET2B
PLY_AKG_OFFSET1B
PLY_AKG_OPCODE_OR_A
PLY_AKG_OPCODE_ADD_HL_BC_MSB db 65
PLY_AKG_FULL_INIT_CODE
PLY_AKG_USE_HOOKS
PLY_AKG_STOP_SOUNDS db 84
PLY_AKG_BITFORSOUND
PLY_AKG_SOUNDEFFECTDATA_OFFSETINVERTEDVOLUME db 50
PLY_AKG_SOUNDEFFECTDATA_OFFSETCURRENTSTEP db 48
PLY_AKG_BITFORNOISE equ $+1
PLY_AKG_SOUNDEFFECTDATA_OFFSETSPEED dw JUSTADDCREAM_ARPEGGIOTABLE
    dw JUSTADDCREAM_PITCHTABLE
PLY_AKG_OPCODE_ADD_HL_BC_LSB equ $+1
    dw JUSTADDCREAM_INSTRUMENTTABLE
    dw JUSTADDCREAM_EFFECTBLOCKTABLE
    dw JUSTADDCREAM_SUBSONG0_START
JUSTADDCREAM_ARPEGGIOTABLE dw JUSTADDCREAM_ARPEGGIO1
    dw JUSTADDCREAM_ARPEGGIO2
    dw JUSTADDCREAM_ARPEGGIO3
JUSTADDCREAM_ARPEGGIO1 db 2
    db 7
    db 4
    db 0
    db 128
    dw JUSTADDCREAM_ARPEGGIO1+1
JUSTADDCREAM_ARPEGGIO2 db 2
    db 16
    db 12
    db 7
    db 128
    dw JUSTADDCREAM_ARPEGGIO2+1
JUSTADDCREAM_ARPEGGIO3 db 2
PLY_AKG_OPCODE_INC_HL db 12
    db 7
    db 4
    db 128
    dw PLY_AKG_OPCODE_INC_HL
JUSTADDCREAM_PITCHTABLE dw JUSTADDCREAM_PITCH1
JUSTADDCREAM_PITCH1
PLY_AKG_OPCODE_DEC_HL db 1
    db 255
    db 255
JUSTADDCREAM_PITCH1_GOTONEXTFORLINE0 dw JUSTADDCREAM_PITCH1_GOTONEXTFORLINE0+2
    db 254
    db 255
JUSTADDCREAM_PITCH1_GOTONEXTFORLINE1 dw JUSTADDCREAM_PITCH1_GOTONEXTFORLINE1+2
    db 253
    db 255
JUSTADDCREAM_PITCH1_GOTONEXTFORLINE2 dw JUSTADDCREAM_PITCH1_GOTONEXTFORLINE2+2
    db 254
    db 255
JUSTADDCREAM_PITCH1_GOTONEXTFORLINE3 dw JUSTADDCREAM_PITCH1_GOTONEXTFORLINE3+2
    db 255
    db 255
JUSTADDCREAM_PITCH1_GOTONEXTFORLINE4 dw JUSTADDCREAM_PITCH1_GOTONEXTFORLINE4+2
    db 1
    db 0
JUSTADDCREAM_PITCH1_GOTONEXTFORLINE5
PLY_AKG_OPCODE_SBC_HL_BC_LSB dw JUSTADDCREAM_PITCH1_GOTONEXTFORLINE5+2
    db 2
    db 0
JUSTADDCREAM_PITCH1_GOTONEXTFORLINE6 dw JUSTADDCREAM_PITCH1_GOTONEXTFORLINE6+2
    db 3
    db 0
JUSTADDCREAM_PITCH1_GOTONEXTFORLINE7 dw JUSTADDCREAM_PITCH1_GOTONEXTFORLINE7+2
    db 2
    db 0
    dw JUSTADDCREAM_PITCH1+1
JUSTADDCREAM_INSTRUMENTTABLE dw JUSTADDCREAM_EMPTYINSTRUMENT
    dw JUSTADDCREAM_INSTRUMENT1
    dw JUSTADDCREAM_INSTRUMENT2
    dw JUSTADDCREAM_INSTRUMENT3
    dw JUSTADDCREAM_INSTRUMENT4
    dw JUSTADDCREAM_INSTRUMENT5
    dw JUSTADDCREAM_INSTRUMENT6
    dw JUSTADDCREAM_INSTRUMENT7
    dw JUSTADDCREAM_INSTRUMENT8
    dw JUSTADDCREAM_INSTRUMENT9
    dw JUSTADDCREAM_INSTRUMENT10
    dw JUSTADDCREAM_INSTRUMENT11
JUSTADDCREAM_EMPTYINSTRUMENT db 0
JUSTADDCREAM_EMPTYINSTRUMENT_LOOP db 0
    db 6
JUSTADDCREAM_INSTRUMENT1 db 1
    db 105
    db 159
    db 188
    db 3
    db 121
    db 128
    db 244
    db 3
    db 121
    db 128
    db 252
    db 4
    db 121
    db 128
    db 237
    db 5
    db 105
    db 128
    db 104
    db 9
    db 6
JUSTADDCREAM_INSTRUMENT2 db 1
    db 121
    db 145
    db 170
    db 1
    db 121
    db 128
    db 24
    db 2
    db 121
    db 128
    db 126
    db 2
    db 121
    db 128
    db 204
    db 2
    db 232
    db 13
    db 216
    db 13
    db 6
JUSTADDCREAM_INSTRUMENT3 db 1
    db 2
    db 130
    db 2
    db 130
    db 233
    db 225
    db 217
    db 217
JUSTADDCREAM_INSTRUMENT3_LOOP db 217
    db 217
    db 7
    dw JUSTADDCREAM_INSTRUMENT3_LOOP
JUSTADDCREAM_INSTRUMENT4 db 1
    db 225
    db 217
    db 209
JUSTADDCREAM_INSTRUMENT4_LOOP db 201
    db 7
    dw JUSTADDCREAM_INSTRUMENT4_LOOP
JUSTADDCREAM_INSTRUMENT5 db 1
    db 105
    db 159
    db 188
    db 3
    db 121
    db 128
    db 244
    db 3
    db 121
    db 128
    db 252
    db 4
    db 121
    db 128
    db 237
    db 5
JUSTADDCREAM_INSTRUMENT5_LOOP db 217
    db 7
    dw JUSTADDCREAM_INSTRUMENT5_LOOP
JUSTADDCREAM_INSTRUMENT6 db 1
PLY_AKG_OPCODE_JP db 113
    db 145
    db 170
PLY_AKG_OPCODE_ADD_A_IMMEDIATE db 1
    db 113
    db 128
    db 24
    db 2
    db 113
    db 128
    db 126
    db 2
    db 113
    db 128
    db 204
    db 2
    db 224
    db 13
JUSTADDCREAM_INSTRUMENT6_LOOP db 217
PLY_AKG_OPCODE_SUB_IMMEDIATE db 7
    dw JUSTADDCREAM_INSTRUMENT6_LOOP
JUSTADDCREAM_INSTRUMENT7 db 1
    db 241
    db 233
    db 225
JUSTADDCREAM_INSTRUMENT7_LOOP db 217
    db 7
    dw JUSTADDCREAM_INSTRUMENT7_LOOP
JUSTADDCREAM_INSTRUMENT8 db 1
JUSTADDCREAM_INSTRUMENT8_LOOP db 193
    db 7
    dw JUSTADDCREAM_INSTRUMENT8_LOOP
JUSTADDCREAM_INSTRUMENT9 db 1
    db 73
    db 64
    db 12
    db 65
    db 64
    db 12
PLY_AKG_OPCODE_SBC_HL_BC_MSB db 185
JUSTADDCREAM_INSTRUMENT9_LOOP db 177
    db 49
    db 64
    db 12
    db 49
    db 64
    db 12
    db 177
    db 7
    dw JUSTADDCREAM_INSTRUMENT9_LOOP
JUSTADDCREAM_INSTRUMENT10 db 1
    db 49
    db 64
    db 12
    db 41
    db 64
PLY_AKG_OPCODE_SCF db 12
    db 161
JUSTADDCREAM_INSTRUMENT10_LOOP db 153
    db 25
    db 64
    db 12
    db 25
    db 64
    db 12
    db 153
    db 7
    dw JUSTADDCREAM_INSTRUMENT10_LOOP
JUSTADDCREAM_INSTRUMENT11 db 1
    db 41
    db 64
    db 12
    db 33
    db 64
    db 12
    db 153
JUSTADDCREAM_INSTRUMENT11_LOOP db 145
    db 17
    db 64
    db 12
    db 17
    db 64
    db 12
    db 145
    db 7
    dw JUSTADDCREAM_INSTRUMENT11_LOOP
JUSTADDCREAM_EFFECTBLOCKTABLE dw JUSTADDCREAM_EFFECTBLOCK_P4P0
    dw JUSTADDCREAM_EFFECTBLOCK_P14P64P0
    dw JUSTADDCREAM_EFFECTBLOCK_P4P1
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P14P64P0
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P6P2
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P10P0
    dw JUSTADDCREAM_EFFECTBLOCK_P15P112P0P12
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P6P1
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P6P0
    dw JUSTADDCREAM_EFFECTBLOCK_P15P64P0P6P1
    dw JUSTADDCREAM_EFFECTBLOCK_P6P1
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P14P112P0
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P14P160P0
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P15P64P0P6P0
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P15P64P0P6P2
    dw JUSTADDCREAM_EFFECTBLOCK_P14P160P0
    dw JUSTADDCREAM_EFFECTBLOCK_P10P0
    dw JUSTADDCREAM_EFFECTBLOCK_P15P64P0P6P0
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P13P18P0P1
    dw JUSTADDCREAM_EFFECTBLOCK_P20P0P5
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P15P112P0P12
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P18P0P2
    dw JUSTADDCREAM_EFFECTBLOCK_P4P2
    dw JUSTADDCREAM_EFFECTBLOCK_P15P64P0P20P0P16
    dw JUSTADDCREAM_EFFECTBLOCK_P24P64P0P1
    dw JUSTADDCREAM_EFFECTBLOCK_P24P60P0P2
    dw JUSTADDCREAM_EFFECTBLOCK_P15P64P0P6P2
    dw JUSTADDCREAM_EFFECTBLOCK_P6P2
    dw JUSTADDCREAM_EFFECTBLOCK_P5P14P15P128P255P13P6P1
    dw JUSTADDCREAM_EFFECTBLOCK_P6P0
    dw JUSTADDCREAM_EFFECTBLOCK_P24P59P128P1
    dw JUSTADDCREAM_EFFECTBLOCK_P13P18P128P1
    dw JUSTADDCREAM_EFFECTBLOCK_P24P57P0P3
    dw JUSTADDCREAM_EFFECTBLOCK_P15P8P0P20P0P6
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P8
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P18P0P12
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P18P128P1
    dw JUSTADDCREAM_EFFECTBLOCK_P4P3
    dw JUSTADDCREAM_EFFECTBLOCK_P24P23P0P12
    dw JUSTADDCREAM_EFFECTBLOCK_P24P48P128P1
    dw JUSTADDCREAM_EFFECTBLOCK_P5P0P13P8
    dw JUSTADDCREAM_EFFECTBLOCK_P14P32P0
    dw JUSTADDCREAM_EFFECTBLOCK_P14P8P0
    dw JUSTADDCREAM_EFFECTBLOCK_P14P112P0
    dw JUSTADDCREAM_EFFECTBLOCK_P12
    dw JUSTADDCREAM_EFFECTBLOCK_P20P0P1
    dw JUSTADDCREAM_EFFECTBLOCK_P4P4
    dw JUSTADDCREAM_EFFECTBLOCK_P4P5
JUSTADDCREAM_EFFECTBLOCK_P12 db 12
JUSTADDCREAM_EFFECTBLOCK_P4P0 db 4
    db 0
JUSTADDCREAM_EFFECTBLOCK_P4P1 db 4
    db 1
JUSTADDCREAM_EFFECTBLOCK_P4P2 db 4
    db 2
JUSTADDCREAM_EFFECTBLOCK_P4P3 db 4
    db 3
JUSTADDCREAM_EFFECTBLOCK_P4P4 db 4
    db 4
JUSTADDCREAM_EFFECTBLOCK_P4P5 db 4
    db 5
JUSTADDCREAM_EFFECTBLOCK_P6P0 db 6
    db 0
JUSTADDCREAM_EFFECTBLOCK_P6P1 db 6
    db 1
JUSTADDCREAM_EFFECTBLOCK_P6P2 db 6
    db 2
JUSTADDCREAM_EFFECTBLOCK_P5P0P8 db 5
    db 0
    db 8
JUSTADDCREAM_EFFECTBLOCK_P24P60P0P2 db 24
    db 60
    db 0
    db 2
JUSTADDCREAM_EFFECTBLOCK_P5P14P15P128P255P13P6P1 db 5
    db 14
    db 15
    db 128
    db 255
    db 13
    db 6
    db 1
JUSTADDCREAM_EFFECTBLOCK_P24P64P0P1 db 24
    db 64
    db 0
    db 1
JUSTADDCREAM_EFFECTBLOCK_P14P112P0 db 14
    db 112
    db 0
JUSTADDCREAM_EFFECTBLOCK_P14P160P0 db 14
    db 160
    db 0
JUSTADDCREAM_EFFECTBLOCK_P15P8P0P20P0P6 db 15
    db 8
    db 0
    db 20
    db 0
    db 6
JUSTADDCREAM_EFFECTBLOCK_P5P0P15P112P0P12 db 5
    db 0
    db 15
    db 112
    db 0
    db 12
JUSTADDCREAM_EFFECTBLOCK_P5P0P18P0P2 db 5
    db 0
    db 18
    db 0
    db 2
JUSTADDCREAM_EFFECTBLOCK_P15P64P0P20P0P16 db 15
    db 64
    db 0
    db 20
    db 0
    db 16
JUSTADDCREAM_EFFECTBLOCK_P5P0P14P112P0 db 5
    db 0
    db 14
    db 112
    db 0
JUSTADDCREAM_EFFECTBLOCK_P5P0P14P160P0 db 5
    db 0
    db 14
    db 160
    db 0
JUSTADDCREAM_EFFECTBLOCK_P5P0P10P0 db 5
    db 0
    db 10
    db 0
JUSTADDCREAM_EFFECTBLOCK_P5P0P13P8 db 5
    db 0
    db 13
    db 8
JUSTADDCREAM_EFFECTBLOCK_P5P0P15P64P0P6P0 db 5
    db 0
    db 15
    db 64
    db 0
    db 6
    db 0
JUSTADDCREAM_EFFECTBLOCK_P5P0P15P64P0P6P2 db 5
    db 0
    db 15
    db 64
    db 0
    db 6
    db 2
JUSTADDCREAM_EFFECTBLOCK_P24P59P128P1 db 24
    db 59
    db 128
    db 1
JUSTADDCREAM_EFFECTBLOCK_P14P32P0 db 14
    db 32
    db 0
JUSTADDCREAM_EFFECTBLOCK_P14P64P0 db 14
    db 64
    db 0
JUSTADDCREAM_EFFECTBLOCK_P13P18P128P1 db 13
    db 18
    db 128
    db 1
JUSTADDCREAM_EFFECTBLOCK_P5P0P13P18P0P1 db 5
    db 0
    db 13
    db 18
    db 0
    db 1
JUSTADDCREAM_EFFECTBLOCK_P14P8P0 db 14
    db 8
    db 0
JUSTADDCREAM_EFFECTBLOCK_P24P23P0P12 db 24
    db 23
    db 0
    db 12
JUSTADDCREAM_EFFECTBLOCK_P24P48P128P1 db 24
    db 48
    db 128
    db 1
JUSTADDCREAM_EFFECTBLOCK_P5P0P18P0P12 db 5
    db 0
    db 18
    db 0
    db 12
JUSTADDCREAM_EFFECTBLOCK_P15P112P0P12 db 15
    db 112
    db 0
    db 12
JUSTADDCREAM_EFFECTBLOCK_P24P57P0P3 db 24
    db 57
    db 0
    db 3
JUSTADDCREAM_EFFECTBLOCK_P15P64P0P6P0 db 15
    db 64
    db 0
    db 6
    db 0
JUSTADDCREAM_EFFECTBLOCK_P15P64P0P6P1 db 15
    db 64
    db 0
    db 6
    db 1
JUSTADDCREAM_EFFECTBLOCK_P15P64P0P6P2 db 15
    db 64
    db 0
    db 6
    db 2
JUSTADDCREAM_EFFECTBLOCK_P5P0P6P0 db 5
    db 0
    db 6
    db 0
JUSTADDCREAM_EFFECTBLOCK_P5P0P6P1 db 5
    db 0
    db 6
    db 1
JUSTADDCREAM_EFFECTBLOCK_P5P0P6P2 db 5
    db 0
    db 6
    db 2
JUSTADDCREAM_EFFECTBLOCK_P5P0P14P64P0 db 5
    db 0
    db 14
    db 64
    db 0
JUSTADDCREAM_EFFECTBLOCK_P20P0P1 db 20
    db 0
    db 1
JUSTADDCREAM_EFFECTBLOCK_P20P0P5 db 20
    db 0
    db 5
JUSTADDCREAM_EFFECTBLOCK_P10P0 db 10
    db 0
JUSTADDCREAM_EFFECTBLOCK_P5P0P18P128P1 db 5
    db 0
    db 18
    db 128
    db 1
JUSTADDCREAM_SUBSONG0_START db 2
    db 0
    db 1
    db 4
    db 27
    db 6
    db 9
JUSTADDCREAM_SUBSONG0_LINKER dw JUSTADDCREAM_SUBSONG0_TRACK17
    dw JUSTADDCREAM_SUBSONG0_TRACK22
    dw JUSTADDCREAM_SUBSONG0_TRACK0
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK18
    dw JUSTADDCREAM_SUBSONG0_TRACK21
    dw JUSTADDCREAM_SUBSONG0_TRACK0
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK2
    dw JUSTADDCREAM_SUBSONG0_TRACK19
    dw JUSTADDCREAM_SUBSONG0_TRACK20
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK2
    dw JUSTADDCREAM_SUBSONG0_TRACK0
    dw JUSTADDCREAM_SUBSONG0_TRACK29
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
JUSTADDCREAM_SUBSONG0_LINKER_LOOP dw JUSTADDCREAM_SUBSONG0_TRACK2
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK1
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK24
    dw JUSTADDCREAM_SUBSONG0_TRACK25
    dw JUSTADDCREAM_SUBSONG0_TRACK26
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK5
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK23
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK9
    dw JUSTADDCREAM_SUBSONG0_TRACK7
    dw JUSTADDCREAM_SUBSONG0_TRACK30
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK10
    dw JUSTADDCREAM_SUBSONG0_TRACK8
    dw JUSTADDCREAM_SUBSONG0_TRACK30
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK11
    dw JUSTADDCREAM_SUBSONG0_TRACK7
    dw JUSTADDCREAM_SUBSONG0_TRACK30
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK12
    dw JUSTADDCREAM_SUBSONG0_TRACK8
    dw JUSTADDCREAM_SUBSONG0_TRACK0
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK5
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK6
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK5
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK23
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK9
    dw JUSTADDCREAM_SUBSONG0_TRACK7
    dw JUSTADDCREAM_SUBSONG0_TRACK27
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK10
    dw JUSTADDCREAM_SUBSONG0_TRACK8
    dw JUSTADDCREAM_SUBSONG0_TRACK27
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK11
    dw JUSTADDCREAM_SUBSONG0_TRACK7
    dw JUSTADDCREAM_SUBSONG0_TRACK27
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK12
    dw JUSTADDCREAM_SUBSONG0_TRACK8
    dw JUSTADDCREAM_SUBSONG0_TRACK27
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK13
    dw JUSTADDCREAM_SUBSONG0_TRACK28
    dw JUSTADDCREAM_SUBSONG0_TRACK27
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK14
    dw JUSTADDCREAM_SUBSONG0_TRACK28
    dw JUSTADDCREAM_SUBSONG0_TRACK27
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK15
    dw JUSTADDCREAM_SUBSONG0_TRACK28
    dw JUSTADDCREAM_SUBSONG0_TRACK27
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK16
    dw JUSTADDCREAM_SUBSONG0_TRACK28
    dw JUSTADDCREAM_SUBSONG0_TRACK27
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK1
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK5
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK6
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK5
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    dw JUSTADDCREAM_SUBSONG0_TRACK4
    dw JUSTADDCREAM_SUBSONG0_TRACK3
    dw JUSTADDCREAM_SUBSONG0_TRACK23
    dw JUSTADDCREAM_SUBSONG0_LINKERBLOCK0
    db 0
    db 0
    dw JUSTADDCREAM_SUBSONG0_LINKER_LOOP
JUSTADDCREAM_SUBSONG0_LINKERBLOCK0 db 64
    db 0
    db 0
    db 0
    dw JUSTADDCREAM_SUBSONG0_SPEEDTRACK0
    dw JUSTADDCREAM_SUBSONG0_EVENTTRACK0
JUSTADDCREAM_SUBSONG0_LINKERBLOCK1 db 32
    db 0
    db 0
    db 0
    dw JUSTADDCREAM_SUBSONG0_SPEEDTRACK0
    dw JUSTADDCREAM_SUBSONG0_EVENTTRACK0
JUSTADDCREAM_SUBSONG0_TRACK0 db 128
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK1 db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 0
    db 126
    db 3
    db 60
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 22
    db 60
    db 67
    db 0
    db 126
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 0
    db 254
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 60
    db 67
    db 22
    db 60
    db 195
    db 2
    db 2
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK2 db 204
    db 3
    db 34
    db 62
    db 128
    db 0
    db 152
    db 3
    db 128
    db 0
    db 140
    db 3
    db 10
    db 12
    db 60
    db 15
    db 128
    db 0
    db 140
    db 3
    db 60
    db 17
    db 62
    db 128
    db 0
    db 133
    db 3
    db 128
    db 0
    db 145
    db 3
    db 60
    db 17
    db 15
    db 17
    db 60
    db 19
    db 60
    db 128
    db 0
    db 60
    db 148
    db 3
    db 62
    db 128
    db 0
    db 136
    db 3
    db 128
    db 0
    db 148
    db 3
    db 60
    db 20
    db 15
    db 20
    db 60
    db 22
    db 62
    db 128
    db 0
    db 143
    db 3
    db 60
    db 128
    db 0
    db 60
    db 138
    db 3
    db 128
    db 0
    db 143
    db 3
    db 60
    db 22
    db 10
    db 14
    db 60
    db 17
    db 128
    db 0
    db 142
    db 3
    db 60
    db 10
    db 128
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK3 db 231
    db 4
    db 8
    db 124
    db 1
    db 62
    db 103
    db 7
    db 60
    db 110
    db 13
    db 60
    db 103
    db 7
    db 60
    db 110
    db 17
    db 60
    db 103
    db 14
    db 60
    db 108
    db 0
    db 60
    db 124
    db 1
    db 108
    db 0
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 103
    db 9
    db 60
    db 108
    db 4
    db 60
    db 103
    db 9
    db 60
    db 110
    db 8
    db 103
    db 10
    db 108
    db 27
    db 60
    db 124
    db 1
    db 108
    db 0
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 46
    db 124
    db 1
    db 62
    db 108
    db 7
    db 126
    db 115
    db 29
    db 124
    db 1
    db 62
    db 115
    db 0
    db 126
    db 103
    db 10
    db 124
    db 1
    db 110
    db 8
    db 60
    db 103
    db 26
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK4 db 204
    db 5
    db 0
    db 62
    db 128
    db 0
    db 152
    db 6
    db 128
    db 0
    db 140
    db 3
    db 10
    db 140
    db 5
    db 60
    db 143
    db 3
    db 128
    db 0
    db 140
    db 6
    db 60
    db 145
    db 5
    db 62
    db 128
    db 0
    db 133
    db 5
    db 128
    db 0
    db 145
    db 6
    db 60
    db 145
    db 3
    db 15
    db 145
    db 5
    db 60
    db 147
    db 3
    db 60
    db 195
    db 2
    db 2
    db 60
    db 212
    db 5
    db 0
    db 60
    db 20
    db 128
    db 0
    db 136
    db 3
    db 128
    db 0
    db 148
    db 6
    db 60
    db 148
    db 3
    db 15
    db 148
    db 5
    db 60
    db 150
    db 3
    db 60
    db 195
    db 2
    db 2
    db 60
    db 207
    db 5
    db 0
    db 60
    db 128
    db 0
    db 60
    db 138
    db 3
    db 128
    db 0
    db 143
    db 6
    db 60
    db 150
    db 3
    db 10
    db 142
    db 5
    db 60
    db 17
    db 128
    db 0
    db 142
    db 6
    db 60
    db 138
    db 3
    db 128
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK5 db 246
    db 7
    db 18
    db 124
    db 24
    db 112
    db 12
    db 247
    db 8
    db 0
    db 181
    db 7
    db 60
    db 112
    db 15
    db 245
    db 8
    db 0
    db 179
    db 7
    db 60
    db 112
    db 15
    db 243
    db 8
    db 0
    db 243
    db 7
    db 15
    db 240
    db 8
    db 12
    db 242
    db 7
    db 21
    db 124
    db 25
    db 124
    db 16
    db 60
    db 117
    db 6
    db 124
    db 19
    db 243
    db 8
    db 5
    db 117
    db 6
    db 124
    db 19
    db 60
    db 235
    db 7
    db 3
    db 110
    db 3
    db 245
    db 8
    db 0
    db 107
    db 1
    db 238
    db 7
    db 3
    db 112
    db 3
    db 235
    db 8
    db 3
    db 110
    db 3
    db 236
    db 7
    db 5
    db 240
    db 8
    db 1
    db 235
    db 7
    db 20
    db 236
    db 8
    db 5
    db 172
    db 7
    db 235
    db 8
    db 6
    db 235
    db 7
    db 11
    db 236
    db 8
    db 5
    db 172
    db 7
    db 235
    db 8
    db 6
    db 235
    db 7
    db 11
    db 236
    db 8
    db 0
    db 231
    db 7
    db 1
    db 235
    db 8
    db 11
    db 230
    db 7
    db 36
    db 124
    db 39
    db 124
    db 16
    db 126
    db 124
    db 41
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK6 db 246
    db 7
    db 18
    db 124
    db 24
    db 112
    db 12
    db 247
    db 8
    db 0
    db 181
    db 7
    db 60
    db 112
    db 15
    db 245
    db 8
    db 0
    db 179
    db 7
    db 60
    db 112
    db 15
    db 243
    db 8
    db 0
    db 243
    db 7
    db 15
    db 240
    db 8
    db 12
    db 242
    db 7
    db 21
    db 124
    db 25
    db 124
    db 16
    db 60
    db 117
    db 6
    db 124
    db 19
    db 243
    db 8
    db 5
    db 117
    db 6
    db 124
    db 19
    db 60
    db 235
    db 7
    db 3
    db 110
    db 3
    db 245
    db 8
    db 0
    db 107
    db 1
    db 238
    db 7
    db 3
    db 112
    db 3
    db 235
    db 8
    db 3
    db 110
    db 3
    db 236
    db 7
    db 5
    db 240
    db 8
    db 1
    db 235
    db 7
    db 20
    db 236
    db 8
    db 5
    db 172
    db 7
    db 235
    db 8
    db 6
    db 235
    db 7
    db 11
    db 236
    db 8
    db 5
    db 172
    db 7
    db 235
    db 8
    db 6
    db 238
    db 7
    db 0
    db 124
    db 32
    db 60
    db 174
    db 8
    db 238
    db 7
    db 16
    db 62
    db 176
    db 8
    db 243
    db 7
    db 44
    db 238
    db 8
    db 16
    db 62
    db 241
    db 7
    db 31
    db 124
    db 30
    db 124
    db 16
    db 60
    db 112
    db 6
    db 242
    db 8
    db 5
    db 238
    db 7
    db 44
    db 240
    db 8
    db 43
    db 235
    db 7
    db 11
    db 238
    db 8
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK7 db 195
    db 1
    db 40
    db 126
    db 195
    db 2
    db 2
    db 62
    db 3
    db 195
    db 1
    db 0
    db 60
    db 3
    db 126
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 60
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 60
    db 3
    db 60
    db 195
    db 2
    db 2
    db 3
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK8 db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 62
    db 195
    db 1
    db 0
    db 3
    db 60
    db 3
    db 60
    db 3
    db 60
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 60
    db 195
    db 2
    db 2
    db 62
    db 3
    db 195
    db 1
    db 0
    db 195
    db 2
    db 2
    db 195
    db 1
    db 0
    db 60
    db 195
    db 2
    db 2
    db 62
    db 3
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK9 db 140
    db 3
    db 60
    db 128
    db 0
    db 190
    db 152
    db 3
    db 19
    db 128
    db 0
    db 150
    db 3
    db 128
    db 0
    db 62
    db 152
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 126
    db 138
    db 3
    db 60
    db 128
    db 0
    db 60
    db 139
    db 3
    db 60
    db 128
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK10 db 152
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 152
    db 3
    db 19
    db 128
    db 0
    db 150
    db 3
    db 60
    db 128
    db 0
    db 60
    db 152
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 126
    db 150
    db 3
    db 22
    db 128
    db 0
    db 60
    db 147
    db 3
    db 19
    db 128
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK11 db 140
    db 3
    db 60
    db 128
    db 0
    db 190
    db 152
    db 3
    db 19
    db 128
    db 0
    db 150
    db 3
    db 24
    db 128
    db 0
    db 60
    db 152
    db 3
    db 60
    db 128
    db 0
    db 152
    db 3
    db 12
    db 60
    db 128
    db 0
    db 126
    db 148
    db 3
    db 24
    db 27
    db 128
    db 0
    db 150
    db 3
    db 26
    db 29
    db 128
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK12 db 152
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 152
    db 3
    db 19
    db 128
    db 0
    db 150
    db 3
    db 60
    db 10
    db 128
    db 0
    db 152
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 62
    db 150
    db 3
    db 10
    db 60
    db 22
    db 60
    db 11
    db 60
    db 23
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK13 db 204
    db 5
    db 0
    db 60
    db 128
    db 0
    db 60
    db 195
    db 2
    db 2
    db 62
    db 216
    db 6
    db 0
    db 147
    db 5
    db 128
    db 0
    db 150
    db 5
    db 128
    db 0
    db 62
    db 152
    db 6
    db 60
    db 128
    db 0
    db 60
    db 140
    db 5
    db 60
    db 195
    db 2
    db 2
    db 126
    db 202
    db 5
    db 0
    db 60
    db 131
    db 1
    db 60
    db 139
    db 6
    db 11
    db 128
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK14 db 216
    db 5
    db 0
    db 60
    db 128
    db 0
    db 60
    db 140
    db 6
    db 60
    db 128
    db 0
    db 152
    db 5
    db 19
    db 128
    db 0
    db 150
    db 5
    db 60
    db 131
    db 1
    db 60
    db 152
    db 6
    db 60
    db 128
    db 0
    db 60
    db 140
    db 5
    db 60
    db 195
    db 2
    db 2
    db 62
    db 3
    db 214
    db 5
    db 0
    db 150
    db 6
    db 131
    db 1
    db 60
    db 147
    db 6
    db 147
    db 3
    db 128
    db 0
    db 195
    db 2
    db 2
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK15 db 204
    db 5
    db 0
    db 60
    db 128
    db 0
    db 60
    db 195
    db 2
    db 2
    db 62
    db 216
    db 6
    db 0
    db 147
    db 5
    db 128
    db 0
    db 150
    db 5
    db 152
    db 3
    db 128
    db 0
    db 60
    db 152
    db 6
    db 60
    db 128
    db 0
    db 152
    db 3
    db 140
    db 5
    db 60
    db 195
    db 2
    db 2
    db 126
    db 212
    db 5
    db 0
    db 152
    db 3
    db 155
    db 5
    db 128
    db 0
    db 150
    db 6
    db 26
    db 157
    db 3
    db 128
    db 0
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK16 db 216
    db 5
    db 0
    db 60
    db 128
    db 0
    db 60
    db 140
    db 6
    db 60
    db 128
    db 0
    db 152
    db 5
    db 19
    db 128
    db 0
    db 150
    db 5
    db 60
    db 10
    db 128
    db 0
    db 152
    db 6
    db 60
    db 128
    db 0
    db 60
    db 140
    db 5
    db 60
    db 195
    db 2
    db 2
    db 62
    db 214
    db 6
    db 0
    db 138
    db 5
    db 195
    db 2
    db 2
    db 214
    db 5
    db 0
    db 60
    db 139
    db 6
    db 60
    db 151
    db 3
    db 195
    db 2
    db 2
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK17 db 128
    db 0
    db 61
    db 14
    db 140
    db 3
    db 60
    db 128
    db 0
    db 61
    db 12
    db 140
    db 3
    db 60
    db 128
    db 0
    db 61
    db 12
    db 140
    db 3
    db 60
    db 128
    db 0
    db 61
    db 10
    db 138
    db 3
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK18 db 204
    db 3
    db 0
    db 60
    db 128
    db 0
    db 254
    db 140
    db 3
    db 60
    db 128
    db 0
    db 254
    db 140
    db 3
    db 60
    db 128
    db 0
    db 254
    db 140
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 60
    db 140
    db 3
    db 60
    db 128
    db 0
    db 60
    db 143
    db 3
    db 62
    db 124
    db 23
    db 62
    db 128
    db 0
    db 60
    db 205
    db 3
    db 35
    db 124
    db 38
    db 62
    db 124
    db 23
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK19 db 124
    db 42
    db 61
    db 22
    db 124
    db 45
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK20 db 128
    db 0
    db 61
    db 52
    db 195
    db 1
    db 0
    db 60
    db 195
    db 2
    db 2
    db 126
    db 3
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK21 db 231
    db 4
    db 8
    db 124
    db 1
    db 62
    db 103
    db 7
    db 60
    db 110
    db 13
    db 60
    db 103
    db 7
    db 60
    db 110
    db 17
    db 60
    db 103
    db 14
    db 60
    db 108
    db 0
    db 60
    db 124
    db 1
    db 108
    db 0
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 103
    db 9
    db 60
    db 108
    db 4
    db 60
    db 103
    db 9
    db 60
    db 110
    db 8
    db 103
    db 10
    db 108
    db 27
    db 60
    db 124
    db 1
    db 108
    db 0
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 46
    db 124
    db 1
    db 62
    db 108
    db 7
    db 126
    db 115
    db 29
    db 124
    db 1
    db 62
    db 115
    db 0
    db 126
    db 103
    db 10
    db 124
    db 1
    db 110
    db 8
    db 60
    db 103
    db 27
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK22 db 231
    db 4
    db 28
    db 126
    db 103
    db 0
    db 60
    db 110
    db 13
    db 60
    db 103
    db 7
    db 60
    db 110
    db 17
    db 60
    db 103
    db 14
    db 60
    db 108
    db 0
    db 60
    db 124
    db 1
    db 108
    db 0
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 103
    db 9
    db 60
    db 108
    db 4
    db 60
    db 103
    db 9
    db 60
    db 110
    db 8
    db 103
    db 10
    db 108
    db 27
    db 60
    db 124
    db 1
    db 108
    db 0
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 46
    db 124
    db 1
    db 62
    db 108
    db 7
    db 126
    db 115
    db 29
    db 124
    db 1
    db 62
    db 115
    db 0
    db 126
    db 103
    db 10
    db 124
    db 1
    db 110
    db 8
    db 60
    db 103
    db 26
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK23 db 246
    db 7
    db 18
    db 124
    db 24
    db 112
    db 12
    db 247
    db 8
    db 0
    db 181
    db 7
    db 60
    db 112
    db 15
    db 245
    db 8
    db 0
    db 179
    db 7
    db 60
    db 112
    db 15
    db 243
    db 8
    db 0
    db 243
    db 7
    db 15
    db 240
    db 8
    db 12
    db 242
    db 7
    db 21
    db 124
    db 25
    db 124
    db 16
    db 60
    db 117
    db 6
    db 124
    db 19
    db 243
    db 8
    db 5
    db 117
    db 6
    db 124
    db 19
    db 60
    db 235
    db 7
    db 3
    db 110
    db 3
    db 245
    db 8
    db 0
    db 107
    db 1
    db 238
    db 7
    db 3
    db 112
    db 3
    db 235
    db 8
    db 3
    db 110
    db 3
    db 236
    db 7
    db 5
    db 240
    db 8
    db 1
    db 235
    db 7
    db 20
    db 236
    db 8
    db 5
    db 172
    db 7
    db 235
    db 8
    db 6
    db 235
    db 7
    db 11
    db 236
    db 8
    db 5
    db 172
    db 7
    db 235
    db 8
    db 6
    db 238
    db 7
    db 0
    db 124
    db 32
    db 60
    db 174
    db 8
    db 238
    db 7
    db 16
    db 62
    db 176
    db 8
    db 243
    db 7
    db 44
    db 238
    db 8
    db 16
    db 62
    db 241
    db 7
    db 31
    db 124
    db 30
    db 124
    db 16
    db 60
    db 112
    db 6
    db 242
    db 8
    db 5
    db 174
    db 7
    db 60
    db 124
    db 33
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK24 db 204
    db 3
    db 34
    db 62
    db 128
    db 0
    db 152
    db 3
    db 128
    db 0
    db 140
    db 3
    db 10
    db 12
    db 60
    db 15
    db 128
    db 0
    db 140
    db 3
    db 60
    db 17
    db 62
    db 128
    db 0
    db 133
    db 3
    db 128
    db 0
    db 145
    db 3
    db 60
    db 17
    db 15
    db 17
    db 60
    db 19
    db 60
    db 128
    db 0
    db 60
    db 148
    db 3
    db 62
    db 128
    db 0
    db 136
    db 3
    db 128
    db 0
    db 148
    db 3
    db 60
    db 20
    db 15
    db 20
    db 60
    db 22
    db 62
    db 128
    db 0
    db 143
    db 3
    db 126
    db 15
    db 60
    db 128
    db 0
    db 61
    db 5
    db 152
    db 3
    db 12
    db 60
    db 10
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK25 db 231
    db 4
    db 8
    db 124
    db 1
    db 62
    db 103
    db 7
    db 60
    db 110
    db 13
    db 60
    db 103
    db 7
    db 60
    db 110
    db 17
    db 60
    db 103
    db 14
    db 60
    db 108
    db 0
    db 60
    db 124
    db 1
    db 108
    db 0
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 103
    db 9
    db 60
    db 108
    db 4
    db 60
    db 103
    db 9
    db 60
    db 110
    db 8
    db 103
    db 10
    db 108
    db 27
    db 60
    db 124
    db 1
    db 108
    db 0
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 103
    db 10
    db 124
    db 1
    db 108
    db 4
    db 60
    db 46
    db 124
    db 1
    db 62
    db 108
    db 7
    db 126
    db 115
    db 29
    db 124
    db 1
    db 62
    db 115
    db 47
    db 124
    db 1
    db 115
    db 46
    db 60
    db 115
    db 37
    db 124
    db 1
    db 115
    db 22
    db 60
    db 115
    db 0
    db 124
    db 1
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK26 db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 0
    db 126
    db 3
    db 60
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 22
    db 60
    db 67
    db 0
    db 126
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 0
    db 126
    db 3
    db 61
    db 8
    db 195
    db 2
    db 22
    db 60
    db 67
    db 2
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK27 db 171
    db 11
    db 48
    db 243
    db 9
    db 0
    db 50
    db 179
    db 10
    db 174
    db 9
    db 178
    db 10
    db 179
    db 11
    db 179
    db 9
    db 50
    db 179
    db 11
    db 174
    db 9
    db 178
    db 10
    db 179
    db 11
    db 174
    db 10
    db 178
    db 11
    db 51
    db 46
    db 171
    db 9
    db 46
    db 174
    db 11
    db 176
    db 9
    db 174
    db 10
    db 43
    db 171
    db 9
    db 46
    db 171
    db 10
    db 176
    db 9
    db 174
    db 10
    db 171
    db 11
    db 176
    db 10
    db 174
    db 11
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK28 db 174
    db 11
    db 51
    db 247
    db 9
    db 0
    db 53
    db 183
    db 10
    db 178
    db 9
    db 181
    db 10
    db 183
    db 11
    db 183
    db 9
    db 53
    db 183
    db 11
    db 178
    db 9
    db 181
    db 10
    db 183
    db 11
    db 178
    db 10
    db 181
    db 11
    db 55
    db 50
    db 174
    db 9
    db 50
    db 178
    db 11
    db 179
    db 9
    db 178
    db 10
    db 46
    db 174
    db 9
    db 50
    db 174
    db 11
    db 179
    db 9
    db 178
    db 10
    db 174
    db 11
    db 179
    db 10
    db 178
    db 11
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK29 db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 0
    db 126
    db 3
    db 60
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 22
    db 60
    db 67
    db 0
    db 126
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 126
    db 195
    db 2
    db 2
    db 60
    db 195
    db 1
    db 0
    db 254
    db 195
    db 2
    db 2
    db 126
    db 195
    db 1
    db 0
    db 60
    db 67
    db 22
    db 60
    db 195
    db 2
    db 2
    db 60
    db 67
    db 37
    db 67
    db 2
    db 61
    db 127
JUSTADDCREAM_SUBSONG0_TRACK30 db 61
    db 127
JUSTADDCREAM_SUBSONG0_SPEEDTRACK0 db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 14
    db 10
    db 127
JUSTADDCREAM_SUBSONG0_EVENTTRACK0 db 255
PLY_AKG_START jp PLY_AKG_INIT
    jp PLY_AKG_PLAY
    jp PLY_AKG_INITTABLEJP_END
PLY_AKG_INITSOUNDEFFECTS ld (PLY_AKG_PTSOUNDEFFECTTABLE),hl
    ret 
PLY_AKG_PLAYSOUNDEFFECT dec a
    ld hl,(PLY_AKG_PTSOUNDEFFECTTABLE)
    ld e,a
    ld d,0
    add hl,de
    add hl,de
    ld e,(hl)
    inc hl
    ld d,(hl)
    ld a,(de)
    inc de
    ex af,af'
    ld a,b
    ld hl,PLY_AKG_CHANNEL1_SOUNDEFFECTDATA
    ld b,0
    sla c
    sla c
    sla c
    add hl,bc
    ld (hl),e
    inc hl
    ld (hl),d
    inc hl
    ld (hl),a
    inc hl
    ld (hl),0
    inc hl
    ex af,af'
    ld (hl),a
    ret 
PLY_AKG_STOPSOUNDEFFECTFROMCHANNEL add a,a
    add a,a
    add a,a
    ld e,a
    ld d,0
    ld hl,PLY_AKG_CHANNEL1_SOUNDEFFECTDATA
    add hl,de
    ld (hl),d
    inc hl
    ld (hl),d
    ret 
PLY_AKG_PLAYSOUNDEFFECTSSTREAM rla 
    rla 
    ld ix,PLY_AKG_CHANNEL1_SOUNDEFFECTDATA
    ld iy,PLY_AKG_PSGREG8
    ld hl,PLY_AKG_PSGREG01_INSTR
    exx
    ld c,a
    call PLY_AKG_PSES_PLAY
    ld ix,PLY_AKG_CHANNEL2_SOUNDEFFECTDATA
    ld iy,PLY_AKG_PSGREG9_10_INSTR
    exx
    ld hl,PLY_AKG_PSGREG23_INSTR
    exx
    srl c
    call PLY_AKG_PSES_PLAY
    ld ix,PLY_AKG_CHANNEL3_SOUNDEFFECTDATA
    ld iy,PLY_AKG_PSGREG10
    exx
    ld hl,PLY_AKG_PSGREG45_INSTR
    exx
    scf
    rr c
    call PLY_AKG_PSES_PLAY
    ld a,c
    ret 
PLY_AKG_PSES_PLAY ld l,(ix+0)
    ld h,(ix+1)
    ld a,l
    or h
    ret z
PLY_AKG_PSES_READFIRSTBYTE ld a,(hl)
    inc hl
    ld b,a
    rra 
    jr c,PLY_AKG_PSES_SOFTWAREORSOFTWAREANDHARDWARE
    rra 
    jr c,PLY_AKG_PSES_HARDWAREONLY
    rra 
    jr c,PLY_AKG_PSES_S_ENDORLOOP
    call PLY_AKG_PSES_MANAGEVOLUMEFROMA_FILTER4BITS
    rl b
    call PLY_AKG_PSES_READNOISEIFNEEDEDANDOPENORCLOSENOISECHANNEL
    set 2,c
    jr PLY_AKG_PSES_SAVEPOINTERANDEXIT
PLY_AKG_PSES_S_ENDORLOOP rra 
    jr c,PLY_AKG_PSES_S_LOOP
    xor a
    ld (ix+0),a
    ld (ix+1),a
    ret 
PLY_AKG_PSES_S_LOOP ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    jr PLY_AKG_PSES_READFIRSTBYTE
PLY_AKG_PSES_SAVEPOINTERANDEXIT ld a,(ix+3)
    cp (ix+4)
    jr c,PLY_AKG_PSES_NOTREACHED
    ld (ix+3),0
    ld (ix+0),l
    ld (ix+1),h
    ret 
PLY_AKG_PSES_NOTREACHED inc (ix+3)
    ret 
PLY_AKG_PSES_HARDWAREONLY call PLY_AKG_PSES_SHARED_READRETRIGHARDWAREENVPERIODNOISE
    set 2,c
    jr PLY_AKG_PSES_SAVEPOINTERANDEXIT
PLY_AKG_PSES_SOFTWAREORSOFTWAREANDHARDWARE rra 
    jr c,PLY_AKG_PSES_SOFTWAREANDHARDWARE
    call PLY_AKG_PSES_MANAGEVOLUMEFROMA_FILTER4BITS
    rl b
    call PLY_AKG_PSES_READNOISEIFNEEDEDANDOPENORCLOSENOISECHANNEL
    res 2,c
    call PLY_AKG_PSES_READSOFTWAREPERIOD
    jr PLY_AKG_PSES_SAVEPOINTERANDEXIT
PLY_AKG_PSES_SOFTWAREANDHARDWARE call PLY_AKG_PSES_SHARED_READRETRIGHARDWAREENVPERIODNOISE
    call PLY_AKG_PSES_READSOFTWAREPERIOD
    res 2,c
    jr PLY_AKG_PSES_SAVEPOINTERANDEXIT
PLY_AKG_PSES_SHARED_READRETRIGHARDWAREENVPERIODNOISE rra 
    jr nc,PLY_AKG_PSES_H_AFTERRETRIG
    ld d,a
    ld a,255
    ld (PLY_AKG_PSGREG13_OLDVALUE),a
    ld a,d
PLY_AKG_PSES_H_AFTERRETRIG and 7
    add a,8
    ld (PLY_AKG_PSGREG13_INSTR),a
    rl b
    call PLY_AKG_PSES_READNOISEIFNEEDEDANDOPENORCLOSENOISECHANNEL
    call PLY_AKG_PSES_READHARDWAREPERIOD
    ld a,16
    jp PLY_AKG_PSES_MANAGEVOLUMEFROMA_HARD
PLY_AKG_PSES_READNOISEIFNEEDEDANDOPENORCLOSENOISECHANNEL jr c,PLY_AKG_PSES_READNOISEANDOPENNOISECHANNEL_OPENNOISE
    set 5,c
    ret 
PLY_AKG_PSES_READNOISEANDOPENNOISECHANNEL_OPENNOISE ld a,(hl)
    ld (PLY_AKG_PSGREG6_8_INSTR),a
    inc hl
    res 5,c
    ret 
PLY_AKG_PSES_READHARDWAREPERIOD ld a,(hl)
    ld (PLY_AKG_PSGHARDWAREPERIOD_INSTR),a
    inc hl
    ld a,(hl)
    ld (PLY_AKG_PSGHARDWAREPERIOD_INSTR+1),a
    inc hl
    ret 
PLY_AKG_PSES_READSOFTWAREPERIOD ld a,(hl)
    inc hl
    exx
    ld (hl),a
    inc hl
    exx
    ld a,(hl)
    inc hl
    exx
    ld (hl),a
    exx
    ret 
PLY_AKG_PSES_MANAGEVOLUMEFROMA_FILTER4BITS and 15
PLY_AKG_PSES_MANAGEVOLUMEFROMA_HARD sub (ix+2)
    jr nc,PLY_AKG_PSES_MVFA_NOOVERFLOW
    xor a
PLY_AKG_PSES_MVFA_NOOVERFLOW ld (iy+0),a
    ret 
PLY_AKG_INIT ld de,4
    add hl,de
    ld de,PLY_AKG_ARPEGGIOSTABLE
    ldi
    ldi
    ld de,PLY_AKG_PITCHESTABLE
    ldi
    ldi
    ld de,PLY_AKG_INSTRUMENTSTABLE
    ldi
    ldi
    ld c,(hl)
    inc hl
    ld b,(hl)
    inc hl
    ld (PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS1),bc
    add a,a
    ld e,a
    ld d,0
    add hl,de
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    ld de,5
    add hl,de
    ld de,PLY_AKG_CURRENTSPEED
    ldi
    ld de,PLY_AKG_BASENOTEINDEX
    ldi
    ld (PLY_AKG_READLINKER_PTLINKER),hl
    ld hl,PLY_AKG_INITTABLE0
    ld bc,3328
    call PLY_AKG_INIT_READWORDSANDFILL
    inc c
    ld hl,PLY_AKG_INITTABLE0_END
    ld b,3
    call PLY_AKG_INIT_READWORDSANDFILL
    ld hl,PLY_AKG_INITTABLE1_END
    ld bc,3328
    call PLY_AKG_INIT_READWORDSANDFILL
    ld hl,PLY_AKG_INITTABLEORA_END
    ld bc,3267
    call PLY_AKG_INIT_READWORDSANDFILL
    ld hl,(PLY_AKG_INSTRUMENTSTABLE)
    ld e,(hl)
    inc hl
    ld d,(hl)
    ex de,hl
    inc hl
    ld (PLY_AKG_EMPTYINSTRUMENTDATAPT),hl
    ld (PLY_AKG_CHANNEL1_PTINSTRUMENT),hl
    ld (PLY_AKG_CHANNEL2_PTINSTRUMENT),hl
    ld (PLY_AKG_CHANNEL3_PTINSTRUMENT),hl
    xor a
    ld (PLY_AKG_CHANNEL1_PITCHTRACK+1),a
    ld hl,PLY_AKG_CHANNEL1_PITCHTRACKINTEGERADDORSUBRETURN
    ld (PLY_AKG_CHANNEL1_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS+1),hl
    ld hl,PLY_AKG_CHANNEL1_PITCHTRACKADDORSBC_16BITSRETURN
    ld (PLY_AKG_CHANNEL1_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS+1),hl
    ld hl,PLY_AKG_CHANNEL1_PITCHTRACKDECIMALINSTRANDVALUERETURNAFTERJP
    ld (PLY_AKG_CHANNEL1_PITCHTRACKDECIMALINSTRANDVALUERETURNJP+1),hl
    ld (PLY_AKG_CHANNEL2_PITCHTRACK+1),a
    ld hl,PLY_AKG_CHANNEL2_PITCHTRACKINTEGERADDORSUBRETURN
    ld (PLY_AKG_CHANNEL2_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS+1),hl
    ld hl,PLY_AKG_CHANNEL2_PITCHTRACKADDORSBC_16BITSRETURN
    ld (PLY_AKG_CHANNEL2_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS+1),hl
    ld hl,PLY_AKG_CHANNEL2_PITCHTRACKDECIMALINSTRANDVALUERETURNAFTERJP
    ld (PLY_AKG_CHANNEL2_PITCHTRACKDECIMALINSTRANDVALUERETURNJP+1),hl
    ld (PLY_AKG_CHANNEL3_PITCHTRACK+1),a
    ld hl,PLY_AKG_CHANNEL3_PITCHTRACKINTEGERADDORSUBRETURN
    ld (PLY_AKG_CHANNEL3_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS+1),hl
    ld hl,PLY_AKG_CHANNEL3_PITCHTRACKADDORSBC_16BITSRETURN
    ld (PLY_AKG_CHANNEL3_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS+1),hl
    ld hl,PLY_AKG_CHANNEL3_PITCHTRACKDECIMALINSTRANDVALUERETURNAFTERJP
    ld (PLY_AKG_CHANNEL3_PITCHTRACKDECIMALINSTRANDVALUERETURNJP+1),hl
    ld hl,0
    ld (PLY_AKG_CHANNEL1_SOUNDEFFECTDATA),hl
    ld (PLY_AKG_CHANNEL2_SOUNDEFFECTDATA),hl
    ld (PLY_AKG_CHANNEL3_SOUNDEFFECTDATA),hl
    ret 
PLY_AKG_INIT_READWORDSANDFILL_LOOP ld e,(hl)
    inc hl
    ld d,(hl)
    inc hl
    ld a,c
    ld (de),a
PLY_AKG_INIT_READWORDSANDFILL djnz PLY_AKG_INIT_READWORDSANDFILL_LOOP
    ret 
PLY_AKG_INITTABLE0 dw PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL
    dw PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGER
    dw PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL
    dw PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGER
    dw PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL
    dw PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGER
    dw PLY_AKG_CHANNEL1_PITCH
    dw PLY_AKG_CHANNEL1_PITCH+1
    dw PLY_AKG_CHANNEL2_PITCH
    dw PLY_AKG_CHANNEL2_PITCH+1
    dw PLY_AKG_CHANNEL3_PITCH
    dw PLY_AKG_CHANNEL3_PITCH+1
PLY_AKG_INITTABLE0_END
PLY_AKG_INITTABLE1 dw PLY_AKG_PATTERNDECREASINGHEIGHT
    dw PLY_AKG_TICKDECREASINGCOUNTER
PLY_AKG_INITTABLE1_END
PLY_AKG_INITTABLEORA dw PLY_AKG_CHANNEL1_ISVOLUMESLIDE
    dw PLY_AKG_CHANNEL2_ISVOLUMESLIDE
    dw PLY_AKG_CHANNEL3_ISVOLUMESLIDE
    dw PLY_AKG_CHANNEL1_ISARPEGGIOTABLE
    dw PLY_AKG_CHANNEL2_ISARPEGGIOTABLE
    dw PLY_AKG_CHANNEL3_ISARPEGGIOTABLE
    dw PLY_AKG_CHANNEL1_ISPITCHTABLE
    dw PLY_AKG_CHANNEL2_ISPITCHTABLE
    dw PLY_AKG_CHANNEL3_ISPITCHTABLE
    dw PLY_AKG_CHANNEL1_ISPITCH
    dw PLY_AKG_CHANNEL2_ISPITCH
    dw PLY_AKG_CHANNEL3_ISPITCH
PLY_AKG_INITTABLEORA_END
PLY_AKG_INITTABLEJP dw PLY_AKG_CHANNEL1_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS
    dw PLY_AKG_CHANNEL2_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS
    dw PLY_AKG_CHANNEL3_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS
    dw PLY_AKG_CHANNEL1_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS
    dw PLY_AKG_CHANNEL2_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS
    dw PLY_AKG_CHANNEL3_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS
    dw PLY_AKG_CHANNEL1_PITCHTRACKDECIMALINSTRANDVALUERETURNJP
    dw PLY_AKG_CHANNEL2_PITCHTRACKDECIMALINSTRANDVALUERETURNJP
    dw PLY_AKG_CHANNEL3_PITCHTRACKDECIMALINSTRANDVALUERETURNJP
    dw PLY_AKG_CHANNEL_READEFFECTS_ENDJUMPINSTRANDADDRESS
    dw PLY_AKG_TEMPPLAYINSTRUMENTJUMPINSTRANDADDRESS
PLY_AKG_INITTABLEJP_END
PLY_AKG_STOP ld (PLY_AKG_SAVESP),sp
    xor a
    ld l,a
    ld h,a
    ld (PLY_AKG_PSGREG8),a
    ld (PLY_AKG_PSGREG9_10_INSTR),hl
    ld a,191
    jp PLY_AKG_SENDPSGREGISTERS
PLY_AKG_PLAY ld (PLY_AKG_SAVESP),sp
    ld a,(PLY_AKG_TICKDECREASINGCOUNTER)
    dec a
    jp nz,PLY_AKG_SETSPEEDBEFOREPLAYSTREAMS
    ld a,(PLY_AKG_PATTERNDECREASINGHEIGHT)
    dec a
    jr nz,PLY_AKG_SETCURRENTLINEBEFOREREADLINE
PLY_AKG_READLINKER ld sp,(PLY_AKG_READLINKER_PTLINKER)
    pop hl
    ld a,l
    or h
    jr nz,PLY_AKG_READLINKER_NOLOOP
    pop hl
    ld sp,hl
    pop hl
PLY_AKG_READLINKER_NOLOOP ld (PLY_AKG_CHANNEL1_PTTRACK),hl
    pop hl
    ld (PLY_AKG_CHANNEL2_PTTRACK),hl
    pop hl
    ld (PLY_AKG_CHANNEL3_PTTRACK),hl
    pop hl
    ld (PLY_AKG_READLINKER_PTLINKER),sp
    ld sp,hl
    pop hl
    ld c,l
    pop hl
    pop hl
    ld (PLY_AKG_SPEEDTRACK_PTTRACK),hl
    xor a
    ld (PLY_AKG_SPEEDTRACK_WAITCOUNTER),a
    ld (PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS),a
    ld (PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS),a
    ld (PLY_AKG_CHANNEL3_WAITCOUNTER),a
    ld a,c
PLY_AKG_SETCURRENTLINEBEFOREREADLINE ld (PLY_AKG_PATTERNDECREASINGHEIGHT),a
PLY_AKG_READLINE ld a,(PLY_AKG_SPEEDTRACK_WAITCOUNTER)
    sub 1
    jr nc,PLY_AKG_SPEEDTRACK_MUSTWAIT
    ld hl,(PLY_AKG_SPEEDTRACK_PTTRACK)
    ld a,(hl)
    inc hl
    srl a
    jr c,PLY_AKG_SPEEDTRACK_STOREPOINTERANDWAITCOUNTER
    jr nz,PLY_AKG_SPEEDTRACK_NORMALVALUE
    ld a,(hl)
    inc hl
PLY_AKG_SPEEDTRACK_NORMALVALUE ld (PLY_AKG_CURRENTSPEED),a
    xor a
PLY_AKG_SPEEDTRACK_STOREPOINTERANDWAITCOUNTER ld (PLY_AKG_SPEEDTRACK_PTTRACK),hl
PLY_AKG_SPEEDTRACK_MUSTWAIT ld (PLY_AKG_SPEEDTRACK_WAITCOUNTER),a
PLY_AKG_SPEEDTRACK_END ld a,(PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS)
    sub 1
    jr c,PLY_AKG_CHANNEL1_READTRACK
    ld (PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS),a
    jp PLY_AKG_CHANNEL1_READCELLEND
PLY_AKG_CHANNEL1_READTRACK ld hl,(PLY_AKG_CHANNEL1_PTTRACK)
    ld c,(hl)
    inc hl
    ld a,c
    and 63
    cp 60
    jr c,PLY_AKG_CHANNEL1_NOTE
    sub 60
    jp z,PLY_AKG_CHANNEL1_MAYBEEFFECTS
    dec a
    jr z,PLY_AKG_CHANNEL1_WAIT
    dec a
    jr z,PLY_AKG_CHANNEL1_SMALLWAIT
    ld a,(hl)
    inc hl
    jr PLY_AKG_CHANNEL1_AFTERNOTEKNOWN
PLY_AKG_CHANNEL1_SMALLWAIT ld a,c
    rlca 
    rlca 
    and 3
    inc a
    ld (PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS),a
    jr PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL1_WAIT ld a,(hl)
    ld (PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS),a
    inc hl
    jr PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL1_SAMEINSTRUMENT ld de,(PLY_AKG_CHANNEL1_PTBASEINSTRUMENT)
    ld (PLY_AKG_CHANNEL1_PTINSTRUMENT),de
    jr PLY_AKG_CHANNEL1_AFTERINSTRUMENT
PLY_AKG_CHANNEL1_NOTE ld b,a
    ld a,(PLY_AKG_BASENOTEINDEX)
    add a,b
PLY_AKG_CHANNEL1_AFTERNOTEKNOWN ld (PLY_AKG_CHANNEL1_TRACKNOTE),a
    rl c
    jr nc,PLY_AKG_CHANNEL1_SAMEINSTRUMENT
    ld a,(hl)
    inc hl
    exx
    ld l,a
    ld h,0
    add hl,hl
    ld de,(PLY_AKG_INSTRUMENTSTABLE)
    add hl,de
    ld sp,hl
    pop hl
    ld a,(hl)
    inc hl
    ld (PLY_AKG_CHANNEL1_INSTRUMENTSPEED),a
    ld (PLY_AKG_CHANNEL1_PTINSTRUMENT),hl
    ld (PLY_AKG_CHANNEL1_PTBASEINSTRUMENT),hl
    exx
PLY_AKG_CHANNEL1_AFTERINSTRUMENT ex de,hl
    xor a
    ld l,a
    ld h,a
    ld (PLY_AKG_CHANNEL1_PITCH),hl
    ld (PLY_AKG_CHANNEL1_ARPEGGIOTABLECURRENTSTEP),a
    ld (PLY_AKG_CHANNEL1_PITCHTABLECURRENTSTEP),a
    ld (PLY_AKG_CHANNEL1_INSTRUMENTSTEP),a
    ld a,0
    ld (PLY_AKG_CHANNEL1_ISPITCH),a
    ld a,(PLY_AKG_CHANNEL1_ARPEGGIOBASESPEED)
    ld (PLY_AKG_CHANNEL1_ARPEGGIOTABLESPEED),a
    ld a,(PLY_AKG_CHANNEL1_PITCHBASESPEED)
    ld (PLY_AKG_CHANNEL1_PITCHTABLESPEED),a
    ld hl,(PLY_AKG_CHANNEL1_ARPEGGIOTABLEBASE)
    ld (PLY_AKG_CHANNEL1_ARPEGGIOTABLE),hl
    ld hl,(PLY_AKG_CHANNEL1_PITCHTABLEBASE)
    ld (PLY_AKG_CHANNEL1_PITCHTABLE),hl
    ex de,hl
    rl c
    jp c,PLY_AKG_CHANNEL1_READEFFECTS
PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER ld (PLY_AKG_CHANNEL1_PTTRACK),hl
PLY_AKG_CHANNEL1_READCELLEND ld a,(PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS)
    sub 1
    jr c,PLY_AKG_CHANNEL2_READTRACK
    ld (PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS),a
    jp PLY_AKG_CHANNEL2_READCELLEND
PLY_AKG_CHANNEL2_READTRACK ld hl,(PLY_AKG_CHANNEL2_PTTRACK)
    ld c,(hl)
    inc hl
    ld a,c
    and 63
    cp 60
    jr c,PLY_AKG_CHANNEL2_NOTE
    sub 60
    jp z,PLY_AKG_CHANNEL1_READEFFECTSEND
    dec a
    jr z,PLY_AKG_CHANNEL2_WAIT
    dec a
    jr z,PLY_AKG_CHANNEL2_SMALLWAIT
    ld a,(hl)
    inc hl
    jr PLY_AKG_CHANNEL2_AFTERNOTEKNOWN
PLY_AKG_CHANNEL2_SMALLWAIT ld a,c
    rlca 
    rlca 
    and 3
    inc a
    ld (PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS),a
    jr PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL2_WAIT ld a,(hl)
    ld (PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS),a
    inc hl
    jr PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL2_SAMEINSTRUMENT ld de,(PLY_AKG_CHANNEL2_PTBASEINSTRUMENT)
    ld (PLY_AKG_CHANNEL2_PTINSTRUMENT),de
    jr PLY_AKG_CHANNEL2_AFTERINSTRUMENT
PLY_AKG_CHANNEL2_NOTE ld b,a
    ld a,(PLY_AKG_BASENOTEINDEX)
    add a,b
PLY_AKG_CHANNEL2_AFTERNOTEKNOWN ld (PLY_AKG_CHANNEL2_TRACKNOTE),a
    rl c
    jr nc,PLY_AKG_CHANNEL2_SAMEINSTRUMENT
    ld a,(hl)
    inc hl
    exx
    ld e,a
    ld d,0
    ld hl,(PLY_AKG_INSTRUMENTSTABLE)
    add hl,de
    add hl,de
    ld sp,hl
    pop hl
    ld a,(hl)
    inc hl
    ld (PLY_AKG_CHANNEL2_INSTRUMENTSPEED),a
    ld (PLY_AKG_CHANNEL2_PTINSTRUMENT),hl
    ld (PLY_AKG_CHANNEL2_PTBASEINSTRUMENT),hl
    exx
PLY_AKG_CHANNEL2_AFTERINSTRUMENT ex de,hl
    xor a
    ld l,a
    ld h,a
    ld (PLY_AKG_CHANNEL2_PITCH),hl
    ld (PLY_AKG_CHANNEL2_ARPEGGIOTABLECURRENTSTEP),a
    ld (PLY_AKG_CHANNEL2_PITCHTABLECURRENTSTEP),a
    ld (PLY_AKG_CHANNEL2_INSTRUMENTSTEP),a
    ld a,0
    ld (PLY_AKG_CHANNEL2_ISPITCH),a
    ld a,(PLY_AKG_CHANNEL2_ARPEGGIOBASESPEED)
    ld (PLY_AKG_CHANNEL2_ARPEGGIOTABLESPEED),a
    ld a,(PLY_AKG_CHANNEL2_PITCHBASESPEED)
    ld (PLY_AKG_CHANNEL2_PITCHTABLESPEED),a
    ld hl,(PLY_AKG_CHANNEL2_ARPEGGIOTABLEBASE)
    ld (PLY_AKG_CHANNEL2_ARPEGGIOTABLE),hl
    ld hl,(PLY_AKG_CHANNEL2_PITCHTABLEBASE)
    ld (PLY_AKG_CHANNEL2_PITCHTABLE),hl
    ex de,hl
    rl c
    jp c,PLY_AKG_CHANNEL2_READEFFECTS
PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER ld (PLY_AKG_CHANNEL2_PTTRACK),hl
PLY_AKG_CHANNEL2_READCELLEND ld a,(PLY_AKG_CHANNEL3_WAITCOUNTER)
    sub 1
    jr c,PLY_AKG_CHANNEL3_READTRACK
    ld (PLY_AKG_CHANNEL3_WAITCOUNTER),a
    jp PLY_AKG_CHANNEL3_READCELLEND
PLY_AKG_CHANNEL3_READTRACK ld hl,(PLY_AKG_CHANNEL3_PTTRACK)
    ld c,(hl)
    inc hl
    ld a,c
    and 63
    cp 60
    jr c,PLY_AKG_CHANNEL3_NOTE
    sub 60
    jp z,PLY_AKG_CHANNEL2_READEFFECTSEND
    dec a
    jr z,PLY_AKG_CHANNEL3_WAIT
    dec a
    jr z,PLY_AKG_CHANNEL3_SMALLWAIT
    ld a,(hl)
    inc hl
    jr PLY_AKG_CHANNEL3_AFTERNOTEKNOWN
PLY_AKG_CHANNEL3_SMALLWAIT ld a,c
    rlca 
    rlca 
    and 3
    inc a
    ld (PLY_AKG_CHANNEL3_WAITCOUNTER),a
    jr PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL3_WAIT ld a,(hl)
    ld (PLY_AKG_CHANNEL3_WAITCOUNTER),a
    inc hl
    jr PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL3_SAMEINSTRUMENT ld de,(PLY_AKG_CHANNEL3_PTBASEINSTRUMENT)
    ld (PLY_AKG_CHANNEL3_PTINSTRUMENT),de
    jr PLY_AKG_CHANNEL3_AFTERINSTRUMENT
PLY_AKG_CHANNEL3_NOTE ld b,a
    ld a,(PLY_AKG_BASENOTEINDEX)
    add a,b
PLY_AKG_CHANNEL3_AFTERNOTEKNOWN ld (PLY_AKG_CHANNEL3_TRACKNOTE),a
    rl c
    jr nc,PLY_AKG_CHANNEL3_SAMEINSTRUMENT
    ld a,(hl)
    inc hl
    exx
    ld e,a
    ld d,0
    ld hl,(PLY_AKG_INSTRUMENTSTABLE)
    add hl,de
    add hl,de
    ld sp,hl
    pop hl
    ld a,(hl)
    inc hl
    ld (PLY_AKG_CHANNEL3_INSTRUMENTSPEED),a
    ld (PLY_AKG_CHANNEL3_PTINSTRUMENT),hl
    ld (PLY_AKG_CHANNEL3_PTBASEINSTRUMENT),hl
    exx
PLY_AKG_CHANNEL3_AFTERINSTRUMENT ex de,hl
    xor a
    ld l,a
    ld h,a
    ld (PLY_AKG_CHANNEL3_PITCH),hl
    ld (PLY_AKG_CHANNEL3_ARPEGGIOTABLECURRENTSTEP),a
    ld (PLY_AKG_CHANNEL3_PITCHTABLECURRENTSTEP),a
    ld (PLY_AKG_CHANNEL3_INSTRUMENTSTEP),a
    ld a,0
    ld (PLY_AKG_CHANNEL3_ISPITCH),a
    ld a,(PLY_AKG_CHANNEL3_ARPEGGIOBASESPEED)
    ld (PLY_AKG_CHANNEL3_ARPEGGIOTABLESPEED),a
    ld a,(PLY_AKG_CHANNEL3_PITCHBASESPEED)
    ld (PLY_AKG_CHANNEL3_PITCHTABLESPEED),a
    ld hl,(PLY_AKG_CHANNEL3_ARPEGGIOTABLEBASE)
    ld (PLY_AKG_CHANNEL3_ARPEGGIOTABLE),hl
    ld hl,(PLY_AKG_CHANNEL3_PITCHTABLEBASE)
    ld (PLY_AKG_CHANNEL3_PITCHTABLE),hl
    ex de,hl
    rl c
    jp c,PLY_AKG_CHANNEL3_READEFFECTS
PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER ld (PLY_AKG_CHANNEL3_PTTRACK),hl
PLY_AKG_CHANNEL3_READCELLEND ld a,(PLY_AKG_CURRENTSPEED)
PLY_AKG_SETSPEEDBEFOREPLAYSTREAMS ld (PLY_AKG_TICKDECREASINGCOUNTER),a
    ld hl,(PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL)
    ld a,(PLY_AKG_CHANNEL1_ISVOLUMESLIDE)
    add a,a
    jr nc,PLY_AKG_CHANNEL1_VOLUMESLIDE_END
    ld de,(PLY_AKG_CHANNEL1_VOLUMESLIDEVALUE)
    add hl,de
    bit 7,h
    jr z,PLY_AKG_CHANNEL1_VOLUMENOTOVERFLOW
    ld h,0
    jr PLY_AKG_CHANNEL1_VOLUMESETAGAIN
PLY_AKG_CHANNEL1_VOLUMENOTOVERFLOW ld a,h
    cp 16
    jr c,PLY_AKG_CHANNEL1_VOLUMESETAGAIN
    ld h,15
PLY_AKG_CHANNEL1_VOLUMESETAGAIN ld (PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL),hl
PLY_AKG_CHANNEL1_VOLUMESLIDE_END ld a,h
    ld (PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME),a
    ld c,0
    ld a,(PLY_AKG_CHANNEL1_ISARPEGGIOTABLE)
    add a,a
    jr nc,PLY_AKG_CHANNEL1_ARPEGGIOTABLE_END
    ld hl,(PLY_AKG_CHANNEL1_ARPEGGIOTABLE)
    ld a,(hl)
    cp 128
    jr nz,PLY_AKG_CHANNEL1_ARPEGGIOTABLE_AFTERLOOPTEST
    inc hl
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    ld a,(hl)
PLY_AKG_CHANNEL1_ARPEGGIOTABLE_AFTERLOOPTEST ld c,a
    ld a,(PLY_AKG_CHANNEL1_ARPEGGIOTABLESPEED)
    ld d,a
    ld a,(PLY_AKG_CHANNEL1_ARPEGGIOTABLECURRENTSTEP)
    inc a
    cp d
    jr c,PLY_AKG_CHANNEL1_ARPEGGIOTABLE_BEFOREEND_SAVESTEP
    inc hl
    ld (PLY_AKG_CHANNEL1_ARPEGGIOTABLE),hl
    xor a
PLY_AKG_CHANNEL1_ARPEGGIOTABLE_BEFOREEND_SAVESTEP ld (PLY_AKG_CHANNEL1_ARPEGGIOTABLECURRENTSTEP),a
PLY_AKG_CHANNEL1_ARPEGGIOTABLE_END ld de,0
    ld a,(PLY_AKG_CHANNEL1_ISPITCHTABLE)
    add a,a
    jr nc,PLY_AKG_CHANNEL1_PITCHTABLE_END
    ld sp,(PLY_AKG_CHANNEL1_PITCHTABLE)
    pop de
    pop hl
    ld a,(PLY_AKG_CHANNEL1_PITCHTABLESPEED)
    ld b,a
    ld a,(PLY_AKG_CHANNEL1_PITCHTABLECURRENTSTEP)
    inc a
    cp b
    jr c,PLY_AKG_CHANNEL1_PITCHTABLE_BEFOREEND_SAVESTEP
    ld (PLY_AKG_CHANNEL1_PITCHTABLE),hl
    xor a
PLY_AKG_CHANNEL1_PITCHTABLE_BEFOREEND_SAVESTEP ld (PLY_AKG_CHANNEL1_PITCHTABLECURRENTSTEP),a
PLY_AKG_CHANNEL1_PITCHTABLE_END ld hl,(PLY_AKG_CHANNEL1_PITCH)
    ld a,(PLY_AKG_CHANNEL1_ISPITCH)
    add a,a
    jr nc,PLY_AKG_CHANNEL1_PITCH_END
    ld ixl,c
    ld bc,(PLY_AKG_CHANNEL1_PITCHTRACK)
    or a
    jp PLY_AKG_CHANNEL1_PITCHTRACKADDORSBC_16BITS
PLY_AKG_CHANNEL1_PITCHTRACKADDORSBC_16BITSRETURN ld a,(PLY_AKG_CHANNEL1_PITCHTRACKDECIMALVALUE)
    ld b,a
    ld a,(PLY_AKG_CHANNEL1_PITCHTRACKDECIMALCOUNTER)
    jp PLY_AKG_CHANNEL1_PITCHTRACKDECIMALINSTR
PLY_AKG_CHANNEL1_PITCHTRACKDECIMALINSTRANDVALUERETURNAFTERJP ld (PLY_AKG_CHANNEL1_PITCHTRACKDECIMALCOUNTER),a
    jr nc,PLY_AKG_CHANNEL1_PITCHTRACKINTEGERADDORSUBRETURN
    jp PLY_AKG_CHANNEL1_PITCHTRACKINTEGERADDORSUB
PLY_AKG_CHANNEL1_PITCHTRACKINTEGERADDORSUBRETURN
PLY_AKG_CHANNEL1_PITCHNOCARRY ld (PLY_AKG_CHANNEL1_PITCH),hl
    ld a,(PLY_AKG_CHANNEL1_GLIDEDIRECTION)
    or a
    jr z,PLY_AKG_CHANNEL1_GLIDE_END
    ld (PLY_AKG_CHANNEL1_GLIDE_SAVEHL),hl
    ld c,l
    ld b,h
    ex af,af'
    ld a,(PLY_AKG_CHANNEL1_TRACKNOTE)
    add a,a
    ld l,a
    ex af,af'
    ld h,0
    ld sp,PLY_AKG_PERIODTABLE
    add hl,sp
    ld sp,hl
    pop hl
    dec sp
    dec sp
    add hl,bc
    ld bc,(PLY_AKG_CHANNEL1_GLIDETOREACH)
    rra 
    jr nc,PLY_AKG_CHANNEL1_GLIDEDOWNCHECK
    or a
    sbc hl,bc
    jr nc,PLY_AKG_CHANNEL1_GLIDE_BEFOREEND
    jr PLY_AKG_CHANNEL1_GLIDEOVER
PLY_AKG_CHANNEL1_GLIDEDOWNCHECK sbc hl,bc
    jr c,PLY_AKG_CHANNEL1_GLIDE_BEFOREEND
PLY_AKG_CHANNEL1_GLIDEOVER ld l,c
    ld h,b
    pop bc
    or a
    sbc hl,bc
    ld (PLY_AKG_CHANNEL1_PITCH),hl
    ld a,0
    ld (PLY_AKG_CHANNEL1_ISPITCH),a
    jr PLY_AKG_CHANNEL1_GLIDE_END
PLY_AKG_CHANNEL1_GLIDE_BEFOREEND ld hl,(PLY_AKG_CHANNEL1_GLIDE_SAVEHL)
PLY_AKG_CHANNEL1_GLIDE_END ld c,ixl
PLY_AKG_CHANNEL1_PITCH_END add hl,de
    ld (PLY_AKG_CHANNEL1_GENERATEDCURRENTPITCH),hl
    ld a,c
    ld (PLY_AKG_CHANNEL1_GENERATEDCURRENTARPNOTE),a
    ld hl,(PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL)
    ld a,(PLY_AKG_CHANNEL2_ISVOLUMESLIDE)
    add a,a
    jr nc,PLY_AKG_CHANNEL2_VOLUMESLIDE_END
    ld de,(PLY_AKG_CHANNEL2_VOLUMESLIDEVALUE)
    add hl,de
    bit 7,h
    jr z,PLY_AKG_CHANNEL2_VOLUMENOTOVERFLOW
    ld h,0
    jr PLY_AKG_CHANNEL2_VOLUMESETAGAIN
PLY_AKG_CHANNEL2_VOLUMENOTOVERFLOW ld a,h
    cp 16
    jr c,PLY_AKG_CHANNEL2_VOLUMESETAGAIN
    ld h,15
PLY_AKG_CHANNEL2_VOLUMESETAGAIN ld (PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL),hl
PLY_AKG_CHANNEL2_VOLUMESLIDE_END ld a,h
    ld (PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME),a
    ld c,0
    ld a,(PLY_AKG_CHANNEL2_ISARPEGGIOTABLE)
    add a,a
    jr nc,PLY_AKG_CHANNEL2_ARPEGGIOTABLE_END
    ld hl,(PLY_AKG_CHANNEL2_ARPEGGIOTABLE)
    ld a,(hl)
    cp 128
    jr nz,PLY_AKG_CHANNEL2_ARPEGGIOTABLE_AFTERLOOPTEST
    inc hl
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    ld a,(hl)
PLY_AKG_CHANNEL2_ARPEGGIOTABLE_AFTERLOOPTEST ld c,a
    ld a,(PLY_AKG_CHANNEL2_ARPEGGIOTABLESPEED)
    ld d,a
    ld a,(PLY_AKG_CHANNEL2_ARPEGGIOTABLECURRENTSTEP)
    inc a
    cp d
    jr c,PLY_AKG_CHANNEL2_ARPEGGIOTABLE_BEFOREEND_SAVESTEP
    inc hl
    ld (PLY_AKG_CHANNEL2_ARPEGGIOTABLE),hl
    xor a
PLY_AKG_CHANNEL2_ARPEGGIOTABLE_BEFOREEND_SAVESTEP ld (PLY_AKG_CHANNEL2_ARPEGGIOTABLECURRENTSTEP),a
PLY_AKG_CHANNEL2_ARPEGGIOTABLE_END ld de,0
    ld a,(PLY_AKG_CHANNEL2_ISPITCHTABLE)
    add a,a
    jr nc,PLY_AKG_CHANNEL2_PITCHTABLE_END
    ld sp,(PLY_AKG_CHANNEL2_PITCHTABLE)
    pop de
    pop hl
    ld a,(PLY_AKG_CHANNEL2_PITCHTABLESPEED)
    ld b,a
    ld a,(PLY_AKG_CHANNEL2_PITCHTABLECURRENTSTEP)
    inc a
    cp b
    jr c,PLY_AKG_CHANNEL2_PITCHTABLE_BEFOREEND_SAVESTEP
    ld (PLY_AKG_CHANNEL2_PITCHTABLE),hl
    xor a
PLY_AKG_CHANNEL2_PITCHTABLE_BEFOREEND_SAVESTEP ld (PLY_AKG_CHANNEL2_PITCHTABLECURRENTSTEP),a
PLY_AKG_CHANNEL2_PITCHTABLE_END ld hl,(PLY_AKG_CHANNEL2_PITCH)
    ld a,(PLY_AKG_CHANNEL2_ISPITCH)
    add a,a
    jr nc,PLY_AKG_CHANNEL2_PITCH_END
    ld ixl,c
    ld bc,(PLY_AKG_CHANNEL2_PITCHTRACK)
    or a
    jp PLY_AKG_CHANNEL2_PITCHTRACKADDORSBC_16BITS
PLY_AKG_CHANNEL2_PITCHTRACKADDORSBC_16BITSRETURN ld a,(PLY_AKG_CHANNEL2_PITCHTRACKDECIMALVALUE)
    ld b,a
    ld a,(PLY_AKG_CHANNEL2_PITCHTRACKDECIMALCOUNTER)
    jp PLY_AKG_CHANNEL2_PITCHTRACKDECIMALINSTR
PLY_AKG_CHANNEL2_PITCHTRACKDECIMALINSTRANDVALUERETURNAFTERJP ld (PLY_AKG_CHANNEL2_PITCHTRACKDECIMALCOUNTER),a
    jr nc,PLY_AKG_CHANNEL2_PITCHTRACKINTEGERADDORSUBRETURN
    jp PLY_AKG_CHANNEL2_PITCHTRACKINTEGERADDORSUB
PLY_AKG_CHANNEL2_PITCHTRACKINTEGERADDORSUBRETURN
PLY_AKG_CHANNEL2_PITCHNOCARRY ld (PLY_AKG_CHANNEL2_PITCH),hl
    ld a,(PLY_AKG_CHANNEL2_GLIDEDIRECTION)
    or a
    jr z,PLY_AKG_CHANNEL2_GLIDE_END
    ld (PLY_AKG_CHANNEL2_GLIDE_SAVEHL),hl
    ld c,l
    ld b,h
    ex af,af'
    ld a,(PLY_AKG_CHANNEL2_TRACKNOTE)
    add a,a
    ld l,a
    ex af,af'
    ld h,0
    ld sp,PLY_AKG_PERIODTABLE
    add hl,sp
    ld sp,hl
    pop hl
    dec sp
    dec sp
    add hl,bc
    ld bc,(PLY_AKG_CHANNEL2_GLIDETOREACH)
    rra 
    jr nc,PLY_AKG_CHANNEL2_GLIDEDOWNCHECK
    or a
    sbc hl,bc
    jr nc,PLY_AKG_CHANNEL2_GLIDE_BEFOREEND
    jr PLY_AKG_CHANNEL2_GLIDEOVER
PLY_AKG_CHANNEL2_GLIDEDOWNCHECK sbc hl,bc
    jr c,PLY_AKG_CHANNEL2_GLIDE_BEFOREEND
PLY_AKG_CHANNEL2_GLIDEOVER ld l,c
    ld h,b
    pop bc
    or a
    sbc hl,bc
    ld (PLY_AKG_CHANNEL2_PITCH),hl
    ld a,0
    ld (PLY_AKG_CHANNEL2_ISPITCH),a
    jr PLY_AKG_CHANNEL2_GLIDE_END
PLY_AKG_CHANNEL2_GLIDE_BEFOREEND ld hl,(PLY_AKG_CHANNEL2_GLIDE_SAVEHL)
PLY_AKG_CHANNEL2_GLIDE_END ld c,ixl
PLY_AKG_CHANNEL2_PITCH_END add hl,de
    ld (PLY_AKG_CHANNEL2_GENERATEDCURRENTPITCH),hl
    ld a,c
    ld (PLY_AKG_CHANNEL2_GENERATEDCURRENTARPNOTE),a
    ld hl,(PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL)
    ld a,(PLY_AKG_CHANNEL3_ISVOLUMESLIDE)
    add a,a
    jr nc,PLY_AKG_CHANNEL3_VOLUMESLIDE_END
    ld de,(PLY_AKG_CHANNEL3_VOLUMESLIDEVALUE)
    add hl,de
    bit 7,h
    jr z,PLY_AKG_CHANNEL3_VOLUMENOTOVERFLOW
    ld h,0
    jr PLY_AKG_CHANNEL3_VOLUMESETAGAIN
PLY_AKG_CHANNEL3_VOLUMENOTOVERFLOW ld a,h
    cp 16
    jr c,PLY_AKG_CHANNEL3_VOLUMESETAGAIN
    ld h,15
PLY_AKG_CHANNEL3_VOLUMESETAGAIN ld (PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL),hl
PLY_AKG_CHANNEL3_VOLUMESLIDE_END ld a,h
    ld (PLY_AKG_CHANNEL3_GENERATEDCURRENTINVERTEDVOLUME),a
    ld c,0
    ld a,(PLY_AKG_CHANNEL3_ISARPEGGIOTABLE)
    add a,a
    jr nc,PLY_AKG_CHANNEL3_ARPEGGIOTABLE_END
    ld hl,(PLY_AKG_CHANNEL3_ARPEGGIOTABLE)
    ld a,(hl)
    cp 128
    jr nz,PLY_AKG_CHANNEL3_ARPEGGIOTABLE_AFTERLOOPTEST
    inc hl
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    ld a,(hl)
PLY_AKG_CHANNEL3_ARPEGGIOTABLE_AFTERLOOPTEST ld c,a
    ld a,(PLY_AKG_CHANNEL3_ARPEGGIOTABLESPEED)
    ld d,a
    ld a,(PLY_AKG_CHANNEL3_ARPEGGIOTABLECURRENTSTEP)
    inc a
    cp d
    jr c,PLY_AKG_CHANNEL3_ARPEGGIOTABLE_BEFOREEND_SAVESTEP
    inc hl
    ld (PLY_AKG_CHANNEL3_ARPEGGIOTABLE),hl
    xor a
PLY_AKG_CHANNEL3_ARPEGGIOTABLE_BEFOREEND_SAVESTEP ld (PLY_AKG_CHANNEL3_ARPEGGIOTABLECURRENTSTEP),a
PLY_AKG_CHANNEL3_ARPEGGIOTABLE_END ld de,0
    ld a,(PLY_AKG_CHANNEL3_ISPITCHTABLE)
    add a,a
    jr nc,PLY_AKG_CHANNEL3_PITCHTABLE_END
    ld sp,(PLY_AKG_CHANNEL3_PITCHTABLE)
    pop de
    pop hl
    ld a,(PLY_AKG_CHANNEL3_PITCHTABLESPEED)
    ld b,a
    ld a,(PLY_AKG_CHANNEL3_PITCHTABLECURRENTSTEP)
    inc a
    cp b
    jr c,PLY_AKG_CHANNEL3_PITCHTABLE_BEFOREEND_SAVESTEP
    ld (PLY_AKG_CHANNEL3_PITCHTABLE),hl
    xor a
PLY_AKG_CHANNEL3_PITCHTABLE_BEFOREEND_SAVESTEP ld (PLY_AKG_CHANNEL3_PITCHTABLECURRENTSTEP),a
PLY_AKG_CHANNEL3_PITCHTABLE_END ld hl,(PLY_AKG_CHANNEL3_PITCH)
    ld a,(PLY_AKG_CHANNEL3_ISPITCH)
    add a,a
    jr nc,PLY_AKG_CHANNEL3_PITCH_END
    ld ixl,c
    ld bc,(PLY_AKG_CHANNEL3_PITCHTRACK)
    or a
    jp PLY_AKG_CHANNEL3_PITCHTRACKADDORSBC_16BITS
PLY_AKG_CHANNEL3_PITCHTRACKADDORSBC_16BITSRETURN ld a,(PLY_AKG_CHANNEL3_PITCHTRACKDECIMALVALUE)
    ld b,a
    ld a,(PLY_AKG_CHANNEL3_PITCHTRACKDECIMALCOUNTER)
    jp PLY_AKG_CHANNEL3_PITCHTRACKDECIMALINSTR
PLY_AKG_CHANNEL3_PITCHTRACKDECIMALINSTRANDVALUERETURNAFTERJP ld (PLY_AKG_CHANNEL3_PITCHTRACKDECIMALCOUNTER),a
    jr nc,PLY_AKG_CHANNEL3_PITCHTRACKINTEGERADDORSUBRETURN
    jp PLY_AKG_CHANNEL3_PITCHTRACKINTEGERADDORSUB
PLY_AKG_CHANNEL3_PITCHTRACKINTEGERADDORSUBRETURN
PLY_AKG_CHANNEL3_PITCHNOCARRY ld (PLY_AKG_CHANNEL3_PITCH),hl
    ld a,(PLY_AKG_CHANNEL3_GLIDEDIRECTION)
    or a
    jr z,PLY_AKG_CHANNEL3_GLIDE_END
    ld (PLY_AKG_CHANNEL3_GLIDE_SAVEHL),hl
    ld c,l
    ld b,h
    ex af,af'
    ld a,(PLY_AKG_CHANNEL3_TRACKNOTE)
    add a,a
    ld l,a
    ex af,af'
    ld h,0
    ld sp,PLY_AKG_PERIODTABLE
    add hl,sp
    ld sp,hl
    pop hl
    dec sp
    dec sp
    add hl,bc
    ld bc,(PLY_AKG_CHANNEL3_GLIDETOREACH)
    rra 
    jr nc,PLY_AKG_CHANNEL3_GLIDEDOWNCHECK
    or a
    sbc hl,bc
    jr nc,PLY_AKG_CHANNEL3_GLIDE_BEFOREEND
    jr PLY_AKG_CHANNEL3_GLIDEOVER
PLY_AKG_CHANNEL3_GLIDEDOWNCHECK sbc hl,bc
    jr c,PLY_AKG_CHANNEL3_GLIDE_BEFOREEND
PLY_AKG_CHANNEL3_GLIDEOVER ld l,c
    ld h,b
    pop bc
    or a
    sbc hl,bc
    ld (PLY_AKG_CHANNEL3_PITCH),hl
    ld a,0
    ld (PLY_AKG_CHANNEL3_ISPITCH),a
    jr PLY_AKG_CHANNEL3_GLIDE_END
PLY_AKG_CHANNEL3_GLIDE_BEFOREEND ld hl,(PLY_AKG_CHANNEL3_GLIDE_SAVEHL)
PLY_AKG_CHANNEL3_GLIDE_END ld c,ixl
PLY_AKG_CHANNEL3_PITCH_END add hl,de
    ld (PLY_AKG_CHANNEL3_GENERATEDCURRENTPITCH),hl
    ld a,c
    ld (PLY_AKG_CHANNEL3_GENERATEDCURRENTARPNOTE),a
    ld sp,(PLY_AKG_SAVESP)
    ld hl,(PLY_AKG_CHANNEL1_GENERATEDCURRENTPITCH)
    ld a,(PLY_AKG_CHANNEL1_TRACKNOTE)
    ld e,a
    ld a,(PLY_AKG_CHANNEL1_GENERATEDCURRENTARPNOTE)
    add a,e
    ld e,a
    ld d,0
    exx
    ld a,(PLY_AKG_CHANNEL1_INSTRUMENTSTEP)
    ld iyl,a
    ld hl,(PLY_AKG_CHANNEL1_PTINSTRUMENT)
    ld a,(PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME)
    ld e,a
    ld d,224
    call PLY_AKG_READINSTRUMENTCELL
    ld a,(PLY_AKG_CHANNEL1_INSTRUMENTSPEED)
    ld b,a
    ld a,iyl
    inc a
    cp b
    jr c,PLY_AKG_CHANNEL1_SETINSTRUMENTSTEP
    ld (PLY_AKG_CHANNEL1_PTINSTRUMENT),hl
    xor a
PLY_AKG_CHANNEL1_SETINSTRUMENTSTEP ld (PLY_AKG_CHANNEL1_INSTRUMENTSTEP),a
    ld a,e
    ld (PLY_AKG_PSGREG8),a
    srl d
    exx
    ld (PLY_AKG_PSGREG01_INSTR),hl
    ld hl,(PLY_AKG_CHANNEL2_GENERATEDCURRENTPITCH)
    ld a,(PLY_AKG_CHANNEL2_TRACKNOTE)
    ld e,a
    ld a,(PLY_AKG_CHANNEL2_GENERATEDCURRENTARPNOTE)
    add a,e
    ld e,a
    ld d,0
    exx
    ld a,(PLY_AKG_CHANNEL2_INSTRUMENTSTEP)
    ld iyl,a
    ld hl,(PLY_AKG_CHANNEL2_PTINSTRUMENT)
    ld a,(PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME)
    ld e,a
    call PLY_AKG_READINSTRUMENTCELL
    ld a,(PLY_AKG_CHANNEL2_INSTRUMENTSPEED)
    ld b,a
    ld a,iyl
    inc a
    cp b
    jr c,PLY_AKG_CHANNEL2_SETINSTRUMENTSTEP
    ld (PLY_AKG_CHANNEL2_PTINSTRUMENT),hl
    xor a
PLY_AKG_CHANNEL2_SETINSTRUMENTSTEP ld (PLY_AKG_CHANNEL2_INSTRUMENTSTEP),a
    ld a,e
    ld (PLY_AKG_PSGREG9_10_INSTR),a
    scf
    rr d
    exx
    ld (PLY_AKG_PSGREG23_INSTR),hl
    ld hl,(PLY_AKG_CHANNEL3_GENERATEDCURRENTPITCH)
    ld a,(PLY_AKG_CHANNEL3_TRACKNOTE)
    ld e,a
    ld a,(PLY_AKG_CHANNEL3_GENERATEDCURRENTARPNOTE)
    add a,e
    ld e,a
    ld d,0
    exx
    ld a,(PLY_AKG_CHANNEL3_INSTRUMENTSTEP)
    ld iyl,a
    ld hl,(PLY_AKG_CHANNEL3_PTINSTRUMENT)
    ld a,(PLY_AKG_CHANNEL3_GENERATEDCURRENTINVERTEDVOLUME)
    ld e,a
    call PLY_AKG_READINSTRUMENTCELL
    ld a,(PLY_AKG_CHANNEL3_INSTRUMENTSPEED)
    ld b,a
    ld a,iyl
    inc a
    cp b
    jr c,PLY_AKG_CHANNEL3_SETINSTRUMENTSTEP
    ld (PLY_AKG_CHANNEL3_PTINSTRUMENT),hl
    xor a
PLY_AKG_CHANNEL3_SETINSTRUMENTSTEP ld (PLY_AKG_CHANNEL3_INSTRUMENTSTEP),a
    ld a,e
    ld (PLY_AKG_PSGREG10),a
    ld a,d
    exx
    ld (PLY_AKG_PSGREG45_INSTR),hl
    call PLY_AKG_PLAYSOUNDEFFECTSSTREAM
PLY_AKG_SENDPSGREGISTERS ld b,a
    ld a,7
    out (160),a
    ld a,b
    out (161),a
    ld hl,(PLY_AKG_PSGREG01_INSTR)
    xor a
    out (160),a
    ld a,l
    out (161),a
    ld a,1
    out (160),a
    ld a,h
    out (161),a
    ld hl,(PLY_AKG_PSGREG23_INSTR)
    ld a,2
    out (160),a
    ld a,l
    out (161),a
    ld a,3
    out (160),a
    ld a,h
    out (161),a
    ld hl,(PLY_AKG_PSGREG45_INSTR)
    ld a,4
    out (160),a
    ld a,l
    out (161),a
    ld a,5
    out (160),a
    ld a,h
    out (161),a
    ld hl,(PLY_AKG_PSGREG6_8_INSTR)
    ld a,6
    out (160),a
    ld a,l
    out (161),a
    ld a,8
    out (160),a
    ld a,h
    out (161),a
    ld hl,(PLY_AKG_PSGREG9_10_INSTR)
    ld a,9
    out (160),a
    ld a,l
    out (161),a
    ld a,10
    out (160),a
    ld a,h
    out (161),a
    ld hl,(PLY_AKG_PSGHARDWAREPERIOD_INSTR)
    ld a,11
    out (160),a
    ld a,l
    out (161),a
    ld a,12
    out (160),a
    ld a,h
    out (161),a
    ld a,13
    out (160),a
    ld a,(PLY_AKG_PSGREG13_OLDVALUE)
    ld l,a
    ld a,(PLY_AKG_PSGREG13_INSTR)
    cp l
    jr z,PLY_AKG_PSGREG13_END
    ld (PLY_AKG_PSGREG13_OLDVALUE),a
    out (161),a
PLY_AKG_PSGREG13_END ld sp,(PLY_AKG_SAVESP)
    ret 
PLY_AKG_CHANNEL1_MAYBEEFFECTS ld (PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS),a
    bit 6,c
    jp z,PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL1_READEFFECTS ld iy,PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS
    ld ix,PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS
    ld de,PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
    jr PLY_AKG_CHANNEL3_READEFFECTSEND
PLY_AKG_CHANNEL1_READEFFECTSEND
PLY_AKG_CHANNEL2_MAYBEEFFECTS ld (PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS),a
    bit 6,c
    jp z,PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL2_READEFFECTS ld iy,PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS
    ld ix,PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS
    ld de,PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
    jr PLY_AKG_CHANNEL3_READEFFECTSEND
PLY_AKG_CHANNEL2_READEFFECTSEND
PLY_AKG_CHANNEL3_MAYBEEFFECTS ld (PLY_AKG_CHANNEL3_WAITCOUNTER),a
    bit 6,c
    jp z,PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL3_READEFFECTS ld iy,PLY_AKG_CHANNEL3_WAITCOUNTER
    ld ix,PLY_AKG_CHANNEL3_WAITCOUNTER
    ld de,PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL3_READEFFECTSEND
PLY_AKG_CHANNEL_READEFFECTS ld (PLY_AKG_CHANNEL_READEFFECTS_ENDJUMPINSTRANDADDRESS+1),de
    ex de,hl
    ld a,(de)
    inc de
    sla a
    jr c,PLY_AKG_CHANNEL_READEFFECTS_RELATIVEADDRESS
    exx
    ld l,a
    ld h,0
    ld de,(PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS1)
    add hl,de
    ld e,(hl)
    inc hl
    ld d,(hl)
PLY_AKG_CHANNEL_RE_EFFECTADDRESSKNOWN ld a,(de)
    inc de
    ld (PLY_AKG_CHANNEL_RE_READNEXTEFFECTINBLOCK),a
    and 254
    ld l,a
    ld h,0
    ld sp,PLY_AKG_EFFECTTABLE
    add hl,sp
    ld sp,hl
    ret 
PLY_AKG_CHANNEL_RE_EFFECTRETURN ld a,(PLY_AKG_CHANNEL_RE_READNEXTEFFECTINBLOCK)
    rra 
    jr c,PLY_AKG_CHANNEL_RE_EFFECTADDRESSKNOWN
    exx
    ex de,hl
    jp PLY_AKG_CHANNEL_READEFFECTS_ENDJUMPINSTRANDADDRESS
PLY_AKG_CHANNEL_READEFFECTS_RELATIVEADDRESS srl a
    exx
    ld h,a
    exx
    ld a,(de)
    inc de
    exx
    ld l,a
    ld de,(PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS1)
    add hl,de
    jr PLY_AKG_CHANNEL_RE_EFFECTADDRESSKNOWN
PLY_AKG_READINSTRUMENTCELL ld a,(hl)
    inc hl
    ld b,a
    rra 
    jp c,PLY_AKG_S_OR_H_OR_SAH_OR_ENDWITHLOOP
    rra 
    jp c,PLY_AKG_STH_OR_ENDWITHOUTLOOP
    rra 
PLY_AKG_NOSOFTNOHARD and 15
    sub e
    jr nc,PLY_AKG_NOSOFTNOHARD+6
    xor a
    ld e,a
    rl b
    jr nc,PLY_AKG_NSNH_NONOISE
    ld a,(hl)
    inc hl
    ld (PLY_AKG_PSGREG6_8_INSTR),a
    set 2,d
    res 5,d
    ret 
PLY_AKG_NSNH_NONOISE set 2,d
    ret 
PLY_AKG_SOFT and 15
    sub e
    jr nc,PLY_AKG_SOFTONLY_HARDONLY_TESTSIMPLE_COMMON-1
    xor a
    ld e,a
PLY_AKG_SOFTONLY_HARDONLY_TESTSIMPLE_COMMON rl b
    jr nc,PLY_AKG_S_NOTSIMPLE
    ld c,0
    jr PLY_AKG_S_AFTERSIMPLETEST
PLY_AKG_S_NOTSIMPLE ld b,(hl)
    ld c,b
    inc hl
PLY_AKG_S_AFTERSIMPLETEST call PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD
    ld a,c
    and 31
    ret z
    ld (PLY_AKG_PSGREG6_8_INSTR),a
    res 5,d
    ret 
PLY_AKG_ENDWITHOUTLOOP ld hl,(PLY_AKG_EMPTYINSTRUMENTDATAPT)
    inc hl
    xor a
    ld b,a
    jp PLY_AKG_NOSOFTNOHARD
PLY_AKG_STH_OR_ENDWITHOUTLOOP rra 
    jr c,PLY_AKG_ENDWITHOUTLOOP
    call PLY_AKG_STOH_HTOS_SANDH_COMMON
    exx
    ld bc,PLY_AKG_SH_JUMPRATIO
    add a,c
    ld c,a
    ld a,b
    adc a,0
    ld b,a
    ld (PLY_AKG_TEMPPLAYINSTRUMENTJUMPINSTRANDADDRESS+1),bc
    exx
    exx
    ld e,l
    ld d,h
    jp PLY_AKG_TEMPPLAYINSTRUMENTJUMPINSTRANDADDRESS
PLY_AKG_SH_JUMPRATIO srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr nc,PLY_AKG_SH_JUMPRATIOEND
    inc hl
PLY_AKG_SH_JUMPRATIOEND ld (PLY_AKG_PSGHARDWAREPERIOD_INSTR),hl
    ex de,hl
    exx
    ret 
PLY_AKG_S_OR_H_OR_SAH_OR_ENDWITHLOOP rra 
    jr c,PLY_AKG_H_OR_ENDWITHLOOP
    rra 
    jp nc,PLY_AKG_SOFT
PLY_AKG_H_OR_ENDWITHLOOP
PLY_AKG_ENDWITHLOOP ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    jp PLY_AKG_READINSTRUMENTCELL
PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD jr nc,PLY_AKG_S_OR_H_NEXTBYTE
    exx
    ex de,hl
    add hl,hl
    ld bc,PLY_AKG_PERIODTABLE
    add hl,bc
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    add hl,de
    exx
    rl b
    rl b
    rl b
    ret 
PLY_AKG_S_OR_H_NEXTBYTE rl b
    jr c,PLY_AKG_S_OR_H_FORCEDPERIOD
    rl b
    jr nc,PLY_AKG_S_OR_H_AFTERARPEGGIO
    ld a,(hl)
    inc hl
    exx
    add a,e
    ld e,a
    exx
PLY_AKG_S_OR_H_AFTERARPEGGIO rl b
    exx
    ex de,hl
    add hl,hl
    ld bc,PLY_AKG_PERIODTABLE
    add hl,bc
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    add hl,de
    exx
    ret 
PLY_AKG_S_OR_H_FORCEDPERIOD ld a,(hl)
    inc hl
    exx
    ld l,a
    exx
    ld a,(hl)
    inc hl
    exx
    ld h,a
    exx
    rl b
    rl b
    ret 
PLY_AKG_STOH_HTOS_SANDH_COMMON ld e,16
    rra 
    and 7
    add a,8
    ld (PLY_AKG_PSGREG13_INSTR),a
    rl b
    ld c,(hl)
    ld b,c
    inc hl
    rl b
    call PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD
    ld a,c
    rla 
    rla 
    and 28
    ret 
PLY_AKG_EFFECTTABLE dw JUSTADDCREAM_START
    dw JUSTADDCREAM_START
    dw PLY_AKG_EFFECT_VOLUME
    dw PLY_AKG_EFFECT_ARPEGGIOTABLE
    dw PLY_AKG_EFFECT_ARPEGGIOTABLESTOP
    dw PLY_AKG_EFFECT_PITCHTABLE
    dw PLY_AKG_EFFECT_PITCHTABLESTOP
    dw PLY_AKG_EFFECT_VOLUMESLIDE
    dw PLY_AKG_EFFECT_VOLUMESLIDESTOP
    dw PLY_AKG_EFFECT_PITCHUP
    dw PLY_AKG_EFFECT_PITCHDOWN
    dw PLY_AKG_EFFECT_PITCHSTOP
    dw PLY_AKG_EFFECT_GLIDEWITHNOTE
    dw PLY_AKG_EFFECT_GLIDE_READSPEED
    dw JUSTADDCREAM_START
    dw JUSTADDCREAM_START
    dw JUSTADDCREAM_START
PLY_AKG_EFFECT_VOLUME ld a,(de)
    inc de
    ld (iy+36),a
    ld (iy+1),0
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_ARPEGGIOTABLE ld a,(de)
    inc de
    ld l,a
    ld h,0
    add hl,hl
    ld bc,(PLY_AKG_ARPEGGIOSTABLE)
    add hl,bc
    ld c,(hl)
    inc hl
    ld b,(hl)
    inc hl
    ld a,(bc)
    inc bc
    ld (iy+10),a
    ld (iy+9),a
    ld (iy+21),c
    ld (iy+22),b
    ld (iy+23),c
    ld (iy+24),b
    ld (iy+2),255
    xor a
    ld (iy+7),a
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_ARPEGGIOTABLESTOP ld (iy+2),0
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_PITCHTABLE ld a,(de)
    inc de
    ld l,a
    ld h,0
    add hl,hl
    ld bc,(PLY_AKG_PITCHESTABLE)
    add hl,bc
    ld c,(hl)
    inc hl
    ld b,(hl)
    inc hl
    ld a,(bc)
    inc bc
    ld (iy+13),a
    ld (iy+12),a
    ld (iy+27),c
    ld (iy+28),b
    ld (iy+29),c
    ld (iy+30),b
    ld (iy+3),255
    xor a
    ld (iy+11),a
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_PITCHTABLESTOP ld (iy+3),0
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_VOLUMESLIDE ld a,(de)
    inc de
    ld (iy+43),a
    ld a,(de)
    inc de
    ld (iy+44),a
    ld (iy+1),255
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_VOLUMESLIDESTOP ld (iy+1),0
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_PITCHDOWN ld (iy+56),0
    ld (iy+57),9
    ld (iy+49),198
    ld (iy+61),35
PLY_AKG_EFFECT_PITCHUPDOWN_COMMON ld (iy+4),255
    ld (iy+17),0
    ld a,(de)
    inc de
    ld (iy+50),a
    ld a,(de)
    inc de
    ld (iy+25),a
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_PITCHUP ld (iy+56),237
    ld (iy+57),66
    ld (iy+49),214
    ld (iy+61),43
    jr PLY_AKG_EFFECT_PITCHUPDOWN_COMMON
PLY_AKG_EFFECT_PITCHSTOP ld (iy+4),0
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_GLIDEWITHNOTE ld a,(de)
    inc de
    ld (PLY_AKG_EFFECT_GLIDEWITHNOTESAVEDE),de
    add a,a
    ld l,a
    ld h,0
    ld bc,PLY_AKG_PERIODTABLE
    add hl,bc
    ld sp,hl
    pop de
    ld (iy+45),e
    ld (iy+46),d
    ld a,(ix+16)
    add a,a
    ld l,a
    ld h,0
    add hl,bc
    ld sp,hl
    pop hl
    ld c,(iy+37)
    ld b,(iy+38)
    add hl,bc
    or a
    sbc hl,de
    ld de,(PLY_AKG_EFFECT_GLIDEWITHNOTESAVEDE)
    jr c,PLY_AKG_EFFECT_GLIDE_PITCHDOWN
    ld (iy+17),1
    ld (iy+56),237
    ld (iy+57),66
    ld (iy+49),214
    ld (iy+61),43
PLY_AKG_EFFECT_GLIDE_READSPEED
PLY_AKG_EFFECT_GLIDESPEED ld a,(de)
    inc de
    ld (iy+50),a
    ld a,(de)
    inc de
    ld (iy+25),a
    ld a,255
    ld (iy+4),a
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_GLIDE_PITCHDOWN ld (iy+17),2
    ld (iy+56),0
    ld (iy+57),9
    ld (iy+49),198
    ld (iy+61),35
    jr PLY_AKG_EFFECT_GLIDE_READSPEED
PLY_AKG_PERIODTABLE dw 6778
    dw 6398
    dw 6039
    dw 5700
    dw 5380
    dw 5078
    dw 4793
    dw 4524
    dw 4270
    dw 4030
    dw 3804
    dw 3591
    dw 3389
    dw 3199
    dw 3019
    dw 2850
    dw 2690
    dw 2539
    dw 2397
    dw 2262
    dw 2135
    dw 2015
    dw 1902
    dw 1795
    dw 1695
    dw 1599
    dw 1510
    dw 1425
    dw 1345
    dw 1270
    dw 1198
    dw 1131
    dw 1068
    dw 1008
    dw 951
    dw 898
    dw 847
    dw 800
    dw 755
    dw 712
    dw 673
    dw 635
    dw 599
    dw 566
    dw 534
    dw 504
    dw 476
    dw 449
    dw 424
    dw 400
    dw 377
    dw 356
    dw 336
    dw 317
    dw 300
    dw 283
    dw 267
    dw 252
    dw 238
    dw 224
    dw 212
    dw 200
    dw 189
    dw 178
    dw 168
    dw 159
    dw 150
    dw 141
    dw 133
    dw 126
    dw 119
    dw 112
    dw 106
    dw 100
    dw 94
    dw 89
    dw 84
    dw 79
    dw 75
    dw 71
    dw 67
    dw 63
    dw 59
    dw 56
    dw 53
    dw 50
    dw 47
    dw 45
    dw 42
    dw 40
    dw 37
    dw 35
    dw 33
    dw 31
    dw 30
    dw 28
    dw 26
    dw 25
    dw 24
    dw 22
    dw 21
    dw 20
    dw 19
    dw 18
    dw 17
    dw 16
    dw 15
    dw 14
    dw 13
    dw 12
    dw 12
    dw 11
    dw 11
    dw 10
    dw 9
    dw 9
    dw 8
    dw 8
    dw 7
    dw 7
    dw 7
    dw 6
    dw 6
    dw 6
    dw 5
    dw 5
    dw 5
    dw 4
PLY_AKG_ARPEGGIOSTABLE equ 58892
PLY_AKG_BASENOTEINDEX equ 58881
PLY_AKG_CHANNEL1_ARPEGGIOBASESPEED equ 58933
PLY_AKG_CHANNEL1_ARPEGGIOTABLE equ 58945
PLY_AKG_CHANNEL1_ARPEGGIOTABLEBASE equ 58947
PLY_AKG_CHANNEL1_ARPEGGIOTABLECURRENTSTEP equ 58931
PLY_AKG_CHANNEL1_ARPEGGIOTABLESPEED equ 58934
PLY_AKG_CHANNEL1_GENERATEDCURRENTARPNOTE equ 58932
PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME equ 58942
PLY_AKG_CHANNEL1_GENERATEDCURRENTPITCH equ 58978
PLY_AKG_CHANNEL1_GLIDEDIRECTION equ 58941
PLY_AKG_CHANNEL1_GLIDETOREACH equ 58969
PLY_AKG_CHANNEL1_GLIDE_SAVEHL equ 58971
PLY_AKG_CHANNEL1_INSTRUMENTSPEED equ 58929
PLY_AKG_CHANNEL1_INSTRUMENTSTEP equ 58930
PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGER equ 58960
PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL equ 58959
PLY_AKG_CHANNEL1_ISARPEGGIOTABLE equ 58926
PLY_AKG_CHANNEL1_ISPITCH equ 58928
PLY_AKG_CHANNEL1_ISPITCHTABLE equ 58927
PLY_AKG_CHANNEL1_ISVOLUMESLIDE equ 58925
PLY_AKG_CHANNEL1_PITCH equ 58961
PLY_AKG_CHANNEL1_PITCHBASESPEED equ 58936
PLY_AKG_CHANNEL1_PITCHTABLE equ 58951
PLY_AKG_CHANNEL1_PITCHTABLEBASE equ 58953
PLY_AKG_CHANNEL1_PITCHTABLECURRENTSTEP equ 58935
PLY_AKG_CHANNEL1_PITCHTABLESPEED equ 58937
PLY_AKG_CHANNEL1_PITCHTRACK equ 58949
PLY_AKG_CHANNEL1_PITCHTRACKADDORSBC_16BITS equ 58980
PLY_AKG_CHANNEL1_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS equ 58982
PLY_AKG_CHANNEL1_PITCHTRACKDECIMALCOUNTER equ 58939
PLY_AKG_CHANNEL1_PITCHTRACKDECIMALINSTR equ 58973
PLY_AKG_CHANNEL1_PITCHTRACKDECIMALINSTRANDVALUERETURNJP equ 58975
PLY_AKG_CHANNEL1_PITCHTRACKDECIMALVALUE equ 58974
PLY_AKG_CHANNEL1_PITCHTRACKINTEGERADDORSUB equ 58985
PLY_AKG_CHANNEL1_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS equ 58986
PLY_AKG_CHANNEL1_PTBASEINSTRUMENT equ 58965
PLY_AKG_CHANNEL1_PTINSTRUMENT equ 58963
PLY_AKG_CHANNEL1_PTTRACK equ 58943
PLY_AKG_CHANNEL1_SOUNDEFFECTDATA equ 59121
PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS equ 58924
PLY_AKG_CHANNEL1_TRACKNOTE equ 58940
PLY_AKG_CHANNEL1_VOLUMESLIDEVALUE equ 58967
PLY_AKG_CHANNEL2_ARPEGGIOBASESPEED equ 58998
PLY_AKG_CHANNEL2_ARPEGGIOTABLE equ 59010
PLY_AKG_CHANNEL2_ARPEGGIOTABLEBASE equ 59012
PLY_AKG_CHANNEL2_ARPEGGIOTABLECURRENTSTEP equ 58996
PLY_AKG_CHANNEL2_ARPEGGIOTABLESPEED equ 58999
PLY_AKG_CHANNEL2_GENERATEDCURRENTARPNOTE equ 58997
PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME equ 59007
PLY_AKG_CHANNEL2_GENERATEDCURRENTPITCH equ 59043
PLY_AKG_CHANNEL2_GLIDEDIRECTION equ 59006
PLY_AKG_CHANNEL2_GLIDETOREACH equ 59034
PLY_AKG_CHANNEL2_GLIDE_SAVEHL equ 59036
PLY_AKG_CHANNEL2_INSTRUMENTSPEED equ 58994
PLY_AKG_CHANNEL2_INSTRUMENTSTEP equ 58995
PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGER equ 59025
PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL equ 59024
PLY_AKG_CHANNEL2_ISARPEGGIOTABLE equ 58991
PLY_AKG_CHANNEL2_ISPITCH equ 58993
PLY_AKG_CHANNEL2_ISPITCHTABLE equ 58992
PLY_AKG_CHANNEL2_ISVOLUMESLIDE equ 58990
PLY_AKG_CHANNEL2_PITCH equ 59026
PLY_AKG_CHANNEL2_PITCHBASESPEED equ 59001
PLY_AKG_CHANNEL2_PITCHTABLE equ 59016
PLY_AKG_CHANNEL2_PITCHTABLEBASE equ 59018
PLY_AKG_CHANNEL2_PITCHTABLECURRENTSTEP equ 59000
PLY_AKG_CHANNEL2_PITCHTABLESPEED equ 59002
PLY_AKG_CHANNEL2_PITCHTRACK equ 59014
PLY_AKG_CHANNEL2_PITCHTRACKADDORSBC_16BITS equ 59045
PLY_AKG_CHANNEL2_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS equ 59047
PLY_AKG_CHANNEL2_PITCHTRACKDECIMALCOUNTER equ 59004
PLY_AKG_CHANNEL2_PITCHTRACKDECIMALINSTR equ 59038
PLY_AKG_CHANNEL2_PITCHTRACKDECIMALINSTRANDVALUERETURNJP equ 59040
PLY_AKG_CHANNEL2_PITCHTRACKDECIMALVALUE equ 59039
PLY_AKG_CHANNEL2_PITCHTRACKINTEGERADDORSUB equ 59050
PLY_AKG_CHANNEL2_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS equ 59051
PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS equ 58989
PLY_AKG_CHANNEL2_PTBASEINSTRUMENT equ 59030
PLY_AKG_CHANNEL2_PTINSTRUMENT equ 59028
PLY_AKG_CHANNEL2_PTTRACK equ 59008
PLY_AKG_CHANNEL2_SOUNDEFFECTDATA equ 59129
PLY_AKG_CHANNEL2_TRACKNOTE equ 59005
PLY_AKG_CHANNEL2_VOLUMESLIDEVALUE equ 59032
PLY_AKG_CHANNEL3_ARPEGGIOBASESPEED equ 59063
PLY_AKG_CHANNEL3_ARPEGGIOTABLE equ 59075
PLY_AKG_CHANNEL3_ARPEGGIOTABLEBASE equ 59077
PLY_AKG_CHANNEL3_ARPEGGIOTABLECURRENTSTEP equ 59061
PLY_AKG_CHANNEL3_ARPEGGIOTABLESPEED equ 59064
PLY_AKG_CHANNEL3_GENERATEDCURRENTARPNOTE equ 59062
PLY_AKG_CHANNEL3_GENERATEDCURRENTINVERTEDVOLUME equ 59072
PLY_AKG_CHANNEL3_GENERATEDCURRENTPITCH equ 59108
PLY_AKG_CHANNEL3_GLIDEDIRECTION equ 59071
PLY_AKG_CHANNEL3_GLIDETOREACH equ 59099
PLY_AKG_CHANNEL3_GLIDE_SAVEHL equ 59101
PLY_AKG_CHANNEL3_INSTRUMENTSPEED equ 59059
PLY_AKG_CHANNEL3_INSTRUMENTSTEP equ 59060
PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGER equ 59090
PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL equ 59089
PLY_AKG_CHANNEL3_ISARPEGGIOTABLE equ 59056
PLY_AKG_CHANNEL3_ISPITCH equ 59058
PLY_AKG_CHANNEL3_ISPITCHTABLE equ 59057
PLY_AKG_CHANNEL3_ISVOLUMESLIDE equ 59055
PLY_AKG_CHANNEL3_PITCH equ 59091
PLY_AKG_CHANNEL3_PITCHBASESPEED equ 59066
PLY_AKG_CHANNEL3_PITCHTABLE equ 59081
PLY_AKG_CHANNEL3_PITCHTABLEBASE equ 59083
PLY_AKG_CHANNEL3_PITCHTABLECURRENTSTEP equ 59065
PLY_AKG_CHANNEL3_PITCHTABLESPEED equ 59067
PLY_AKG_CHANNEL3_PITCHTRACK equ 59079
PLY_AKG_CHANNEL3_PITCHTRACKADDORSBC_16BITS equ 59110
PLY_AKG_CHANNEL3_PITCHTRACKAFTERADDORSBCJUMPINSTRANDADDRESS equ 59112
PLY_AKG_CHANNEL3_PITCHTRACKDECIMALCOUNTER equ 59069
PLY_AKG_CHANNEL3_PITCHTRACKDECIMALINSTR equ 59103
PLY_AKG_CHANNEL3_PITCHTRACKDECIMALINSTRANDVALUERETURNJP equ 59105
PLY_AKG_CHANNEL3_PITCHTRACKDECIMALVALUE equ 59104
PLY_AKG_CHANNEL3_PITCHTRACKINTEGERADDORSUB equ 59115
PLY_AKG_CHANNEL3_PITCHTRACKINTEGERAFTERADDORSUBJUMPINSTRANDADDRESS equ 59116
PLY_AKG_CHANNEL3_PTBASEINSTRUMENT equ 59095
PLY_AKG_CHANNEL3_PTINSTRUMENT equ 59093
PLY_AKG_CHANNEL3_PTTRACK equ 59073
PLY_AKG_CHANNEL3_SOUNDEFFECTDATA equ 59137
PLY_AKG_CHANNEL3_TRACKNOTE equ 59070
PLY_AKG_CHANNEL3_VOLUMESLIDEVALUE equ 59097
PLY_AKG_CHANNEL3_WAITCOUNTER equ 59054
PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS1 equ 58898
PLY_AKG_CHANNEL_READEFFECTS_ENDJUMPINSTRANDADDRESS equ 58916
PLY_AKG_CHANNEL_RE_READNEXTEFFECTINBLOCK equ 58887
PLY_AKG_CURRENTSPEED equ 58880
PLY_AKG_EFFECT_GLIDEWITHNOTESAVEDE equ 58919
PLY_AKG_EMPTYINSTRUMENTDATAPT equ 58900
PLY_AKG_INSTRUMENTSTABLE equ 58896
PLY_AKG_PATTERNDECREASINGHEIGHT equ 58882
PLY_AKG_PITCHESTABLE equ 58894
PLY_AKG_PSGHARDWAREPERIOD_INSTR equ 58914
PLY_AKG_PSGREG01_INSTR equ 58904
PLY_AKG_PSGREG10 equ 58913
PLY_AKG_PSGREG13_INSTR equ 58886
PLY_AKG_PSGREG13_OLDVALUE equ 58885
PLY_AKG_PSGREG23_INSTR equ 58906
PLY_AKG_PSGREG45_INSTR equ 58908
PLY_AKG_PSGREG6_8_INSTR equ 58910
PLY_AKG_PSGREG8 equ 58911
PLY_AKG_PSGREG9_10_INSTR equ 58912
PLY_AKG_PTSOUNDEFFECTTABLE equ 59119
PLY_AKG_READLINKER_PTLINKER equ 58888
PLY_AKG_SAVESP equ 58902
PLY_AKG_SPEEDTRACK_PTTRACK equ 58890
PLY_AKG_SPEEDTRACK_WAITCOUNTER equ 58884
PLY_AKG_TEMPPLAYINSTRUMENTJUMPINSTRANDADDRESS equ 58921
PLY_AKG_TICKDECREASINGCOUNTER equ 58883
