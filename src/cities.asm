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

    lda #1
    sta mCityActive0
    sta mCityActive1
    sta mCityActive2
    sta mCityActive3
    sta mCityActive4
    sta mCityActive5
    rts

play
    pha
    phx
    phy
    jsr collision.handleCities
    jsr handleCities
    ply
    plx
    pla
    rts


handleCities
    jsr handleCity0
    jsr handleCity1
    jsr handleCity2
    jsr handleCity3
    jsr handleCity4
    jsr handleCity5
    rts
handleCity0
    lda mCityActive0
    cmp #1
    bne _end
    jsr cityColission0
_end
    rts


handleCity1
    lda mCityActive1
    cmp #1
    bne _end
    jsr cityColission1
_end
    rts


handleCity2
    lda mCityActive2
    cmp #1
    bne _end
    jsr cityColission2
_end
    rts


handleCity3
    lda mCityActive3
    cmp #1
    bne _end
    jsr cityColission3
_end
    rts


handleCity4
    lda mCityActive4
    cmp #1
    bne _end
    jsr cityColission4
_end
    rts


handleCity5
    lda mCityActive5
    cmp #1
    bne _end
    jsr cityColission5
_end
    rts

cityColission0
    jsr collision.isCity0Hit
    bcc _yes
    rts
_yes

    lda <#cityBmpX0
    ldx #>cityBmpX0
    jsr explosion.setX
    lda <#cityBmpY0
    ldx #>cityBmpY0
    jsr explosion.setY
    jsr explosion.start

    lda #63
    jsr setSpriteNumber
    jsr hideSprite
    stz mCityActive0
    rts

cityColission1
    jsr collision.isCity1Hit
    bcc _yes
    rts
_yes
    lda <#cityBmpX1
    ldx #>cityBmpX1
    jsr explosion.setX
    lda <#cityBmpY1
    ldx #>cityBmpY1
    jsr explosion.setY
    jsr explosion.start
    lda #62
    jsr setSpriteNumber
    jsr hideSprite
    stz mCityActive1
    rts

cityColission2
    jsr collision.isCity2Hit
    bcc _yes
    rts
_yes
     lda <#cityBmpX2
    ldx #>cityBmpX2
    jsr explosion.setX
    lda <#cityBmpY2
    ldx #>cityBmpY2
    jsr explosion.setY
    jsr explosion.start
    lda #61
    jsr setSpriteNumber
    jsr hideSprite
    stz mCityActive2
    rts

cityColission3
    jsr collision.isCity3Hit
    bcc _yes
    rts
_yes
    lda <#cityBmpX3
    ldx >#cityBmpX3
    jsr explosion.setX
    lda <#cityBmpY3
    ldx >#cityBmpY3
    jsr explosion.setY
    jsr explosion.start
    lda #60
    jsr setSpriteNumber
    jsr hideSprite
    stz mCityActive3
    rts

cityColission4
    jsr collision.isCity4Hit
    bcc _yes
    rts
_yes
    lda <#cityBmpX4
    ldx #>cityBmpX4
    jsr explosion.setX
    lda <#cityBmpY4
    ldx #>cityBmpY4
    jsr explosion.setY
    jsr explosion.start
    lda #59
    jsr setSpriteNumber
    jsr hideSprite
    stz mCityActive4
    rts

cityColission5
    jsr collision.isCity5Hit
    bcc _yes
    rts
_yes
    lda <#cityBmpX5
    ldx #>cityBmpX5
    jsr explosion.setX
    lda <#cityBmpY5
    ldx #>cityBmpY5
    jsr explosion.setY
    jsr explosion.start
    lda #58
    jsr setSpriteNumber
    jsr hideSprite
    stz mCityActive5
    rts

getReamainingTotal
    lda mCityActive0
    clc
    adc mCityActive1
    adc mCityActive2
    adc mCityActive3
    adc mCityActive4
    adc mCityActive5
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

cityBmpX0 = 80 - 32 + 8
cityBmpX1 = 115 - 32 + 8
cityBmpX2 = 144 - 32 + 8
cityBmpX3 = 205 - 32 + 8
cityBmpX4 = 250 - 32 + 8
cityBmpX5 = 285 - 32 + 8

cityBmpY0 = 247 - 32 + 8
cityBmpY1 = 248 - 32 + 8
cityBmpY2 = 250 - 32 + 8
cityBmpY3 = 247 - 32 + 8
cityBmpY4 = 244 - 32 + 8
cityBmpY5 = 250 - 32 + 8

mCityActive0
    .byte $00
mCityActive1
    .byte $00
mCityActive2
    .byte $00
mCityActive3
    .byte $00
mCityActive4
    .byte $00
mCityActive5
    .byte $00
mCityActive6
    .byte $00
.endsection
.endnamespace