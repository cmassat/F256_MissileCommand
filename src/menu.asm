menu  .namespace
showSpriteMacro .macro spriteNum, spriteAddr, x, y
    lda #\spriteNum
    jsr setSpriteNumber

    lda <#\spriteAddr
    ldx >#\spriteAddr
    ldy `#\spriteAddr
    jsr setSpriteAddress

    lda <#\x
    ldx >#\x
    jsr setSpriteX

    lda <#\y
    ldx >#\y
    jsr setSpriteY
    jsr showSprite

.endmacro
.section code
handle

    lda #state.menu
    jsr state.is
    bcc _ok
    rts
_ok
    lda #stateBegin
    jsr is
    bcc _begin

    lda #stateDemo
    jsr is
    bcc _demo
    bra _demo
    rts
_begin
    jsr begin
    rts
_demo
    jsr demo
    rts

begin
    lda #8
    jsr clearMemory
    lda #9
    jsr clearMemory
    lda #10
    jsr clearMemory
    lda #11
    jsr clearMemory
    lda #12
    jsr clearMemory
    lda #13
    jsr clearMemory
    lda #14
    jsr clearMemory
    lda #15
    jsr clearMemory

    lda #18
    jsr clearMemory
    lda #19
    jsr clearMemory
    lda #20
    jsr clearMemory
    lda #21
    jsr clearMemory
    lda #22
    jsr clearMemory
    lda #23
    jsr clearMemory
     lda #24
    jsr clearMemory
    lda #25
    jsr clearMemory


    ; jsr clearExtMem


    jsr psg.playExplosion
    jsr hideAllSprites

    lda #0
    ldx #0
    ldy #0
    jsr setBackgroundColor
    jsr clearVideo
    jsr enableText
    jsr enableGrafix
    jsr enableSprite
    jsr enableBitmap
    jsr setVideo
    jsr clearLayers

    jsr clut_load_0


   ; jsr clearExtMem
    ; lda #0
    ; jsr setBitmapNumber


    ; lda #<BITMAP_START
    ; ldx #>BITMAP_START
    ; ldy #`BITMAP_START
    ; jsr setBitmapAddress

    ; lda #0
    ; jsr setBitmapClut
    ; jsr showBitmap


    jsr setBitmapLayer0
    jsr setupBitmap0

   ; jsr setBitmapLayer1
   ; jsr setupBitmap1
    jsr setLayers

    jsr cities.demo

    #showSpriteMacro 51, SPRITE_LETTER_D, 80, 200
    #showSpriteMacro 50, SPRITE_LETTER_E, 80 + 16, 200
    #showSpriteMacro 49, SPRITE_LETTER_F, 80 + 32, 200
    #showSpriteMacro 48, SPRITE_LETTER_E, 80 + 48, 200
    #showSpriteMacro 47, SPRITE_LETTER_N, 80 + 64, 200
    #showSpriteMacro 46, SPRITE_LETTER_D, 80 + 80, 200

    #showSpriteMacro 45, SPRITE_LETTER_C, 205, 200
    #showSpriteMacro 44, SPRITE_LETTER_I, 205 + 16, 200
    #showSpriteMacro 43, SPRITE_LETTER_T, 205 + 32, 200
    #showSpriteMacro 42, SPRITE_LETTER_I, 205 + 48, 200
    #showSpriteMacro 41, SPRITE_LETTER_E, 205 + 64, 200
    #showSpriteMacro 40, SPRITE_LETTER_S, 205 + 80, 200

    #showSpriteMacro 39, SPRITE_DOWN_ARROW, 80, 220
    #showSpriteMacro 38, SPRITE_DOWN_ARROW, 115, 220
    #showSpriteMacro 37, SPRITE_DOWN_ARROW, 144, 220
    #showSpriteMacro 36, SPRITE_DOWN_ARROW, 205, 220
    #showSpriteMacro 35, SPRITE_DOWN_ARROW, 250, 220
    #showSpriteMacro 34, SPRITE_DOWN_ARROW, 285, 220
    jsr setDoubleText
    lda <#mMenuStart
    ldx >#mMenuStart
    ldy #10
    jsr drawText

    lda #dk_brown
    ldx #black
    ldy #10
    jsr setColorByLine

    lda #60
    sta mArrowBlink

    jsr nextState
    rts

demo

    jsr isF1Pressed
    bcs _playDemo
    jsr state.next
    rts
_playDemo
    jsr icbm.demo
   ; jsr site.draw
 ;   jsr cruise.demo
    ;jsr plane.demo
  ;  jsr abm.handle
  ;  jsr explosion.handle

    dec mArrowBlink
    lda mArrowBlink
    cmp #30
    beq _arrowOff
    cmp #0
    beq _arrowOn
    rts
_arrowOff
    lda #34
    jsr setSpriteNumber
    jsr hideSprite

    lda #35
    jsr setSpriteNumber
    jsr hideSprite

    lda #36
    jsr setSpriteNumber
    jsr hideSprite

    lda #37
    jsr setSpriteNumber
    jsr hideSprite

    lda #38
    jsr setSpriteNumber
    jsr hideSprite

    lda #39
    jsr setSpriteNumber
    jsr hideSprite

    rts

_arrowOn
     lda #34
    jsr setSpriteNumber
    jsr showSprite

    lda #35
    jsr setSpriteNumber
    jsr showSprite

    lda #36
    jsr setSpriteNumber
    jsr showSprite

    lda #37
    jsr setSpriteNumber
    jsr showSprite

    lda #38
    jsr setSpriteNumber
    jsr showSprite

    lda #39
    jsr setSpriteNumber
    jsr showSprite

     lda #60
    sta mArrowBlink
    rts
nextState
    inc mState
    rts

init
    stz mState
    stz mArrowBlink

    rts

is
    cmp mState
    beq _yes
    sec
    rts
_yes
    clc
    rts

setupBitmap0
    lda #0
    jsr setBitmapNumber


    lda <#BITMAP_START
    ldx >#BITMAP_START
    ldy `#BITMAP_START
    jsr setBitmapAddress

    jsr setBitmapClut0
    jsr showBitmap
    rts

setupBitmap1
     lda #1
    jsr setBitmapNumber
    lda <#BITMAP_STATIC
    ldx >#BITMAP_STATIC
    ldy `#BITMAP_STATIC
    jsr setBitmapAddress

    jsr setBitmapClut0

    jsr showBitmap
    rts
.endsection
.section variables
stateBegin = 0
stateDemo = 1
mArrowBlink
    .byte $00
mState
    .byte $00

mMenuStart
    .text '           Press F1 To Start'
    .byte $00
    .text '0123456789012345678901234567890123456789'
.endsection
.endnamespace