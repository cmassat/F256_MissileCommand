*=$1000
.dsection variables

*=$2000
.dsection code 


.section code
start
    jmp main
.include "api/include.asm"
.include "events.asm"
main
    stz MMU_IO_CTRL

    lda #0
    sta MMU_IO_CTRL
    jsr clearScreenMemory
    jsr clut_load_0
    stz mMoveMisleFrame

    jsr clearVideo
    jsr enableText
    jsr enableBitmap
    jsr enableGrafix
    jsr enableSprite
    jsr setVideo
    jsr setBackgroundColor
    jsr setBitmapLayer0
    jsr setLayers


    lda #0
    jsr setSpriteNumber

    lda #<SPRITE_LETTERS
    ldx #>SPRITE_LETTERS
    ldy #`SPRITE_LETTERS
    jsr setSpriteAddress


    lda <#100
    ldx >#100
    jsr setSpriteX

    lda <#100
    ldx >#100
    jsr setSpriteY

    jsr showSprite

    lda #0
    jsr setBitmapNumber

    lda #<BITMAP_START
    ldx #>BITMAP_START
    ldy #`BITMAP_START
    jsr setBitmapAddress

    lda #0
    jsr setBitmapClut

    jsr showBitmap

    lda <#300
    ldx >#300
    jsr setOrginX
    lda <#0
    ldx >#0
    jsr setOrginY

    lda <#100
    ldx >#100
    jsr setDestX
    lda <#200
    ldx >#200
    jsr setDestY
    jsr putPixel
    jsr lineInit
    jsr getLineData
   ; jsr do_line

    jsr initEvents
    jsr setFrameTimer
    jsr handleEvents
_loop
    jmp _loop
    rts

getLineData
    jsr getOrginX
    sta mx
    stx mx + 1
    jsr getOrginY
    sta my
    stx my + 1
    jsr getDestX
    jsr getDestY
    jsr getAi
    sta mAi
    stx mAi + 1
    jsr getBi
    sta mBi
    stx mBi + 1
    jsr getD
    sta mD
    stx mD + 1
    jsr getDx
    sta mDx
    stx mDx + 1
    jsr getDy
    sta mDy
    stx mDy + 1

    jsr getXDir
    sta mxdirection

    jsr getYDir
    sta mydirection


    jsr getSteep
    sta mS
    rts

moveMissle
    lda my + 1
    cmp #0
    bne _move
_checkLo
    lda my
    cmp #200
    bne _move
    rts
_move
    lda mMoveMisleFrame
    cmp #wave1
    beq _nextPixel
    inc mMoveMisleFrame
    rts
_nextPixel
    stz mMoveMisleFrame
    lda mx
    ldx mx + 1
    jsr setOrginX

    lda my
    ldx my + 1
    jsr setOrginY

    lda mAi
    ldx mAi + 1
    jsr setAi

    lda mBi
    ldx mBi + 1
    jsr setBi

    lda mD
    ldx mD + 1
    jsr setD

    lda mDx
    ldx mDx + 1
    jsr setDx

    lda mDy
    ldx mDy + 1
    jsr setDy

    lda mS
    jsr setSteep

    lda mxdirection
    jsr setXDir

    lda mydirection
    jsr setYDir

    jsr linestep
    jsr getLineData
    jsr putPixel
    rts
.section variables
wave1 = 5
mMoveMisleFrame
    .byte $00
mx
    .byte $00, $00
my
    .byte $00, $00
mAi
    .byte $00, $00
mBi
    .byte $00, $00
mD
    .byte $00, $00
mDx
    .byte $00, $00
mDy
    .byte $00, $00
mS
    .byte $00
mxdirection
    .byte $00
mydirection
    .byte $00
.endsection
.endsection
*=$a000
.binary "../assets/sprite.pal"

*=$10000
mBitmapData
.binary "../assets/bitmap.bin"
mSpriteData
.binary "../assets/sprite.bin"

