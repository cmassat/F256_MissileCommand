
.section code 
clearVideo
    lda #0
    sta VCKY_CTRL
    sta VCKY_CTRL_ATTRIB
    sta mVideoCtrl
    rts

enableText
    lda mVideoCtrl
    ora #%00000011
    sta mVideoCtrl
    rts

enableSprite
    lda mVideoCtrl
    ora #%00100100
    sta mVideoCtrl
    rts

enableTile
    lda mVideoCtrl
    ora #%00010000
    sta mVideoCtrl
    rts

enableBitmap
    lda mVideoCtrl
    ora #%00001000
    sta mVideoCtrl
    rts

enableGrafix
    lda mVideoCtrl
    ora #%0000100
    sta mVideoCtrl
    rts

enableTextOverlay
    lda mVideoCtrl
    ora #%00000011
    sta mVideoCtrl
    rts

setVideo
    lda mVideoCtrl
    sta VCKY_CTRL
    rts

clearLayers
    lda #0
    sta VCKY_LAYER_01_00_CTRL
    sta VCKY_LAYER_02_CTRL
    sta mVideoLayerCtrl01
    sta mVideoLayerCtrl_2
    rts

setBitmapLayer0
    lda mVideoLayerCtrl01
    and #$f0
    ora #$00
    sta mVideoLayerCtrl01
    rts 

setBitmapLayer1
    lda mVideoLayerCtrl01
    and #$0f
    ora #$10
    sta mVideoLayerCtrl01
    rts

setBitmapLayer2
    lda #$02
    sta mVideoLayerCtrl_2
    rts 

setTileMapLayer0
    lda mVideoLayerCtrl01
    and #$F0
    ora #$04
    sta mVideoLayerCtrl01
    rts

setTileMapLayer1
    lda mVideoLayerCtrl01
    and #$0F
    ora #$50
    sta mVideoLayerCtrl01
    rts

setTileMapLayer2
    lda #$06
    sta mVideoLayerCtrl_2
    rts    

setDoubleText
    lda #%00000110
    sta VCKY_CTRL_ATTRIB
    rts

setLayers
    lda mVideoLayerCtrl01
    sta VCKY_LAYER_01_00_CTRL
    
    lda mVideoLayerCtrl_2
    sta VCKY_LAYER_02_CTRL
    rts

showBorder
    lda #1
    sta VKY_BRDR_CTRL
    lda #22
    sta $D005
    sta $D006
    sta $D007
    lda #10
    sta $D008
    sta $D009
    rts

loadDefaultPalette
    jsr loadDefaultPaletteBak
    jsr loadDefaultPaletteFor
    rts

loadDefaultPaletteBak
    LDA #0
    stA MMU_IO_CTRL
    lda mColorPalette
    sta POINTER_CLUT_SRC

    lda mColorPalette + 1
    sta POINTER_CLUT_SRC+1

    lda #<$D840
    sta POINTER_CLUT_DEST
    lda #>$D840
    sta POINTER_CLUT_DEST+1

    ldx #0
_clut_row
    ldy #0
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y

    lda POINTER_CLUT_SRC
    clc
    adc #4
    sta POINTER_CLUT_SRC

    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

     lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST

    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx #$16
    bne _clut_row

    stz MMU_IO_CTRL

loadDefaultPaletteFor
    stz MMU_IO_CTRL
    lda #<mColorPalette
    sta POINTER_CLUT_SRC

    lda #>mColorPalette
    sta POINTER_CLUT_SRC+1

    lda #<$D800
    sta POINTER_CLUT_DEST
    lda #>$D800
    sta POINTER_CLUT_DEST+1

    ldx #0
_clut_row
    ldy #0
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y

    lda POINTER_CLUT_SRC
    clc
    adc #4
    sta POINTER_CLUT_SRC

    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

     lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST

    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx #$16
    bne _clut_row

    stz MMU_IO_CTRL
    rts


setBackgroundColor
    sta VKY_BKG_COL_B
    stx VKY_BKG_COL_G
    sty VKY_BKG_COL_R

    ;sta MMU_IO_CTRL
    rts

setForegroungColor
    lda #3
    sta MMU_IO_CTRL
    lda #$22
    ldy #0
_loop
    sta $C000, y
    sta $C000 + $ff, y
    sta $C000 + $ff + $ff , y
    sta $C000 + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $80,  y
    iny
    cpy #0
    bne _loop
    stz MMU_IO_CTRL
    rts

clearScreenMemory
    pha
    phx
    phy
    lda #2
    sta MMU_IO_CTRL
    lda #' '
    ldy #0
_loop
    sta $C000, y
    sta $C000 + $ff, y
    sta $C000 + $ff + $ff , y
    sta $C000 + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff,  y
    sta $C000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $80,  y
    iny
    cpy #0
    bne _loop
    stz MMU_IO_CTRL 
    ply
    plx
    pla
    rts
.endsection

.section variables
black = 00
white = 01
red = 02
cyan = 03
violet = 04
green = 05
blue = 06
yellow = 07
lt_brown = 08
dk_brown = 09
pink = 10
dk_grey = 11
md_grey = 12
lt_green = 13
lt_purple = 14
lt_grey = 15
mVideoCtrl
    .byte $00

mVideoLayerCtrl01
    .byte $00
mVideoLayerCtrl_2
    .byte $00

mColorPalette
.byte $00,$00,$00,$00 ;00 black
.byte $ff,$ff,$ff,$62 ;01 white
.byte $32,$39,$88,$00 ;02 red
.byte $67,$b6,$67,$00 ;03 cyan
.byte $ff,$00,$ff,$00 ;04 violet
.byte $49,$a0,$55,$00 ;05 green
.byte $ff,$00,$00,$00 ;06 blue
.byte $72,$ce,$bf,$00 ;07 yellow
.byte $29,$54,$8b,$00 ;08 lt brown
.byte $00,$42,$57,$00 ;09 dk brown
.byte $b8,$69,$62,$00 ;10 pink
.byte $50,$50,$50,$00 ;11 dark grey
.byte $78,$78,$78,$00 ;12 md grey
.byte $89,$e0,$94,$00 ;13 lt green
.byte $69,$c4,$78,$00 ;14 lt purple
.byte $9f,$9f,$9f,$00 ;15 lt grey
.endsection