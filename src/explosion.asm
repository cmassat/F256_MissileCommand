explosion .namespace
.section code
handle
    jsr drawExplosions
    rts

init
    lda #0
    sta exp0
    sta exp1
    sta exp2
    sta exp3
    sta exp4
    sta exp5
    sta exp6
    sta exp7
    rts

demo
    jsr drawExplosions
    rts


play
    jsr drawExplosions
    rts

drawExplosions
    lda #<expTable
    sta POINTER_SRC
    lda #>expTable
    sta POINTER_SRC + 1

    ldy #0
    lda (POINTER_SRC),y
    sta POINTER_EXP
    iny
    lda (POINTER_SRC),y
    sta POINTER_EXP + 1


    bra _explode

_continue
    jsr nextABM

    lda #<expTableEND
    cmp POINTER_SRC
    beq _checHi
    bra _explode
    rts
_checHi
    lda #>expTableEND
    cmp POINTER_SRC + 1
    beq _end

_explode
    ldy #STATUS
    lda (POINTER_EXP),y
    jsr explosion
    bra _continue

_end
rts

explosion
    cmp #1
    beq _animate
    cmp #2
    beq _dissolve
    rts
_animate
    jsr animate
    rts
_dissolve
    jsr dissolve
    rts

nextABM
    lda POINTER_SRC
    clc
    adc #2
    sta POINTER_SRC

    lda POINTER_SRC + 1
    adc #0
    sta POINTER_SRC + 1

    ldy #0
    lda (POINTER_SRC),y
    sta POINTER_EXP
    iny
    lda (POINTER_SRC),y
    sta POINTER_EXP + 1
    rts

animate
    ldy #TIMER
    lda (POINTER_EXP),y
    adc #1
    sta (POINTER_EXP),y
    lda (POINTER_EXP),y
    cmp #TIME_PER_FRAME
    bcs _updateFrame
    rts
_updateFrame
    ldy #TIMER
    lda #0
    sta (POINTER_EXP),y
    ldy #FRAME
    lda (POINTER_EXP),y
    clc
    adc #1
    sta (POINTER_EXP),y;

    lda (POINTER_EXP),y
    cmp #15
    bcs _deactivate

_drawAnimation
    ldy #PX
    lda (POINTER_EXP),y
    pha
    iny
    lda (POINTER_EXP),y
    tax
    pla
    jsr circle.setCenterX
    ;
    ldy #PY
    lda (POINTER_EXP),y
    pha
    iny
    lda (POINTER_EXP),y
    tax
    pla
    jsr circle.setCenterY
    ;
    lda #EXPLOSION_CLR
    jsr setPixelColor

    ldy #FRAME
    lda (POINTER_EXP),y
    jsr circle.setRadius
    jsr circle.activate
    jsr circle.doCircle
    rts
 _deactivate
    jsr deactivate
    rts

deactivate
    lda #2
    sta  (POINTER_EXP)

    ldy #FRAME
    lda #15
    sta (POINTER_EXP),y

    rts

dissolve

    ldy #FRAME
    lda (POINTER_EXP),y
    cmp #0
    beq _resetExplosion

    ldy #PX
    lda (POINTER_EXP),y
    pha
    iny
    lda (POINTER_EXP),y
    tax
    pla
    jsr circle.setCenterX
;
    ldy #PY
    lda (POINTER_EXP),y
    pha
    iny
    lda (POINTER_EXP),y
    tax
    pla
    jsr circle.setCenterY
;
     ldy #FRAME
     lda (POINTER_EXP),y
    jsr circle.setRadius
    jsr circle.activate

    lda #0
    jsr setPixelColor
    jsr circle.doCircle
    lda #115
    jsr setPixelColor

    ldy #FRAME
    lda (POINTER_EXP),y
    sec
    sbc #1
    sta (POINTER_EXP),y
    rts
_resetExplosion
    lda #0
    sta (POINTER_EXP)

    rts

start
    lda #<expTable
    sta POINTER_SRC
    lda #>expTable
    sta POINTER_SRC + 1

    ldy #0
    lda (POINTER_SRC),y
    sta POINTER_EXP
    iny
    lda (POINTER_SRC),y
    sta POINTER_EXP + 1

_find
    ldy #STATUS
    lda (POINTER_EXP),y
    cmp #0
    beq _activate

    lda POINTER_SRC
    clc
    adc #2
    sta POINTER_SRC
    lda POINTER_SRC + 1
    adc #0
    sta POINTER_SRC + 1

    lda POINTER_SRC
    cmp #<expTableEND
    beq _checkHI
    bne _setNext
_checkHI
    lda POINTER_SRC + 1
    cmp #>expTableEND
    beq _end
_setNext
    ldy #0
    lda (POINTER_SRC),y
    sta POINTER_EXP
    iny
    lda (POINTER_SRC),y
    sta POINTER_EXP + 1
    bra _find
_end
    rts
_activate
    lda #1
    sta (POINTER_EXP)

    ldy #PX
    lda explosionX
    sta (POINTER_EXP),y
    iny
    lda explosionX + 1
    sta (POINTER_EXP),y

    ldy #PY
    lda explosionY
    sta (POINTER_EXP),y
    iny
    lda explosionY + 1
    sta (POINTER_EXP),y


    ldy #FRAME
    lda #0
    sta (POINTER_EXP),y

    ldy #TIMER
    lda #0
    sta (POINTER_EXP),y
    rts

setX
    sta explosionX
    stx explosionX + 1
    rts

setY
    sta explosionY
    stx explosionY + 1
    rts


.endsection
.section variables
STATUS = 0
PX = 1
PY = 3
FRAME = 5
TIMER = 6
TIME_PER_FRAME = 15

expTable
 .word exp0
 .word exp1
 .word exp2
 .word exp3
 .word exp4
 .word exp5
 .word exp6
expTableEND
 .word exp7


exp0
mActive ; 0
    .byte $00
destX ;1
    .byte $00, $00
destY ;3
    .byte $00, $00
mFrame; ;5
    .byte $00
mTimer ; 6
    .byte $00

exp1
    .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00

        .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00

exp2
    .byte $00
    .byte 00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00
exp3
    .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00

        .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00

        .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00
exp4
    .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00

        .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00
    .byte $00, $00
    .byte $00, $00
exp5
    .byte $00
    .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00
exp6
    .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00

        .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00
exp7
    .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00

    .byte $00
    .byte $00, $00
    .byte $00, $00
    .byte $00
    .byte $00
explosionX
    .byte $00, $00
explosionY
    .byte $00, $00
.endsection
.endnamespace