UpdateDiamondDisappearingAnimation:
    
    ; Check if anmiation is active
    ld      a, (DiamondDisappearing_FrameNumber)
    or      a
    ret     z

    ; Update counter
    ld      a, (DiamondDisappearing_Counter)
    inc     a
    cp      3
    jp      z, .nextFrame

    ld      (DiamondDisappearing_Counter), a
    ret

    ; Go to next animation frame only at n frames
.nextFrame:
    xor     a
    ld      (DiamondDisappearing_Counter), a
    
    ld      a, (DiamondDisappearing_FrameNumber)
    add     4
    cp      DIAMOND_DISAPPEARING_LAST_FRAME + 4
    jp      z, .endAnimation

    ld      (DiamondDisappearing_FrameNumber), a

    ret

.endAnimation:
    xor     a
    ld      (DiamondDisappearing_FrameNumber), a
    ld      (DiamondDisappearing_X), a
    ld      a, 192
    ld      (DiamondDisappearing_Y), a
    ret