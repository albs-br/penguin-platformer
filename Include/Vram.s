; VRAM memory mapping (Screen 2)
NamesTable:	        equ 6144	; 0x1800 - Base address for names table (6144 to 6911); 256 * 3 = 768 bytes
PatternsTable:	    equ 0	    ; 0x0000 - Base address for 3 patterns tables (0 to 6143); 256 * 8 * 3 = 6144 bytes
ColorsTable:	    equ 8192	; 0x2000 - Base address for colors table (8192 to 14335); 256 * 8 * 3 = 6144 bytes

{
Sprite attr table: 6912
sprite 0:
      6192 Y
	  6193 X
	  6194 N
	  6195 C
sprite 1:
      6196 Y
(...)

Sprite formation table: 14336
}
SpriteAttrTable:    equ 6912	; 0x1b00 - Base address for sprite attributes table (6912 to 7040); 32 * 4 = 128 bytes
SpritePatternTable: equ 14336	; 0x3800 - Base address for sprite patterns table (14336 to 16383); 256 * 8 = 2048 bytes for 8x8, 64 * 32 = 2048 bytes for 16x16
