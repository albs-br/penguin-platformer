; Table aligned to 0xC000
; --- Background objects with state (diamonds for example)

; Dynamic objects on BG (e.g. diamonds, enemies)
NUMBER_OF_BG_OBJS_PER_SCREEN:           equ 32     ; TODO: should these constants be moved to constants file?
BG_OBJ_STRUCT_SIZE:                     equ 8


BgObjects_Start:            rb (NUMBER_OF_BG_OBJS_PER_SCREEN * BG_OBJ_STRUCT_SIZE) * 16   ; (number of items per screen * size of struct) * number of pages

; BgObjects_1st_Third_Start:  rb 64 * 16   ; bytes per page * number of pages
; BgObjects_2nd_Third_Start:  rb 96 * 16   ; bytes per page * number of pages
; BgObjects_3rd_Third_Start:  rb 96 * 16   ; bytes per page * number of pages

BgObjects_End: