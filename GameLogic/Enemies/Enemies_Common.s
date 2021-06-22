EnemiesCounterRoutine:
    ld      a, (Enemies_Counter)
    cp      2
    jp      z, .enemy_3
    cp      1
    jp      z, .enemy_2
; enemy 1
    ld      a, TILE_POSITION_ON_NAMTBL_ENEMY_1
    ld      (UpdateBgObjects_VRAM_NamesTable_Position), a
    
    ld      hl, VRAM_COLORS_TABLE_ADDR_ENEMY_1
    ld      (UpdateBgObjects_VRAM_ColorsTable_Addr), hl
    
    ld      hl, Enemy_1_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl

    ld      hl, VRAM_PATTERN_TABLE_ADDR_ENEMY_1
    ld      (Temp_Addr), hl

    ;jp      .copyEnemyPropertiesToTempVars
    ret
.enemy_3:
    ld      a, TILE_POSITION_ON_NAMTBL_ENEMY_3
    ld      (UpdateBgObjects_VRAM_NamesTable_Position), a
    
    ld      hl, VRAM_COLORS_TABLE_ADDR_ENEMY_3
    ld      (UpdateBgObjects_VRAM_ColorsTable_Addr), hl
    
    ld      hl, Enemy_3_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl

    ld      hl, VRAM_PATTERN_TABLE_ADDR_ENEMY_3
    ld      (Temp_Addr), hl

    ;jp      .copyEnemyPropertiesToTempVars
    ret
.enemy_2:
    ld      a, TILE_POSITION_ON_NAMTBL_ENEMY_2
    ld      (UpdateBgObjects_VRAM_NamesTable_Position), a
    
    ld      hl, VRAM_COLORS_TABLE_ADDR_ENEMY_2
    ld      (UpdateBgObjects_VRAM_ColorsTable_Addr), hl
    
    ld      hl, Enemy_2_BaseAddress                         ; source
    ld      (UpdateBgObjects_Enemy_Return_Addr), hl

    ld      hl, VRAM_PATTERN_TABLE_ADDR_ENEMY_2
    ld      (Temp_Addr), hl

    ret
;.copyEnemyPropertiesToTempVars:
