; Table aligned to 0xC000
; --- Background objects with state (diamonds for example)

; WARNING: simply change this constants may not work, because the routine
; expects that each screen occupies 256 bytes (page aligned)
NUMBER_OF_BG_OBJS_PER_SCREEN:           equ 16     ; TODO: should these constants be moved to constants file? Answer: No, the constants should be close to where they are meaningful.
BG_OBJ_STRUCT_SIZE:                     equ 16

NUMBER_OF_SCREENS_PER_LEVEL:            equ 16      ; Each level length is fixed at 16 screens (as a comparison SMB level 1-1 is 14 screens long)


BgObjects_Start:            rb (NUMBER_OF_BG_OBJS_PER_SCREEN * BG_OBJ_STRUCT_SIZE) * NUMBER_OF_SCREENS_PER_LEVEL   ; (number of items per screen * size of struct) * number of pages
.end: