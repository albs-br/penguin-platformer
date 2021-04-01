
WIDTH1:      EQU 16
HEIGHT1:     EQU 16

;WIDTH 2:
WIDTH24:     EQU 24
WIDTH8:      EQU 16

HEIGHT2:     EQU 16

;  Calculates whether a collision occurs between two objects
;  of a fixed size
; IN: 
;    b = x1
;    c = y1
;    d = x2
;    e = y2
; Constants:
;    WIDTH1, HEIGHT1, WIDTH2, HEIGHT2
; OUT: Carry set if collision
; CHANGES: AF
; CheckCollision_8x8_8x24:

; ;Constants definition:

;         ld      a, d                        ; get x2
;         sub     b                           ; calculate x2 - x1
;         jr      c,.x1IsLarger               ; jump if x2 < x1
;         sub     WIDTH1                      ; compare with size 1
;         ret     nc                          ; return if no collision
;         jp      .checkVerticalCollision
; .x1IsLarger:
;         ;neg                                ; use negative value (Z80)
;         ; emulate neg instruction (Gameboy)
;         ld      b, a
;         xor     a                           ; same as ld a, 0
;         sub     a, b
    
;         sub    WIDTH24                      ; compare with size 2
;         ret    nc                           ; return if no collision

; .checkVerticalCollision:
;         ld      a, e                        ; get y2
;         sub     c                           ; calculate y2 - y1
;         jr      c,.y1IsLarger               ; jump if y2 < y1
;         sub     HEIGHT1                     ; compare with size 1
;         ret                                 ; return collision or no collision
; .y1IsLarger:
;         ;neg                                ; use negative value (Z80)
;         ; emulate neg instruction (Gameboy)
;         ld      c, a
;         xor     a                           ; same as ld a, 0
;         sub     a, c
    
;         sub    HEIGHT2                      ; compare with size 2
;         ret                                 ; return collision or no collision




;  Calculates whether a collision occurs between two objects
;  of a fixed size
; IN: 
;    b = x1
;    c = y1
;    d = x2
;    e = y2
; Constants:
;    WIDTH1, HEIGHT1, WIDTH2, HEIGHT2
; OUT: Carry set if collision
; CHANGES: AF
CheckCollision_8x8_8x8:

        ld      a, d                        ; get x2
        sub     b                           ; calculate x2 - x1
        jr      c,.x1IsLarger               ; jump if x2 < x1
        sub     WIDTH1                      ; compare with size 1
        ret     nc                          ; return if no collision
        jp      .checkVerticalCollision
.x1IsLarger:
        ;neg                                ; use negative value (Z80)
        ; emulate neg instruction (Gameboy)
        ; ld      b, a
        ; xor     a                           ; same as ld a, 0
        ; sub     a, b
        neg     
    
        sub     WIDTH8                      ; compare with size 2
        ret     nc                          ; return if no collision

.checkVerticalCollision:
        ld      a, e                        ; get y2
        sub     c                           ; calculate y2 - y1
        jr      c,.y1IsLarger               ; jump if y2 < y1
        sub     HEIGHT1                     ; compare with size 1
        ret                                 ; return collision or no collision
.y1IsLarger:
        ;neg                                ; use negative value (Z80)
        ; emulate neg instruction (Gameboy)
        ; ld      c, a
        ; xor     a                           ; same as ld a, 0
        ; sub     a, c
        neg     
    
        sub     HEIGHT2                     ; compare with size 2
        ret                                 ; return collision or no collision

