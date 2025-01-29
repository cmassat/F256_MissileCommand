icbm .namespace
.section code
init
    lda #112
    jsr setPixelColor
    lda #0
    sta icbmActve0
    sta icbmActve1
    sta icbmActve2
    sta icbmActve3
    sta icbmActve4
    sta icbmActve5
    sta icbmActve6
    sta icbmActve7

    sta icbmFrame0
    sta icbmActve1
    sta icbmFrame2
    sta icbmFrame3
    sta icbmFrame4
    sta icbmFrame5
    sta icbmFrame6
    sta icbmFrame7
    rts

drawMissle0
    lda <#icbm0
    sta POINTER_ICBM
    lda >#icbm0
    sta POINTER_ICBM + 1

    lda <#mLineData
    sta POINTER_TX
    lda >#mLineData
    sta POINTER_TX + 1

    lda icbmActve0
    cmp #0
    bne _move

    jsr setupRandomPath

    jsr getOrginX
    sta origX0
    stx origX0 + 1

    jsr getOrginY
    sta origY0
    stx origY0 + 1

    jsr getDestX
    sta destX0
    stx destX0 + 1

    jsr getDestY
    sta destY0
    stx destY0 + 1

    jsr lineInit
    jsr putPixel
    jsr linestep
    jsr putPixel
    lda #1
    sta icbmActve0
_saveLineData
    ;save line data for later

    ldy #0
_loop
    lda (POINTER_TX),y
    sta (POINTER_ICBM),y
    iny
    cpy lineDataLength
    bne _loop

    rts
_move
    lda icbmFrame0
    cmp #wave0
    beq _goodFrame
    inc icbmFrame0
    rts
_goodFrame
    stz icbmFrame0

    ldy #0
_setLineDatagetPixel
    lda (POINTER_ICBM),y
    sta (POINTER_TX),y
    iny
    cpy lineDataLength
    bne _setLineDatagetPixel

    jsr linestep
    jsr getOrginY
    cmp #215
    bne _ok
    bcs _deactivte
    jsr getPixel
    cmp #112
    beq _ok
    cmp #0
    bne _deactivte
_ok
    jsr putPixel
    bra _saveLineData
    rts
_deactivte
    stz icbmActve0



    lda origX0
    ldx origX0 + 1
    jsr setOrginX

    lda origY0
    ldx origY0 + 1
    jsr setOrginY

    lda destX0
    ldx destX0 + 1
    jsr setDestX

    lda destY0
    ldx destY0 + 1
    jsr setDestY

    lda #0
    jsr setPixelColor
    jsr do_line
    lda #112
    jsr setPixelColor
    rts



drawMissle1
    lda <#icbm1
    sta POINTER_ICBM
    lda >#icbm1
    sta POINTER_ICBM + 1

    lda <#mLineData
    sta POINTER_TX
    lda >#mLineData
    sta POINTER_TX + 1

    lda icbmActve1
    cmp #0
    bne _move

    jsr setupRandomPath

    jsr getOrginX
    sta origX1
    stx origX1 + 1

    jsr getOrginY
    sta origY1
    stx origY1 + 1

    jsr getDestX
    sta destX1
    stx destX1 + 1

    jsr getDestY
    sta destY1
    stx destY1 + 1

    jsr lineInit
    jsr putPixel
    jsr linestep
    jsr putPixel
    lda #1
    sta icbmActve1
_saveLineData
    ;save line data for later

    ldy #0
_loop
    lda (POINTER_TX),y
    sta (POINTER_ICBM),y
    iny
    cpy lineDataLength
    bne _loop

    rts
_move
    lda icbmFrame1
    cmp #wave0
    beq _goodFrame
    inc icbmFrame1
    rts
_goodFrame
    stz icbmFrame1

    ldy #0
_setLineDatagetPixel
    lda (POINTER_ICBM),y
    sta (POINTER_TX),y
    iny
    cpy lineDataLength
    bne _setLineDatagetPixel

    jsr linestep
    jsr getOrginY
    cmp #215
    bne _ok
    bcs _deactivte
    jsr getPixel
    cmp #112
    beq _ok
    cmp #0
    bne _deactivte
_ok
    jsr putPixel
    bra _saveLineData
    rts
_deactivte
    stz icbmActve1



    lda origX1
    ldx origX1 + 1
    jsr setOrginX

    lda origY1
    ldx origY1 + 1
    jsr setOrginY

    lda destX1
    ldx destX1 + 1
    jsr setDestX

    lda destY1
    ldx destY1 + 1
    jsr setDestY

    lda #0
    jsr setPixelColor
    jsr do_line
    lda #112
    jsr setPixelColor
    rts

setupRandomPath
    jsr generateOriginX
    lda mrandXStart
    ldx mrandXStart + 1
    jsr setOrginX
    lda <#0
    ldx >#0
    jsr setOrginY

    jsr generateDestX
    lda mrandXStart
    ldx mrandXStart + 1
    jsr setDestX
    lda <#215
    ldx >#215
    jsr setDestY

    rts


generateOriginX
_tryAgain
    jsr getRandom
    sta mrandXStart
    jsr getRandom
    sta mrandXStart + 1
_checkOver320
    lda mrandXStart + 1
    cmp >#320
    beq _checkLo
    bcs _tryAgain
    rts
_checkLo
    lda mrandXStart
    cmp <#320
    bcs _tryAgain
    lda r_seed
    asl
    sta r_seed
    rts

generateDestX
_tryAgain
    jsr getRandom
    sta mrandXStart
    jsr getRandom
    sta mrandXStart + 1
_checkOver320
    lda mrandXStart + 1
    cmp >#300
    beq _checkLo
    bcs _tryAgain
    rts
_checkLo
    lda mrandXStart
    cmp <#300
    bcs _tryAgain
    lda r_seed
    asl
    sta r_seed
    rts


.endsection
.section variables
icbm0
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
icbmActve0 .byte $0
icbmFrame0 .byte $0
icbmDestX0 .byte $00,$00
origX0 .byte $00, $00
origY0 .byte $00, $00
destX0 .byte $00, $00
destY0 .byte $00, $00

icbm1
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    .byte $00
    .byte $00

    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
icbmActve1 .byte $0
icbmFrame1 .byte $0
icbmDestX1 .byte $00,$00
origX1 .byte $00, $00
origY1 .byte $00, $00
destX1 .byte $00, $00
destY1 .byte $00, $00

icbm2
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    .byte $00
    .byte $00

    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
icbmActve2 .byte $0
icbmFrame2 .byte $0
icbmDestX2 .byte $00,$00

icbm3
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    .byte $00
    .byte $00

    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
icbmActve3 .byte $0
icbmFrame3 .byte $0
icbmDestX3 .byte $00,$00

icbm4
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    .byte $00
    .byte $00

    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
icbmActve4 .byte $0
icbmFrame4 .byte $0
icbmDestX4 .byte $00,$00

icbm5
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    .byte $00
    .byte $00

    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
icbmActve5 .byte $0
icbmFrame5 .byte $0
icbmDestX5 .byte $00,$00

icbm6
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    .byte $00
    .byte $00

    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
icbmActve6 .byte $0
icbmFrame6 .byte $0
icbmDestX6 .byte $00,$00


icbm7
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    .byte $00
    .byte $00

    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
icbmActve7 .byte $0
icbmFrame7 .byte $0
icbmDestX7 .byte $00,$00

mrandXStart
    .byte $00, $00
wave0 = 5
wave1 = 5
.endsection
.endnamespace