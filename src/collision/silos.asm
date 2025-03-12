.section code

SiloHit .macro SiloX, SiloY, hit, bmpX, bmpY
    lda \hit
    cmp #0
    bne _next
    lda \SiloX
    clc
    adc  #1
    sta \SiloX
    lda \SiloX + 1
    adc #0
    sta \SiloX + 1
    lda \SiloX
    ldx \SiloX + 1
    jsr setOrginX

    lda \SiloY
   ; clc
   ; adc #1
   ; sta \SiloY
    ldx \SiloY + 1
   ; adc #0
   ; sta \SiloY + 1

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

initSilos .macro startX, startY, destX, destY, hit
    lda <#\startX
    ldx \SiloX + 1
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

trackSilos .macro startX, startY, destX, destY, hit
    lda \hit
    cmp #0
    beq _checkBunker
    bne _skip
_checkBunker
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

handleSilos
    pha
    phx
    phy

    jsr trackSilo0
    jsr trackSilo1
    jsr trackSilo2

    lda  #16
    sta mSiloHitTracker
_loop
    lda mSiloHitTracker
    cmp #0
    beq _end
    jsr checkSilo0
    jsr checkSilo1
    jsr checkSilo2
    dec mSiloHitTracker
    bra _loop
_end
    ply
    plx
    pla
    rts

trackSilo0
    #trackSilos abm.SiloX0, abm.SiloY0, SiloX0, SiloY0, mSiloHit0
    rts

trackSilo1
    #trackSilos abm.SiloX1, abm.SiloY1, SiloX1, SiloY1, mSiloHit1
    rts

trackSilo2
    #trackSilos abm.SiloX2, abm.SiloY2, SiloX2, SiloY2, mSiloHit2
    rts


checkSilo0
    #SiloHit  SiloX0, SiloY0, mSiloHit0, abm.SiloBmpX0, abm.SiloBmpY0
    rts

checkSilo1
    #SiloHit  SiloX1, SiloY1, mSiloHit1, abm.SiloBmpX1, abm.SiloBmpY1
    rts

checkSilo2
    #SiloHit  SiloX2, SiloY2, mSiloHit2, abm.SiloBmpX2, abm.SiloBmpY2
    rts


isSilo0Hit
    lda mSiloHit0
    cmp #1
    beq _yes
    sec
    rts
_yes
    lda abm.inactiveStatus
    sta abm.mLeftSiloActive
    clc
    rts


isSilo1Hit
    lda mSiloHit1
    cmp #1
    beq _yes
    sec
    rts
_yes
    lda abm.inactiveStatus
    sta abm.mCenterSiloActive
    clc
    rts

isSilo2Hit
    lda mSiloHit2
    cmp #1
    beq _yes
    sec
    rts
_yes
     lda abm.inactiveStatus
    sta abm.mRightSiloActive
    clc
    rts

initSiloCollision
    stz mSiloHitTracker
    stz mSiloHit0
    stz mSiloHit1
    stz mSiloHit2
    rts
.endsection
.section variables
mSiloHitTracker
    .byte $0
mSiloHit0
    .byte $00
mSiloHit1
    .byte $00
mSiloHit2
    .byte $00

SiloX0
    .byte $00, $00
SiloX1
    .byte $00, $00
SiloX2
    .byte $00, $00

SiloY0
    .byte $00, $00
SiloY1
    .byte $00, $00
SiloY2
    .byte $00, $00
.endsection

