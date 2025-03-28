.section code

cityHit .macro cityX, cityY, hit, bmpX, bmpY
    lda \hit
    cmp #0
    bne _next
    lda \cityX
    clc
    adc  #1
    sta \cityX
    lda \cityX + 1
    adc #0
    sta \cityX + 1
    lda \cityX
    ldx \cityX + 1
    jsr setOrginX

    lda \cityY
   ; clc
   ; adc #1
   ; sta \cityY
    ldx \cityY + 1
   ; adc #0
   ; sta \cityY + 1

     jsr setOrginY
     lda #3
     jsr setPixelColor
  ;  jsr putPixel
    jsr getPixel

    cmp #MISSLE_CLR
    beq _hit
    bra _next
_hit
    lda #1
    sta \hit

    lda <#\bmpX
    ldx #>\bmpX
    jsr explosion.setX
    lda <#\bmpY
    sec
    sbc #8
    ldx #>\bmpY
    jsr explosion.setY

    jsr explosion.start
    jsr psg.playExplosion

_next
.endmacro

initCities .macro startX, startY, destX, destY, hit
    lda <#\startX
    sec
    sbc #32
    sta \destX
    lda >#\startX
    sbc #0
    sta \destX + 1

    lda <#\startY
    sec
    sbc #32
    sta \destY
    lda >#\startY
    sbc #0
    sta \destY + 1

    stz \hit
.endmacro

trackCities .macro startX, startY, destX, destY, hit
    lda \hit
    cmp #0
    beq _checkCity
    bne _skip
_checkCity
    lda <#\startX
    sec
    sbc #32
    sta \destX
    lda >#\startX
    sbc #0
    sta \destX + 1

    lda <#\startY
    sec
    sbc #32
    sta \destY
    lda >#\startY
    sbc #0
    sta \destY + 1
_skip
.endmacro

handleCities
    pha
    phx
    phy
    jsr trackCity0
    jsr trackCity1
    jsr trackCity2
    jsr trackCity3
    jsr trackCity4
    jsr trackCity5

    lda  #16
    sta mhitTracker
_loop
    lda mhitTracker
    cmp #0
    beq _end
    jsr checkCity0
    jsr checkCity1
    jsr checkCity2
    jsr checkCity3
    jsr checkCity4
    jsr checkCity5
    dec mhitTracker

    bra _loop
_end
    ply
    plx
    pla
    rts

checkCity0
    #cityHit  cityX0, cityY0, mCityHit0, cities.cityBmpX0, cities.cityBmpY0
    rts

checkCity1
    #cityHit  cityX1, cityY1, mCityHit1, cities.cityBmpX1, cities.cityBmpY1
    rts
checkCity2
    #cityHit  cityX2, cityY2, mCityHit2, cities.cityBmpX2, cities.cityBmpY2
    rts
checkCity3
    #cityHit  cityX3, cityY3, mCityHit3, cities.cityBmpX3, cities.cityBmpY3
    rts
checkCity4
    #cityHit  cityX4, cityY4, mCityHit4, cities.cityBmpX4, cities.cityBmpY4
    rts
checkCity5
    #cityHit  cityX5, cityY5, mCityHit5, cities.cityBmpX5, cities.cityBmpY5
    rts

trackCity0
     #trackCities cities.cityX0, cities.cityY0, cityX0, cityY0, mCityHit0
    rts
trackCity1
    #trackCities cities.cityX1, cities.cityY1, cityX1, cityY1, mCityHit1
    rts
trackCity2
    #trackCities cities.cityX2, cities.cityY2, cityX2, cityY2, mCityHit2
    rts
trackCity3
    #trackCities cities.cityX3, cities.cityY3, cityX3, cityY3, mCityHit3
    rts
trackCity4
    #trackCities cities.cityX4, cities.cityY4, cityX4, cityY4, mCityHit4
    rts
trackCity5
    #trackCities cities.cityX5, cities.cityY5, cityX5, cityY5, mCityHit5
    rts
isCity0Hit
    lda mCityHit0
    cmp #1
    beq _yes
    sec
    rts
_yes
    clc
    rts


isCity1Hit
    lda mCityHit1
    cmp #1
    beq _yes
    sec
    rts
_yes
    clc
    rts

isCity2Hit
    lda mCityHit2
    cmp #1
    beq _yes
    sec
    rts
_yes
    clc
    rts

isCity3Hit
    lda mCityHit3
    cmp #1
    beq _yes
    sec
    rts
_yes
    clc
    rts

isCity4Hit
    lda mCityHit4
    cmp #1
    beq _yes
    sec
    rts
_yes
    clc
    rts

isCity5Hit
    lda mCityHit5
    cmp #1
    beq _yes
    sec
    rts
_yes
    clc
    rts

initCityCollision
    stz mhitTracker
    stz mCityHit0
    stz mCityHit1
    stz mCityHit2
    stz mCityHit3
    stz mCityHit4
    stz mCityHit5
    rts
.endsection
.section variables
mhitTracker
    .byte $0
mCityHit0
    .byte $00
mCityHit1
    .byte $00
mCityHit2
    .byte $00
mCityHit3
    .byte $00
mCityHit4
    .byte $00
mCityHit5
    .byte $00

cityX0
    .byte $00, $00
cityX1
    .byte $00, $00
cityX2
    .byte $00, $00
cityX3
    .byte $00, $00
cityX4
    .byte $00, $00
cityX5
    .byte $00, $00

cityY0
    .byte $00, $00
cityY1
    .byte $00, $00
cityY2
    .byte $00, $00
cityY3
    .byte $00, $00
cityY4
    .byte $00, $00
cityY5
    .byte $00, $00
.endsection

