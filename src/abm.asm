abm .namespace
.section code
init
    pha
    phx
    phy
    lda #SPRITENUMBER_REDICLE
    jsr setSpriteNumber

    lda #<SPRITE_REDICLE
    ldx #>SPRITE_REDICLE
    ldy #`SPRITE_REDICLE
    jsr setSpriteAddress
    jsr showSprite
    jsr reset

    ply
    plx
    pla
    rts

reset
    pha
    phx
    phy
    lda #20
    sta mTotalAbm
    stz mAbmCount
    ply
    plx
    pla
    rts
handle
    jsr handleFire
    jsr draw
    rts


play
    jsr handleFire
    jsr draw
    rts

handleFire
    lda mFireDelay
    cmp #0
    beq _ok
    lda mFireDelay
    cmp #0
    beq _end
    dec mFireDelay
    stz mLeftClicked
_end
    rts
_ok
    jsr isLeftClick
    bcc _fireLeft
    rts
_fireLeft
    lda #20
    sta mFireDelay
    jsr fire
    rts

draw
    jsr draw0
    jsr draw1
    jsr draw2
    jsr draw3
    jsr draw4
    jsr draw5
    jsr draw6
    jsr draw7
    rts

draw0
    #initMacro abm0, mLineData, origX0, origY0, destX0, destY0, abmActve0
    jsr drawAbm
    rts
draw1
    #initMacro abm1, mLineData, origX1, origY1, destX1, destY1, abmActve1
    jsr drawAbm
    rts
draw2
    #initMacro abm2, mLineData, origX2, origY2, destX2, destY2, abmActve2
    jsr drawAbm
    rts
draw3
    #initMacro abm3, mLineData, origX3, origY3, destX3, destY3, abmActve3
    jsr drawAbm
    rts
draw4
    #initMacro abm4, mLineData, origX4, origY4, destX4, destY4, abmActve4
    jsr drawAbm
    rts
draw5
    #initMacro abm5, mLineData, origX5, origY5, destX5, destY5, abmActve5
    jsr drawAbm
    rts
draw6
    #initMacro abm6, mLineData, origX6, origY6, destX6, destY6, abmActve6
    jsr drawAbm
    rts
draw7
    #initMacro abm7, mLineData, origX7, origY7, destX7, destY7, abmActve7
    jsr drawAbm
    rts

fire
    lda mTotalAbm
    cmp #0
    bne _okToFire
    rts
_okToFire
    lda abmActve0
    beq _abm0
    lda abmActve1
    beq _abm1
    lda abmActve2
    beq _abm2
    lda abmActve3
    beq _abm3
    lda abmActve4
    beq _abm4
    lda abmActve5
    beq _abm5
    lda abmActve6
    beq _abm6
    lda abmActve7
    beq _abm7
    rts
_abm0
    jsr intAbm0
    dec mTotalAbm
    rts
_abm1
    jsr intAbm1
    dec mTotalAbm
    rts
_abm2
    jsr intAbm2
    dec mTotalAbm
    rts
_abm3
    jsr intAbm3
    dec mTotalAbm
    rts
_abm4
    jsr intAbm4
    dec mTotalAbm
    rts
_abm5
    jsr intAbm5
    dec mTotalAbm
    rts
_abm6
    jsr intAbm6
    dec mTotalAbm
    rts
_abm7
    jsr intAbm7
    dec mTotalAbm
    rts


intAbm0
     #initMacro abm0, mLineData, origX0, origY0, destX0, destY0, abmActve0
    jsr initLeftAbm
    rts
intAbm1
     #initMacro abm1, mLineData, origX1, origY1, destX1, destY1, abmActve1
    jsr initLeftAbm
    rts
intAbm2
     #initMacro abm2, mLineData, origX2, origY2, destX2, destY2, abmActve2
    jsr initLeftAbm
    rts
intAbm3
     #initMacro abm3, mLineData, origX3, origY3, destX3, destY3, abmActve3
    jsr initLeftAbm
    rts
intAbm4
    #initMacro abm4, mLineData, origX4, origY4, destX4, destY4, abmActve4
    jsr initLeftAbm
    rts
intAbm5
    #initMacro abm5, mLineData, origX5, origY5, destX5, destY5, abmActve5
    jsr initLeftAbm
    rts
intAbm6
    #initMacro abm6, mLineData, origX6, origY6, destX6, destY6, abmActve6
    jsr initLeftAbm
    rts
intAbm7
    #initMacro abm7, mLineData, origX7, origY7, destX7, destY7, abmActve7
    jsr initLeftAbm
    rts

drawAbm
    lda (POINTER_ACTIVE)
    cmp #0
    bne _move
    rts
_saveLineData
    ;save line data for later

    ldy #0
_loop
    lda (POINTER_TX),y
    sta (POINTER_ABM),y
    iny
    cpy #$19
    bne _loop
    rts
_move
    ldy #0
_setLineDatagetPixel
    lda (POINTER_ABM),y
    sta (POINTER_TX),y
    iny
    cpy #$19
    bne _setLineDatagetPixel

    jsr linestep
    jsr getOriginY
    cmp (POINTER_DESTY)
    bcs _ok
    bcc _deactivte
    rts
_ok
    lda #4
    jsr setPixelColor
    jsr putPixel
    bra _saveLineData
    rts
