TileColors_Black_Start:
        db  0x01
        db  0x01
        db  0x01
        db  0x01
        db  0x01
        db  0x01
        db  0x01
        db  0x01
TileColors_Black_End:



TileColors_SmallBricks_Top_Start:
        db  0x01
        db  0x71
        db  0x51
        db  0x51
        db  0x01
        db  0x71
        db  0x51
        db  0x51
TileColors_SmallBricks_Top_End:

TileColors_SmallBricks_Bottom_Start:
        db  0x01
        db  0x51
        db  0x41
        db  0x41
        db  0x01
        db  0x51
        db  0x41
        db  0x41
TileColors_SmallBricks_Bottom_End:



TileColors_BigBricks_Top_Start:
    INCLUDE "Graphics/Tiles/Colors/Color_BigBricks_top_left.s"
TileColors_BigBricks_Bottom_Start:
    INCLUDE "Graphics/Tiles/Colors/Color_BigBricks_bottom_left.s"



TileColors_Grass_Top_Start:
    INCLUDE "Graphics/Tiles/Colors/Color_Grass_top_left.s"
TileColors_Grass_Bottom_Start:
    INCLUDE "Graphics/Tiles/Colors/Color_Grass_bottom_left.s"



TileColors_Rocks_Top_Start:
    INCLUDE "Graphics/Tiles/Colors/Color_Rocks_top_left.s"
TileColors_Rocks_Bottom_Start:
    INCLUDE "Graphics/Tiles/Colors/Color_Rocks_bottom_left.s"

