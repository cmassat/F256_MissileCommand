.section code
handlecruise
    pha
    phx
    phy
    jsr cruiseHitCity0
    jsr cruiseHitCity1
    jsr cruiseHitCity2
    jsr cruiseHitCity3
    jsr cruiseHitCity4
    jsr cruiseHitCity5
    jsr cruiseHitSilo0
    jsr cruiseHitSilo1
    jsr cruiseHitSilo2
    jsr cruiseAbm
    ply
    plx
    pla
    rts

objectsActives
    cmp #1
    beq _objectOneActive
    sec
    rts
_objectOneActive
    txa
    cmp  #1
    beq _weGood
    sec
    rts
_weGood
    clc
    rts

cruiseHitSilo0
     lda cruise.mCruiseStatus0
    ldx abm.mLeftSiloActive
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, abm.mSiloX0, 10, cruise.mCruiseCurrentY0, 10,abm.mSiloY0, 10
    lda #1
    sta mSiloHit0

    lda abm.mSiloX0
    ldx abm.mSiloX0 + 1
    jsr explosion.setX

    lda abm.mSiloY0
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion
    stz cruise.mCruiseStatus0
    rts

cruiseHitSilo1
     lda cruise.mCruiseStatus0
    ldx abm.mCenterSiloActive
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, abm.mSiloX1, 10, cruise.mCruiseCurrentY0, 10,abm.mSiloY1, 10
    lda #1
    sta mSiloHit1

    lda abm.mSiloX1
    ldx abm.mSiloX1 + 1
    jsr explosion.setX

    lda abm.mSiloY1
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion
    stz cruise.mCruiseStatus0
    rts

cruiseHitSilo2
     lda cruise.mCruiseStatus0
    ldx abm.mRightSiloActive
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, abm.mSiloX2, 10, cruise.mCruiseCurrentY0, 10,abm.mSiloY2, 10
    lda #1
    sta mSiloHit0

    lda abm.mSiloX2
    ldx abm.mSiloX2 + 1
    jsr explosion.setX

    lda abm.mSiloY2
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion
    stz cruise.mCruiseStatus0
    rts

cruiseHitCity0
    lda cruise.mCruiseStatus0
    ldx cities.mCityActive0
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, cities.mCityCurrentSpriteX0, 10, cruise.mCruiseCurrentY0, 10,cities.mCityCurrentSpriteY0, 10
    lda #1
    sta mCityHit0

    lda cities.mCityCurrentSpriteX0
    ldx cities.mCityCurrentSpriteX0 + 1
    jsr explosion.setX

    lda cities.mCityCurrentSpriteY0
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion
    stz cruise.mCruiseStatus0
    rts

cruiseHitCity1
    lda cruise.mCruiseStatus0
    ldx cities.mCityActive1
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, cities.mCityCurrentSpriteX1, 10, cruise.mCruiseCurrentY0, 10,cities.mCityCurrentSpriteY1, 10
    lda #1
    sta mCityHit1
    lda cities.mCityCurrentSpriteX1
    ldx cities.mCityCurrentSpriteX1 + 1
    jsr explosion.setX

    lda cities.mCityCurrentSpriteY1
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion
    stz cruise.mCruiseStatus0
    rts

cruiseHitCity2
    lda cruise.mCruiseStatus0
    ldx cities.mCityActive2
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, cities.mCityCurrentSpriteX2, 10, cruise.mCruiseCurrentY0, 10,cities.mCityCurrentSpriteY2, 10
    lda #1
    sta mCityHit2

    lda cities.mCityCurrentSpriteX2
    ldx cities.mCityCurrentSpriteX2 + 1
    jsr explosion.setX

    lda cities.mCityCurrentSpriteY2
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion
    stz cruise.mCruiseStatus0
    rts

cruiseHitCity3
     lda cruise.mCruiseStatus0
    ldx cities.mCityActive3
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, cities.mCityCurrentSpriteX3, 10, cruise.mCruiseCurrentY0, 10,cities.mCityCurrentSpriteY3, 10
    lda #1
    sta mCityHit3

    lda cities.mCityCurrentSpriteX3
    ldx cities.mCityCurrentSpriteX3 + 1
    jsr explosion.setX

    lda cities.mCityCurrentSpriteY3
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion
    stz cruise.mCruiseStatus0
    rts

cruiseHitCity4
    lda cruise.mCruiseStatus0
    ldx cities.mCityActive4
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, cities.mCityCurrentSpriteX4, 10, cruise.mCruiseCurrentY0, 10,cities.mCityCurrentSpriteY4, 10
    lda #1
    sta mCityHit4
    lda cities.mCityCurrentSpriteX4
    ldx cities.mCityCurrentSpriteX4 + 1
    jsr explosion.setX

    lda cities.mCityCurrentSpriteY4
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion

    stz cruise.mCruiseStatus0
    rts

cruiseHitCity5
    lda cruise.mCruiseStatus0
    ldx cities.mCityActive5
    jsr objectsActives
    bcc _bothActive
    rts
_bothActive
    #coollideMacro cruise.mCruiseCurrentX0, 10, cities.mCityCurrentSpriteX5, 10, cruise.mCruiseCurrentY0, 10,cities.mCityCurrentSpriteY5, 10
    lda #1
    sta mCityHit5

    lda cities.mCityCurrentSpriteX5
    ldx cities.mCityCurrentSpriteX5 + 1
    jsr explosion.setX

    lda cities.mCityCurrentSpriteY5
    ldx #0
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion
    stz cruise.mCruiseStatus0
    rts

cruiseAbm
    lda cruise.mCruiseCurrentX0
    ldx cruise.mCruiseCurrentX0 + 1
    jsr setOrginX

    lda cruise.mCruiseCurrentY0
    ldx #0
    jsr setOrginY
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _hit

    lda cruise.mCruiseCurrentX0
    clc
    adc #5
    pha
    txa
    adc #0
    tax
    pla
    jsr setOrginX

    lda cruise.mCruiseCurrentY0
    clc
    adc #5
    ldx #0
    jsr setOrginY
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _hit

    rts
_hit
    jsr cruise.reset
    jsr psg.playExplosion
    lda $99
    jsr score.addScore
    lda $26
    jsr score.addScore
    rts
.endsection 
