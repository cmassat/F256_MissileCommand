MMU_MEM_CTRL = $0000
MMU_IO_CTRL  = $0001
CLUT_IO = $0001
CLUT_0_ADDR = $D000
CLUT_1_ADDR = $D400
CLUT_2_ADDR = $D800
CLUT_3_ADDR = $DC00

MMU_BANK_0_REG = $08
MMU_BANK_1_REG = $09
MMU_BANK_2_REG = $0A
MMU_BANK_3_REG = $0B
MMU_BANK_4_REG = $0C
MMU_BANK_5_REG = $0D
MMU_BANK_6_REG = $0E
MMU_BANK_7_REG = $0F
MMU_MLUT_TABLE = $08

;Registers
VCKY_CTRL = $D000
VCKY_CTRL_ATTRIB = $D001
VCKY_LAYER_01_00_CTRL = $D002
VCKY_LAYER_02_CTRL = $D003
VKY_BKG_COL_B = $D00D ; Vicky Graphics Background Color Blue
VKY_BKG_COL_G = $D00E ; Vicky Graphics Background Color Green
VKY_BKG_COL_R = $D00F
VKY_BRDR_CTRL = $D004
FOREGROUND_COLOR = $D800
BACKGROUND_COLOR = $D840

POINTER_FILE = $CE
POINTER_MMU = $BC
POINTER_TXT = $A0
POINTER_SPR = $A2
POINTER_SPR_X = $A4
POINTER_SPR_Y = $A6
POINTER_SRC = $A6
POINTER_DST = $A8
POINTER_SCROLL_X = $A0
POINTER_SCROLL_Y = $A2
POINTER_CLUT_SRC = $A4
POINTER_CLUT_DEST = $A6
POINTER_UTIL = $A8
POINTER_TILE = $B0
POINTER_SET = $B2
POINTER_BMP = $B4
pointer = $B6
POINTER_PSG = $B8
POINTER_FRAME = $C0

POINTER_JMP = $C2
POINTER_STATUS = $C4
POINTER_MOVE = $C6
POINTER_INIT = $C8
POINTER_LINE = $D0
POINTER_ICBM = $D2
POINTER_TX = $D4
POINTER_SOURCEX = $D6
POINTER_SOURCEY = $D8
POINTER_DESTX = $DA
POINTER_DESTY = $DC

SPRITE_SIZE = 16*16
SPRITE_START = mSpriteData
SPRITE_LETTERS = mSpriteData
SPRITE_LETTER_A = mSpriteData
SPRITE_LETTER_B = mSpriteData + (1 * SPRITE_SIZE)
SPRITE_LETTER_C = mSpriteData + (2 * SPRITE_SIZE)
SPRITE_LETTER_D = mSpriteData + (3 * SPRITE_SIZE)
SPRITE_LETTER_E = mSpriteData + (4 * SPRITE_SIZE)
SPRITE_LETTER_F = mSpriteData + (5 * SPRITE_SIZE)
SPRITE_LETTER_G = mSpriteData + (6 * SPRITE_SIZE)
SPRITE_LETTER_H = mSpriteData + (7 * SPRITE_SIZE)
SPRITE_LETTER_I = mSpriteData + (9 * SPRITE_SIZE)
SPRITE_LETTER_J = mSpriteData + (10 * SPRITE_SIZE)
SPRITE_LETTER_K = mSpriteData + (11 * SPRITE_SIZE)
SPRITE_LETTER_L = mSpriteData + (12 * SPRITE_SIZE)
SPRITE_LETTER_M = mSpriteData + (13 * SPRITE_SIZE)
SPRITE_LETTER_N = mSpriteData + (14 * SPRITE_SIZE)
SPRITE_LETTER_O = mSpriteData + (15 * SPRITE_SIZE)
SPRITE_LETTER_P = mSpriteData + (16 * SPRITE_SIZE)
SPRITE_LETTER_Q = mSpriteData + (17 * SPRITE_SIZE)
SPRITE_LETTER_R = mSpriteData + (18 * SPRITE_SIZE)
SPRITE_LETTER_S = mSpriteData + (19 * SPRITE_SIZE)
SPRITE_LETTER_T = mSpriteData + (20 * SPRITE_SIZE)
SPRITE_LETTER_U = mSpriteData + (21 * SPRITE_SIZE)
SPRITE_LETTER_V = mSpriteData + (22 * SPRITE_SIZE)
SPRITE_LETTER_W = mSpriteData + (23 * SPRITE_SIZE)
SPRITE_LETTER_X = mSpriteData + (24 * SPRITE_SIZE)
SPRITE_LETTER_Y = mSpriteData + (25 * SPRITE_SIZE)
SPRITE_LETTER_Z = mSpriteData + (26 * SPRITE_SIZE)

SPRITE_NUMBERS = SPRITE_LETTERS  + (27 * SPRITE_SIZE)

SPRITE_CITY = mSpriteData + (42 * SPRITE_SIZE)

SPRITE_DOWN_ARROW = mSpriteData + (46 * SPRITE_SIZE)

BITMAP_START = mBitmapData


PSG_2A	      = $3F6
PSG_2A_SHRP	  = $3BD
PSG_2B	      = $387
PSG_3C	      = $354
PSG_3C_SHRP   = $324
PSG_3D	      = $2F7
PSG_3D_SHRP	  = $2CD
PSG_3E	      = $2A4
PSG_3F	      = $27E
PSG_3F_SHRP	  = $25B
PSG_3G	      = $239
PSG_3G_SHRP	  = $219
PSG_3A	      = $1FB
PSG_3A_SHRP	  = $1DE
PSG_3B	      = $1C3
PSG_4C		  = $1AA
PSG_4C_SHRP	  = $192
PSG_4D		  = $17B
PSG_4D_SHRP	  = $166
PSG_4E		  = $152
PSG_4F		  = $13F
PSG_4F_SHRP	  = $12D
PSG_4G		  = $11C
PSG_4G_SHRP	  = $10C
PSG_4A		  = $FD
PSG_4A_SHRP	  = $EF
PSG_4B		  = $E1
PSG_5C		  = $D5
PSG_5C_SHRP	  = $C9
PSG_5D		  = $BD
PSG_5D_SHRP	  = $B3
PSG_5E		  = $A9
PSG_5F		  = $9F
PSG_5F_SHRP	  = $96
PSG_5G		  = $8E
PSG_5G_SHRP	  = $86
PSG_5A		  = $7E
PSG_5A_SHRP	  = $77
PSG_5B		  = $70
PSG_6C		  = $6A
PSG_6C_SHRP	  = $64
