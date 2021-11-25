; Formatting rules for BgObjects file on "TileMaps\TileMaps_Constants.s"
BgObjectsInitialState_TestLevel_2_Start:

; Screen #0
	db      13,     DIAMOND_FIRST_TILE,          7 * 2 * 8,      1,  0,  0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      15,     DIAMOND_FIRST_TILE,          7 * 2 * 8,      1,  0,  0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      13,     DIAMOND_FIRST_TILE,          9 * 2 * 8,      1,  0,  0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 0)), 0                 ; fill with 0s until end of block

; Screen #1
	db      18,     DIAMOND_FIRST_TILE,          4 * 2 * 8,      1,  0,  0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      19,     DIAMOND_FIRST_TILE,          5 * 2 * 8,      1,  0,  0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      17,     DIAMOND_FIRST_TILE,          6 * 2 * 8,      1,  0,  0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      18,     DIAMOND_FIRST_TILE,          7 * 2 * 8,      1,  0,  0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      24,     SCENERY,          7 * 2 * 8,      1,  0,  SCENERY_TYPE_BUSH,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      18,     DIAMOND_FIRST_TILE,          9 * 2 * 8,      1,  0,  0,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      29,     ENEMY_TYPE_A,          10 * 2 * 8,      1,  0,  ENEMY_TYPE_LADYBUG_LEFT,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 256)), 0                 ; fill with 0s until end of block

; Screen #2
	db      34,     ENEMY_TYPE_A,          10 * 2 * 8,      1,  0,  ENEMY_TYPE_SNAIL_LEFT,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      45,     ENEMY_TYPE_B,          10 * 2 * 8,      1,  0,  ENEMY_TYPE_DINO_LEFT,    (10 * 2 * 8) + 14,  (10 * 2 * 8) - 5,  0,  0,  0,  0,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 512)), 0                 ; fill with 0s until end of block

; Screen #3
	db      51,     ENEMY_TYPE_B,          9 * 2 * 8,      1,  0,  ENEMY_TYPE_ARMADILLO_LEFT,    (9 * 2 * 8) + 9,  (9 * 2 * 8) - 7,  0,  0,  0,  0,  0,  0,  0,  0
	db      55,     SCENERY,          10 * 2 * 8,      1,  0,  SCENERY_TYPE_FENCE,    0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	db      63,     ENEMY_TYPE_B,          10 * 2 * 8,      1,  0,  ENEMY_TYPE_CENTIPEDE_LEFT,    (10 * 2 * 8) + 15,  (10 * 2 * 8) - 4,  0,  0,  0,  0,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 768)), 0                 ; fill with 0s until end of block

; Screen #4
	db      72,     ENEMY_TYPE_B,          9 * 2 * 8,      1,  0,  ENEMY_TYPE_ELEPHANT_LEFT,    (9 * 2 * 8) + 15,  (9 * 2 * 8) - 5,  0,  0,  0,  0,  0,  0,  0,  0
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 1024)), 0                 ; fill with 0s until end of block

; Screen #5
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 1280)), 0                 ; fill with 0s until end of block

; Screen #6
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 1536)), 0                 ; fill with 0s until end of block

; Screen #7
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 1792)), 0                 ; fill with 0s until end of block

; Screen #8
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 2048)), 0                 ; fill with 0s until end of block

; Screen #9
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 2304)), 0                 ; fill with 0s until end of block

; Screen #10
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 2560)), 0                 ; fill with 0s until end of block

; Screen #11
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 2816)), 0                 ; fill with 0s until end of block

; Screen #12
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 3072)), 0                 ; fill with 0s until end of block

; Screen #13
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 3328)), 0                 ; fill with 0s until end of block

; Screen #14
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 3584)), 0                 ; fill with 0s until end of block

; Screen #15
	ds     256 - ($ - (BgObjectsInitialState_TestLevel_2_Start + 3840)), 0                 ; fill with 0s until end of block

BgObjectsInitialState_TestLevel_2_End:
