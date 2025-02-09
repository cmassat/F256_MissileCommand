cities .namespace
.section code
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
demo
    #showSpriteMacro 63, SPRITE_CITY, cityX0, cityY0
    #showSpriteMacro 62, SPRITE_CITY, cityX1, cityY1
    #showSpriteMacro 61, SPRITE_CITY, cityX2, cityY2
    #showSpriteMacro 60, SPRITE_CITY, cityX3, cityY3
    #showSpriteMacro 59, SPRITE_CITY, cityX4, cityY4
    #showSpriteMacro 58, SPRITE_CITY, cityX5, cityY5
rts
init
     #showSpriteMacro 63, SPRITE_CITY, cityX0, cityY0
    #showSpriteMacro 62, SPRITE_CITY, cityX1, cityY1
    #showSpriteMacro 61, SPRITE_CITY, cityX2, cityY2
    #showSpriteMacro 60, SPRITE_CITY, cityX3, cityY3
    #showSpriteMacro 59, SPRITE_CITY, cityX4, cityY4
    #showSpriteMacro 58, SPRITE_CITY, cityX5, cityY5
    rts
play
   ; #showSpriteMacro 63, SPRITE_CITY, cityX0, cityY0
   ; #showSpriteMacro 62, SPRITE_CITY, cityX1, cityY1
   ; #showSpriteMacro 61, SPRITE_CITY, cityX2, cityY2
   ; #showSpriteMacro 60, SPRITE_CITY, cityX3, cityY3
   ; #showSpriteMacro 59, SPRITE_CITY, cityX4, cityY4
   ; #showSpriteMacro 58, SPRITE_CITY, cityX5, cityY5

    jsr collision.handleCities
    jsr cityColission0
    jsr cityColission1
    jsr cityColission2
    jsr cityColission3
    jsr cityColission4
    jsr cityColission5
rts


cityColission0
    jsr collision.isCity0Hit
    bcc _yes
    rts
_yes
    lda #63
    jsr setSpriteNumber
    jsr hideSprite
    rts

cityColission1
    jsr collision.isCity1Hit
    bcc _yes
    rts
_yes
    lda #62
    jsr setSpriteNumber
    jsr hideSprite
    rts

cityColission2
    jsr collision.isCity2Hit
    bcc _yes
    rts
_yes
    lda #61
    jsr setSpriteNumber
    jsr hideSprite
    rts

cityColission3
    jsr collision.isCity3Hit
    bcc _yes
    rts
_yes
    lda #60
    jsr setSpriteNumber
    jsr hideSprite
    rts

cityColission4
    jsr collision.isCity4Hit
    bcc _yes
    rts
_yes
    lda #59
    jsr setSpriteNumber
    jsr hideSprite
    rts

cityColission5
    jsr collision.isCity5Hit
    bcc _yes
    rts
_yes
    lda #58
    jsr setSpriteNumber
    jsr hideSprite
    rts
.endsection
.section variables
cityX0 = 80
cityX1 = 115
cityX2 = 144
cityX3 = 205
cityX4 = 250
cityX5 = 285

cityY0 = 247
cityY1 = 248
cityY2 = 250
cityY3 = 247
cityY4 = 244
cityY5 = 250
.endsection
.endnamespace