; These will be mapped to RAM, all values that will be modified need to be in RAM

                                                ; rb n  = reserve n bytes in RAM
                                                ; rw n  = reserve n words in RAM
SEED:                       rw 1            ; Seed for random number generator

X:                          rb 1

BgScrollRegister:           rb 1
;NextBgLineAddr:             rw 1


FrameIndex:                 rb 1
BgIndex:                    rw 1
BgIndexFirstFrame:          rw 1
