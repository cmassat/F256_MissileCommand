.section code
handleplane
    pha
    phx
    phy
    jsr planeAbm
    ply
    plx
    pla
    rts



planeAbm
    lda plane.planeActve
    cmp #0
    bne _ok
    rts
_ok
    jsr plane.getX
    jsr setOrginX

    jsr plane.getY
    jsr setOrginY
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _hit
;-----------------------------------------------
    jsr plane.getX
    clc
    adc #11
    pha
    txa
    adc #0
    tax
    pla
    jsr setOrginX

    jsr plane.getY
    clc
    adc #8
    ldx #0
    jsr setOrginY
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _hit
; ;-----------------------------------------------
;     jsr plane.getX
;     clc
;     adc #16
;     pha
;     txa
;     adc #0
;     tax
;     pla
;     jsr setOrginX

;     jsr plane.getY
;     clc
;     adc #8
;     ldx #0
;     jsr setOrginY
;     jsr getPixel
;     cmp #EXPLOSION_CLR
;     beq _hit
; ;-----------------------------------------------
;     jsr plane.getX
;     clc
;     adc #24
;     pha
;     txa
;     adc #0
;     tax
;     pla
;     jsr setOrginX

;     jsr plane.getY
;     clc
;     adc #8
;     ldx #0
;     jsr setOrginY
;     jsr getPixel
;     cmp #EXPLOSION_CLR
;     beq _hit
    rts
_hit
    jsr plane.reset
    jsr psg.playExplosion
    lda #$99
    jsr score.addScore
    lda #$01
    jsr score.addScore
    rts
.endsection 

.section variables
mCollisionX
    .byte $00, $00
mCollisionY
    .byte $00, $00
.endsection
