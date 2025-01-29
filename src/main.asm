*=$1000
.dsection variables

*=$2000
.dsection code 


.section code
start
    jmp main
.include "api/include.asm"
.include "events.asm"
.include "splash.asm"
.include "state.asm"
.include "menu.asm"
.include "init.asm"
.include "psgSounds.asm"
.include "cities.asm"
.include "score.asm"
.include "wave1.asm"
.include "icbm.asm"
.include "debug.asm"
main
    stz MMU_IO_CTRL
    jsr initGame


    ; stz mMoveMisleFrame

    ; jsr clearVideo
    ; jsr enableText
    ; jsr enableBitmap
    ; jsr enableGrafix
    ; jsr enableSprite
    ; jsr setVideo
    ; jsr setBackgroundColor
    ; jsr setBitmapLayer0
    ; jsr setLayers


    ; lda #0
    ; jsr setSpriteNumber

    ; lda #<SPRITE_NUMBERS
    ; ldx #>SPRITE_NUMBERS
    ; ldy #`SPRITE_NUMBERS
    ; jsr setSpriteAddress


    ; lda <#32
    ; ldx >#32
    ; jsr setSpriteX

    ; lda <#32
    ; ldx >#32
    ; jsr setSpriteY
    ; jsr showSprite

    ; lda #1
    ; jsr setSpriteNumber

    ; lda #<SPRITE_NUMBERS + SPRITE_SIZE
    ; ldx #>SPRITE_NUMBERS + SPRITE_SIZE
    ; ldy #`SPRITE_NUMBERS + SPRITE_SIZE
    ; jsr setSpriteAddress


    ; lda <#32 + 16
    ; ldx >#32 + 16
    ; jsr setSpriteX

    ; lda <#32
    ; ldx >#32
    ; jsr setSpriteY

    ; jsr showSprite

    ; lda #0
    ; jsr setBitmapNumber

    ; lda #<BITMAP_START
    ; ldx #>BITMAP_START
    ; ldy #`BITMAP_START
    ; jsr setBitmapAddress

    ; lda #0
    ; jsr setBitmapClut

    ; jsr showBitmap

    ; lda <#300
    ; ldx >#300
    ; jsr setOrginX
    ; lda <#0
    ; ldx >#0
    ; jsr setOrginY

    ; lda <#100
    ; ldx >#100
    ; jsr setDestX
    ; lda <#200
    ; ldx >#200
    ; jsr setDestY
    ; jsr putPixel
    ; jsr lineInit
    ; jsr getLineData
   ; jsr do_line

    jsr initEvents
    jsr setFrameTimer
    jsr handleEvents
_loop
    jmp _loop
    rts




.section variables
; wave1 = 5
; mMoveMisleFrame
;     .byte $00
; mx
;     .byte $00, $00
; my
;     .byte $00, $00
; mAi
;     .byte $00, $00
; mBi
;     .byte $00, $00
; mD
;     .byte $00, $00
; mDx
;     .byte $00, $00
; mDy
;     .byte $00, $00
; mS
;     .byte $00
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
*=$1F000

.binary "../assets/bitmap.bin"
mSpriteData
.binary "../assets/sprite.bin"

