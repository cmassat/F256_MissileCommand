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


POINTER_TXT       = $C0
POINTER_SPR       = $C2
POINTER_CLUT_SRC  = $C4
POINTER_CLUT_DEST = $C6
POINTER_BMP       = $C8
pointer           = $CA
POINTER_FRAME     = $CC
POINTER_LINE      = $CE
POINTER_ICBM      = $D0
POINTER_TX        = $D2
POINTER_SOURCEX   = $D4
POINTER_SOURCEY   = $D6
POINTER_SRC       = $D8
POINTER_DST       = $DA
POINTER_DESTX     = $DC
POINTER_DESTY     = $DE
POINTER_ACTIVE    = $E0
POINTER_CRUISE    = $E2
POINTER_PLANE     = $E4
POINTER_SAUCER    = $E6
POINTER_ABM       = $E8
POINTER_EXP       = $EA
POINTER_EXP_CNT   = $EC
POINTER_ICBM_TBL  = $A0
POINTER_ICBM_LINE  = $A2
POINTER_ICBM_SPEED  = $A4

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
SPRITE_LETTER_I = mSpriteData + (8 * SPRITE_SIZE)
SPRITE_LETTER_J = mSpriteData + (9 * SPRITE_SIZE)
SPRITE_LETTER_K = mSpriteData + (10 * SPRITE_SIZE)
SPRITE_LETTER_L = mSpriteData + (11 * SPRITE_SIZE)
SPRITE_LETTER_M = mSpriteData + (12 * SPRITE_SIZE)
SPRITE_LETTER_N = mSpriteData + (13 * SPRITE_SIZE)
SPRITE_LETTER_O = mSpriteData + (14 * SPRITE_SIZE)
SPRITE_LETTER_P = mSpriteData + (15 * SPRITE_SIZE)
SPRITE_LETTER_Q = mSpriteData + (16 * SPRITE_SIZE)
SPRITE_LETTER_R = mSpriteData + (17 * SPRITE_SIZE)
SPRITE_LETTER_S = mSpriteData + (18 * SPRITE_SIZE)
SPRITE_LETTER_T = mSpriteData + (19 * SPRITE_SIZE)
SPRITE_LETTER_U = mSpriteData + (20 * SPRITE_SIZE)
SPRITE_LETTER_V = mSpriteData + (21 * SPRITE_SIZE)
SPRITE_LETTER_W = mSpriteData + (22 * SPRITE_SIZE)
SPRITE_LETTER_X = mSpriteData + (23 * SPRITE_SIZE)
SPRITE_LETTER_Y = mSpriteData + (24 * SPRITE_SIZE)
SPRITE_LETTER_Z = mSpriteData + (25 * SPRITE_SIZE)

SPRITE_NUMBERS = SPRITE_LETTERS  + (27 * SPRITE_SIZE)

SPRITE_exp0 = mSpriteData + (36 * SPRITE_SIZE)
SPRITE_exp1 = mSpriteData + (37 * SPRITE_SIZE)
SPRITE_exp2 = mSpriteData + (38 * SPRITE_SIZE)
SPRITE_exp3 = mSpriteData + (39 * SPRITE_SIZE)
SPRITE_exp4 = mSpriteData + (40 * SPRITE_SIZE)
SPRITE_exp5 = mSpriteData + (41 * SPRITE_SIZE)

SPRITE_CITY = mSpriteData + (42 * SPRITE_SIZE)
SPRITE_ABM = mSpriteData + (43 * SPRITE_SIZE)
SPRITE_CRUISE = mSpriteData + (45 * SPRITE_SIZE)
SPRITE_DOWN_ARROW = mSpriteData + (46 * SPRITE_SIZE)
SPRITE_REDICLE = mSpriteData + (48 * SPRITE_SIZE)
SPRITE_SAUCERRIGHT = mSpriteData + (56 * SPRITE_SIZE)
SPRITE_SAUCERLEFT = mSpriteData + (57 * SPRITE_SIZE)
SPRITE_PLANE1 = mSpriteData + (58 * SPRITE_SIZE)
SPRITE_PLANE2 = mSpriteData + (59 * SPRITE_SIZE)
SPRITE_PLANE3 = mSpriteData + (60 * SPRITE_SIZE)
SPRITE_PLANE4 = mSpriteData + (61 * SPRITE_SIZE)

BITMAP_START = mBitmapData
BITMAP_STATIC = mBitmapStatic



SPRITENUMBER_ABM0 = 33
SPRITENUMBER_ABM1 = 32
SPRITENUMBER_ABM2 = 31
SPRITENUMBER_CRUISE = 30
SPRITENUMBER_PLANE = 29
SPRITENUMBER_PLANE2 = 28
SPRITENUMBER_SAUCER = 27
SPRITENUMBER_REDICLE= 26
SPRITENUMBER_EXP0 = 25
SPRITENUMBER_EXP1 = SPRITENUMBER_EXP0 - 1
SPRITENUMBER_EXP2 = SPRITENUMBER_EXP1 - 1
SPRITENUMBER_EXP3 = SPRITENUMBER_EXP2 - 1
SPRITENUMBER_EXP4 = SPRITENUMBER_EXP3 - 1
SPRITENUMBER_EXP5 = SPRITENUMBER_EXP4 - 1
SPRITENUMBER_EXP6 = SPRITENUMBER_EXP5 - 1
SPRITENUMBER_EXP7 = SPRITENUMBER_EXP6 - 1

EXPLOSION_CLR = 48
MISSLE_CLR = 112
ICBM_HEAD = 122
ABM_CLR = 4
APLHA_CLR = 8



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
