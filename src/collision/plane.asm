.section code
handlePlane
    jsr handlePlaneTL
    bcc _hit
    jsr handlePlaneTR
    bcc _hit
    jsr handlePlaneBL
    bcc _hit
    jsr handlePlaneBR
    bcc _hit
    jsr handlePlaneMiddle
    bcc _hit
    rts
_hit
    rts

handlePlaneTL
    jsr plane.getX
    clc
    sbc #32
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug

    jsr plane.getY
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

handlePlaneTR
    jsr plane.getX
    clc
    sbc #32 - 32
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug

    jsr plane.getY
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

handlePlaneBR
    jsr plane.getX
    clc
    sbc #32-32
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug

    jsr plane.getY
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

handlePlaneBL
    jsr plane.getX
    clc
    sbc #32
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug

    jsr plane.getY
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

handlePlaneMiddle
    jsr plane.getX
    clc
    sbc #32 - 16
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX
    sta mDebug



    jsr plane.getY
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
