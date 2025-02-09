.section code
handlecruise
    jsr handlecruiseTL
    bcc _hit
    jsr handlecruiseTR
    bcc _hit
    jsr handlecruiseBL
    bcc _hit
    jsr handlecruiseBR
    bcc _hit
    jsr handlecruiseMiddle
    bcc _hit
    rts
_hit
    rts

handlecruiseTL
    jsr cruise.getX
    clc
    sbc #32
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug

    jsr cruise.getY
    clc
    sbc #32
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginY
    jsr getPixel
    sta mDebug + 1
    cmp #EXPLOSION_CLR
    beq _hit
    sec
    rts
_hit
    clc
    rts

handlecruiseTR
    jsr cruise.getX
    clc
    sbc #32 - 16
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug

    jsr cruise.getY
    clc
    sbc #32 + 0
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginY
    jsr getPixel
    sta mDebug + 1
    cmp #EXPLOSION_CLR
    beq _hit
    sec
    rts
_hit
    clc
    rts

handlecruiseBR
    jsr cruise.getX
    clc
    sbc #32-16
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug

    jsr cruise.getY
    clc
    sbc #32 - 16
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginY
    jsr getPixel
    sta mDebug + 1
    cmp #EXPLOSION_CLR
    beq _hit
    sec
    rts
_hit
    clc
    rts

handlecruiseBL
    jsr cruise.getX
    clc
    sbc #32
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug

    jsr cruise.getY
    clc
    sbc #32 - 16
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginY
    jsr getPixel
    sta mDebug + 1
    cmp #EXPLOSION_CLR
    beq _hit
    sec
    rts
_hit
    clc
    rts

handlecruiseMiddle
    jsr cruise.getX
    clc
    sbc #32 - 16
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug



    jsr cruise.getY
    clc
    sbc #32 - 8
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginY
    jsr getPixel
    sta mDebug + 1
    cmp #EXPLOSION_CLR
    beq _hit
    sec
    rts
_hit
    clc
    rts
.endsection 
