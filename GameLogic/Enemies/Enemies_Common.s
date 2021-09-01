; Check if enemy hit penguin
; IN: 
;    E = Enemy Y, D = Enemy X
; OUT: 
;    A = 0 not hit
;    A = 1 hit
; CHANGES: AF
CheckIfEnemyHitPenguin:

    ld      h, d        ; saves Enemy X

    ; --------------------------------------------
    ;  Check collision (enemy hit penguin)
    ; Player (x + 3, y + 2) - (x + 12, y + 15) ; width = 10 ; height = 14
    ; Enemy  (x + 2, y + 12) - (x + 13, y + 15) ; width = 12 ; height = 4
    ld      a, (Player_Y)
    ;inc     a                                   ; small adjust needed (is it because of the y+1 issue of TMS9918?)
    add     2
    ld      c, a
    ld      b, 14                               ; height = 14

    ; ld      a, (UpdateBgObjects_Enemy_TypeB_n_Y)
    ld      a, e
    add     12
    ld      e, a
    ld      d, 8                                ; height = 4

    ; first check vertical collision, saving the next block (130 cycles), plus 57/62 of the subroutine if no collision
    call    CheckCollision_W1xH1_W2xH2_Vertical
    jp      nc, .enemyDidNotHitPenguin


    ld      a, (Player_X)
    add     3
    ld      b, a
    ld      c, 10                               ; width = 10

    ; ld      a, (UpdateBgObjects_Enemy_TypeB_n_X)
    ld      a, h        ; restores Enemy X
    add     2
    ld      d, a
    ld      e, 12                               ; width = 12

    call    CheckCollision_W1xH1_W2xH2_Horizontal
    jp      nc, .enemyDidNotHitPenguin

    ; enemy hit penguin
    xor     a
    ld      (Player_IsAlive), a

    inc     a
    ld      (Player_DeathAnimation), a

    ; TODO: put it in a subroutine, as it is repeated in many places
    ; start hit flash animation
    ld      a, HIT_FLASH_FIRST_FRAME
    ld      (HitFlash_FrameNumber), a
    ld      a, (Player_Y)
    ld      (HitFlash_Y), a
    ld      a, (Player_X)
    ld      (HitFlash_X), a
    xor     a
    ld      (HitFlash_Counter), a

    ;jp      .return
    ld      a, 1            ; return 0 (hit)
    ret

.enemyDidNotHitPenguin:
    xor     a               ; return 0 (not hit)
    ret