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
    #showSpriteMacro 63, SPRITE_CITY, cityX0, cityY0, mCityActive0
    #showSpriteMacro 62, SPRITE_CITY, cityX1, cityY1, mCityActive1
    #showSpriteMacro 61, SPRITE_CITY, cityX2, cityY2, mCityActive2
    #showSpriteMacro 60, SPRITE_CITY, cityX3, cityY3, mCityActive3
    #showSpriteMacro 59, SPRITE_CITY, cityX4, cityY4, mCityActive4
    #showSpriteMacro 58, SPRITE_CITY, cityX5, cityY5, mCityActive5
    rts

init
    lda #1
    sta mCityActive0
    sta mCityActive1
    sta mCityActive2
    sta mCityActive3
    sta mCityActive4
    sta mCityActive5
    jsr resetCities
    rts

resetCities
    lda mCityActive0
    cmp #1
    bne _checkCity1
    #showSpriteMacro 63, SPRITE_CITY, cityX0, cityY0, mCityActive0
_checkCity1
    lda mCityActive1
    cmp #1
    bne _checkCity2
    #showSpriteMacro 62, SPRITE_CITY, cityX1, cityY1, mCityActive1
_checkCity2
    lda mCityActive2
    cmp #1
    bne _checkCity3
    #showSpriteMacro 61, SPRITE_CITY, cityX2, cityY2, mCityActive2
_checkCity3
    lda mCityActive3
    cmp #1
    bne _checkCity4
    #showSpriteMacro 60, SPRITE_CITY, cityX3, cityY3, mCityActive3
_checkCity4
    lda mCityActive4
    cmp #1
    bne _checkCity5
    #showSpriteMacro 59, SPRITE_CITY, cityX4, cityY4, mCityActive4
_checkCity5
    lda mCityActive5
    cmp #1
    bne _end
    #showSpriteMacro 58, SPRITE_CITY, cityX5, cityY5, mCityActive5
_end
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



getCoord0
    lda #<cityBmpX0
    ldx #>cityBmpX0
    ldy #cityBmpY0
    rts

getCoord1
    lda #<cityBmpX1
    ldx #>cityBmpX1
    ldy #cityBmpY1
    rts

getCoord2
    lda #<cityBmpX2
    ldx #>cityBmpX2
    ldy #cityBmpY2
    rts

getCoord3
    lda #<cityBmpX3
    ldx #>cityBmpX3
    ldy #cityBmpY3
    rts

getCoord4
    lda #<cityBmpX4
    ldx #>cityBmpX4
    ldy #cityBmpY4
    rts


getCoord5
    lda #<cityBmpX5
    ldx #>cityBmpX5
    ldy #cityBmpY5
    rts

renewCity
    lda mCityActive0
    cmp #activeStatus
    bne _activate0

    lda mCityActive1
    cmp #activeStatus
    bne _activate1

    lda mCityActive2
    cmp #activeStatus
    bne _activate2

    lda mCityActive3
    cmp #activeStatus
    bne _activate3

    lda mCityActive4
    cmp #activeStatus
    bne _activate4

    lda mCityActive5
    cmp #activeStatus
    bne _activate5
    rts
_activate0
    lda #activeStatus
    sta mCityActive0
    stz collision.mCityHit0
    jsr resetCities
    rts
_activate1
    lda #activeStatus
    sta mCityActive1
    stz collision.mCityHit1
    #showSpriteMacro 62, SPRITE_CITY, cityX1, cityY1, mCityActive1
    jsr resetCities
    rts
_activate2
    lda #activeStatus
    sta mCityActive2
    stz collision.mCityHit2
    #showSpriteMacro 61, SPRITE_CITY, cityX1, cityY1, mCityActive1
    jsr resetCities
    rts
_activate3
    lda #activeStatus
    sta mCityActive3
    stz collision.mCityHit3
    jsr resetCities
    rts
_activate4
    lda #activeStatus
    sta mCityActive4
    stz collision.mCityHit4
    jsr resetCities
    rts
_activate5
    lda #activeStatus
    sta mCityActive5
    stz collision.mCityHit5
    jsr resetCities
    rts

.endsection

.section variables
activeStatus = 1
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
mCityCurrentSpriteX0
    .byte <cityBmpX0, >cityBmpX0
mCityCurrentSpriteY0
    .byte <cityBmpY0, >cityBmpY0

mCityCurrentSpriteX1
    .byte <cityBmpX1, >cityBmpX1
mCityCurrentSpriteY1
    .byte <cityBmpY1, >cityBmpY1

mCityCurrentSpriteX2
    .byte <cityBmpX2, >cityBmpX2
mCityCurrentSpriteY2
    .byte <cityBmpY2, >cityBmpY2

mCityCurrentSpriteX3
    .byte <cityBmpX3, >cityBmpX3
mCityCurrentSpriteY3
    .byte <cityBmpY3, >cityBmpY3

mCityCurrentSpriteX4
    .byte <cityBmpX4, >cityBmpX4
mCityCurrentSpriteY4
    .byte <cityBmpY4, >cityBmpY4

mCityCurrentSpriteX5
    .byte <cityBmpX5, >cityBmpX5
mCityCurrentSpriteY5
    .byte <cityBmpY5, >cityBmpY5

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