_deactivte
    dec mAbmCount
    lda #0
    sta (POINTER_ACTIVE)

    lda (POINTER_SOURCEX)
    pha
    ldy #1
    lda (POINTER_SOURCEX),y
    tax
    pla
    jsr setOrginX

    lda (POINTER_SOURCEY)
    pha
    ldy #1
    lda (POINTER_SOURCEY),y
    tax
    pla
    jsr setOrginY

    lda (POINTER_DESTX)
    pha
    ldy #1
    lda (POINTER_DESTX),y
    tax
    pla
    jsr setDestX


    lda (POINTER_DESTY)
    pha
    ldy #1
    lda (POINTER_DESTY),y
    tax
    pla
    jsr setDestY


    jsr getDestX
    jsr explosion.setX
    jsr getDestY
    jsr explosion.setY
    jsr explosion.start

    lda #0
    jsr setPixelColor
    jsr do_line
    lda #112
    jsr setPixelColor

    rts

initLeftAbm
    lda mAbmCount
    cmp #8
    bcc _activate
    rts
_activate
    inc mAbmCount
    jsr setupPath
    jsr lineInit
    jsr putPixel
    jsr linestep
    jsr putPixel
    lda #1
    sta (POINTER_ACTIVE)
    jsr psg.playABM
    jsr lineToAbm
    rts

lineToAbm
    ldy #0
_loop
    lda (POINTER_TX),y
    sta (POINTER_ABM),y
    iny
    cpy #$19
    bne _loop
    rts


setupPath
    lda (POINTER_ACTIVE)
    cmp #0
    beq _setup
    rts
_setup
    lda <#160
    ldx >#160
    jsr setOrginX
    lda <#220
    ldx >#220
    jsr setOrginY

    jsr getMouseClickX
    sec
    sbc #24
    pha
    txa
    sbc #0
    tax
    pla
    jsr setDestX
    jsr getMouseClickY
    sec
    sbc #24
    pha
    txa
    sbc #0
    tax
    pla
    jsr setDestY

    jsr getOriginX
    sta (POINTER_SOURCEX)
    txa
    ldy #1
    sta (POINTER_SOURCEX),y

    jsr getOriginY
    sta (POINTER_SOURCEY)
    txa
    ldy #1
    sta (POINTER_SOURCEY),y

    jsr getDestX
    sta (POINTER_DESTX)
    txa
    ldy #1
    sta (POINTER_DESTX),y

    jsr getDestY
    sta (POINTER_DESTY)
    txa
    ldy #1
    sta (POINTER_DESTY),y
    rts

initMacro .macro
    lda <#\1
    sta POINTER_ABM
    lda >#\1
    sta POINTER_ABM + 1

    lda <#\2
    sta POINTER_TX
    lda >#\2
    sta POINTER_TX + 1

    lda #<\3
    sta POINTER_SOURCEX
    lda #>\3
    sta POINTER_SOURCEX + 1

    lda #<\4
    sta POINTER_SOURCEY
    lda #>\4
    sta POINTER_SOURCEY + 1

    lda #<\5
    sta POINTER_DESTX
    lda #>\5
    sta POINTER_DESTX + 1

    lda #<\6
    sta POINTER_DESTY
    lda #>\6
    sta POINTER_DESTY + 1

    lda #<\7
    sta POINTER_ACTIVE
    lda #>\7
    sta POINTER_ACTIVE + 1
.endmacro

getReaminingTotal
    lda mTotalAbm
    rts
.endsection
.section variables
abm0
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
abmActve0 .byte $0
abmFrame0 .byte $0
abmDestX0 .byte $00,$00
origX0 .byte $00, $00
origY0 .byte $00, $00
destX0 .byte $00, $00
destY0 .byte $00, $00

abm1
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
     .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
abmActve1 .byte $0
abmFrame1 .byte $0
abmDestX1 .byte $00,$00
origX1 .byte $00, $00
origY1 .byte $00, $00
destX1 .byte $00, $00
destY1 .byte $00, $00

abm2
     .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
abmActve2 .byte $0
abmFrame2 .byte $0
abmDestX2 .byte $00,$00
origX2 .byte $00, $00
origY2 .byte $00, $00
destX2 .byte $00, $00
destY2 .byte $00, $00

abm3
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
abmActve3 .byte $0
abmDestX3 .byte $00,$00
origX3 .byte $00, $00
origY3 .byte $00, $00
destX3 .byte $00, $00
destY3 .byte $00, $00

abm4
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
abmActve4 .byte $0
abmFrame4 .byte $0
abmDestX4 .byte $00,$00
origX4 .byte $00, $00
origY4 .byte $00, $00
destX4 .byte $00, $00
destY4 .byte $00, $00

abm5
     .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
abmActve5 .byte $0
abmFrame5 .byte $0
abmDestX5 .byte $00,$00
origX5 .byte $00, $00
origY5 .byte $00, $00
destX5 .byte $00, $00
destY5 .byte $00, $00

abm6
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
    .byte $00
abmActve6 .byte $0
abmFrame6 .byte $0
abmDestX6 .byte $00,$00
origX6 .byte $00, $00
origY6 .byte $00, $00
destX6 .byte $00, $00
destY6 .byte $00, $00


abm7
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
abmActve7 .byte $0
abmDestX7 .byte $00,$00
origX7 .byte $00, $00
origY7 .byte $00, $00
destX7 .byte $00, $00
destY7 .byte $00, $00

mAbmCount
    .byte $00
mFireDelay
    .byte $00
mTotalAbm
    .byte $00
.endsection
.endnamespace


