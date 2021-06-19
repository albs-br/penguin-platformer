    INCLUDE "Graphics/Tiles/Patterns/PatternTableStructure.s"



;TilePatterns_Start:

    TilePatterns_Black_Start:
        INCLUDE "Graphics/Tiles/Patterns/Black.s"

    TilePatterns_SmallBricks_Start:
        INCLUDE "Graphics/Tiles/Patterns/SmallBricks.s"
    
    TilePatterns_BigBricks_Start:
        INCLUDE "Graphics/Tiles/Patterns/Pattern_BigBricks.s"
        ;INCLUDE "Graphics/Tiles/Patterns/Pattern_TestSquare.s"
    
    TilePatterns_Grass_Start:
        INCLUDE "Graphics/Tiles/Patterns/Pattern_Grass.s"
    
    TilePatterns_Rocks_Start:
        INCLUDE "Graphics/Tiles/Patterns/Pattern_Rocks.s"
    
    TilePatterns_Diamonds_Start:
        INCLUDE "Graphics/Tiles/Patterns/Pattern_Diamonds.s"

    ; Enemy Ladybug
    TilePatterns_Enemy_Ladybug_Left_Start:
        INCLUDE "Graphics/Tiles/Patterns/Pattern_EnemyLadybug_Left.s"
    TilePatterns_Enemy_Ladybug_Right_Start:
        INCLUDE "Graphics/Tiles/Patterns/Pattern_EnemyLadybug_Right.s"

    ; Enemy Snail
    TilePatterns_Enemy_Snail_Left_Start:
        INCLUDE "Graphics/Tiles/Patterns/Pattern_EnemySnail_Left.s"
    TilePatterns_Enemy_Snail_Right_Start:
        INCLUDE "Graphics/Tiles/Patterns/Pattern_EnemySnail_Right.s"



TILE_PENGUIN_FACE_DETAILS:      equ     255

    TilePatterns_Score_PenguinFace:
        INCLUDE "Graphics/Tiles/Patterns/Score_PenguinFace.s"
    .size:                      equ     $ - TilePatterns_Score_PenguinFace
;TilePatterns_End:


