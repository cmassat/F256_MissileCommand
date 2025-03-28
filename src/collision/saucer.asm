.section code
handlesaucer
    pha
    phx
    phy
    jsr saucerAbm
    ply
    plx
    pla
    rts



saucerAbm
    lda saucer.saucerActve
    cmp #0
    bne _ok
    rts
_ok
    jsr saucer.getX
    jsr setOrginX

    jsr saucer.getY
    jsr setOrginY
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _hit
;-----------------------------------------------
    jsr saucer.getX
    clc
    adc #11
    pha
    txa
    adc #0
    tax
    pla
    jsr setOrginX

    jsr saucer.getY
    clc
    adc #8
    ldx #0
    jsr setOrginY
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _hit
; ;-----------------------------------------------
;     jsr saucer.getX
;     clc
;     adc #16
;     pha
;     txa
;     adc #0
;     tax
;     pla
;     jsr setOrginX

;     jsr saucer.getY
;     clc
;     adc #8
;     ldx #0
;     jsr setOrginY
;     jsr getPixel
;     cmp #EXPLOSION_CLR
;     beq _hit
; ;-----------------------------------------------
;     jsr saucer.getX
;     clc
;     adc #24
;     pha
;     txa
;     adc #0
;     tax
;     pla
;     jsr setOrginX

;     jsr saucer.getY
;     clc
;     adc #8
;     ldx #0
;     jsr setOrginY
;     jsr getPixel
;     cmp #EXPLOSION_CLR
;     beq _hit
    rts
_hit
    jsr saucer.reset
    jsr psg.playExplosion
    lda #$99
    jsr score.addScore
    lda #$26
    jsr score.addScore
    rts
.endsection 

.section variables
mSaucerCollisionX
    .byte $00, $00
mSaucerCollisionY
    .byte $00, $00
.endsection
