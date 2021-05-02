UpdateAnimations:

; -------------- Sparkles animation ----------------------
    ; Check if animation is active
    ld      a, (Sparkles_FrameNumber)
    or      a
    jp      z, .continue

    ; Update counter
    ld      a, (Sparkles_Counter)
    inc     a
    cp      3                               ; one animation frame at each 3 screen frames
    jp      z, .sparkles_NextFrame

    ld      (Sparkles_Counter), a
    jp      .continue

    ; Go to next animation frame only at n frames
.sparkles_NextFrame:
    xor     a
    ld      (Sparkles_Counter), a
    
    ld      a, (Sparkles_FrameNumber)
    add     4                               ; next sprite
    cp      SPARKLES_LAST_FRAME + 4
    jp      z, .sparkles_EndAnimation

    ld      (Sparkles_FrameNumber), a
    jp      .continue

.sparkles_EndAnimation:
    xor     a
    ld      (Sparkles_FrameNumber), a
    ld      (Sparkles_X), a
    ld      a, 192
    ld      (Sparkles_Y), a
    ;ret

.continue:
; -------------- Hit flash animation ----------------------
    ; Check if animation is active
    ld      a, (HitFlash_FrameNumber)
    or      a
    ret     z

    ; Update counter
    ld      a, (HitFlash_Counter)
    inc     a
    cp      4                               ; one animation frame at each 4 screen frames
    jp      z, .hitFlash_NextFrame

    ld      (HitFlash_Counter), a
    ret

    ; Go to next animation frame only at n frames
.hitFlash_NextFrame:
    xor     a
    ld      (HitFlash_Counter), a
    
    ld      a, (HitFlash_FrameNumber)
    add     4                               ; next sprite
    cp      HIT_FLASH_LAST_FRAME + 4
    jp      z, .hitFlash_EndAnimation

    ld      (HitFlash_FrameNumber), a
    ret

.hitFlash_EndAnimation:
    xor     a
    ld      (HitFlash_FrameNumber), a
    ld      (HitFlash_X), a
    ld      a, 192
    ld      (HitFlash_Y), a
    ret
