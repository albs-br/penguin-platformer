UpdateSparklesAnimation:
    
    ; Check if anmiation is active
    ld      a, (Sparkles_FrameNumber)
    or      a
    ret     z

    ; Update counter
    ld      a, (Sparkles_Counter)
    inc     a
    cp      3
    jp      z, .nextFrame

    ld      (Sparkles_Counter), a
    ret

    ; Go to next animation frame only at n frames
.nextFrame:
    xor     a
    ld      (Sparkles_Counter), a
    
    ld      a, (Sparkles_FrameNumber)
    add     4
    cp      SPARKLES_LAST_FRAME + 4
    jp      z, .endAnimation

    ld      (Sparkles_FrameNumber), a

    ret

.endAnimation:
    xor     a
    ld      (Sparkles_FrameNumber), a
    ld      (Sparkles_X), a
    ld      a, 192
    ld      (Sparkles_Y), a
    ret