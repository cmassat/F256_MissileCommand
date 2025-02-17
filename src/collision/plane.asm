.section code
handlePlane
    pha
    phx
    phy
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
_hit
    ply
    plx
    pla
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

    cmp #EXPLOSION_CLR
    beq _hit
    sec
    rts
_hit
    clc
    rts
.endsection 
