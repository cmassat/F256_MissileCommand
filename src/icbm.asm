icbm .namespace
.section code
init
    jsr reset
    stz  mSpeedTracker
    stz  mSpeedTracker + 1
    stz mLaunchNext
    stz mLaunchCount
    jsr newAttack
    rts

reset
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

    lda #$ff
    sta mMaxLaunch

    stz mLaunchCount
    stz mTotalLaunch
    rts



drawMissle
    lda (POINTER_ACTIVE)
    cmp #0
    bne _move
    jsr initMissle
    lda (POINTER_ACTIVE)
    cmp #0
    bne _saveLineData
    rts
_saveLineData
    ;save line data for later

    ldy #0
_loop
    lda (POINTER_TX),y
    sta (POINTER_ICBM),y
    iny
    cpy #$19
    bne _loop

    rts
_move
  ; lda #0
   ;sta (POINTER_FRAME)

    ldy #0
_setLineDatagetPixel
    lda (POINTER_ICBM),y
    sta (POINTER_TX),y
    iny
    cpy lineDataLength
    bne _setLineDatagetPixel

    jsr linestep
    lda #112
    jsr setPixelColor
    jsr putPixel
    bra _saveLineData
    rts

deactivate
    jsr linestep
    jsr getPixel
    cmp #$20
    beq _turnOff
    cmp #EXPLOSION_CLR
    beq _turnOffAddPoints
    jsr getY
    cmp #230
    bcs _turnOff
    rts
_turnOffAddPoints
    lda #$25
    jsr add2score


_turnOff
    dec mLaunchCount
   ; jsr getOriginX

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

    lda #0
    jsr setPixelColor
    jsr do_line
    lda #112
    jsr setPixelColor
    jsr psg.playExplosion
    rts

initMissle
    lda mTotalLaunch
    cmp mMaxLaunch
    bcc _okToLaunch
    rts
_okToLaunch
    lda mLaunchNext
    cmp #0
    bne _activate
    ;4 or less activate
    lda mLaunchCount
    cmp #4
    bcc _activate
    ;check if we sould wait for next wave
    jsr checkWait
    cpx #0
    beq _nextMissels
    rts
_nextMissels
    ;we waited long enough
    lda #1
    sta mLaunchNext
_activate
    inc mLaunchCount
    inc mTotalLaunch
    jsr setupRandomPath
    jsr lineInit
    jsr putPixel
    jsr linestep
    jsr putPixel
    lda #1
    sta (POINTER_ACTIVE)

    clc
    rts

moveMacro .macro
    lda <#\1
    sta POINTER_ICBM
    lda >#\1
    sta POINTER_ICBM + 1

    lda <#\2
    sta POINTER_TX
    lda >#\2
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

demo
    pha
    phx
    phy
    lda mSpeedTracker
    clc
    adc #$14
    sta mSpeedTracker
    lda mSpeedTracker + 1
    adc #0
    sta mSpeedTracker + 1
    cmp #0
    bne _move
    ply
    plx
    pla
    rts
_move
    stz mSpeedTracker + 1
    inc mOkToMove
    jsr draw
    stz mOkToMove
    stz mLaunchNext
    ply
    plx
    pla
    rts

play
     pha
    phx
    phy
    lda mSpeedTracker
    clc
    adc mSpeed
    sta mSpeedTracker
    lda mSpeedTracker + 1
    adc #0
    sta mSpeedTracker + 1
    lda  mSpeedTracker + 1
    cmp #0
    bne _move
    ply
    plx
    pla
    rts
_move
    lda  mSpeedTracker + 1
    cmp  mSpeed + 1
    beq _okToMove_reset
    bcc _okToMove
    ply
    plx
    pla
    rts
_okToMove_reset
    stz mSpeedTracker + 1
_okToMove
    inc mOkToMove
    jsr draw
    stz mOkToMove
    stz mLaunchNext
  ;  stz mSpeedTracker + 1
    ply
    plx
    pla
    rts

draw
    jsr drawMissle0
    jsr drawMissle1
    jsr drawMissle2
    jsr drawMissle3
    jsr drawMissle4
    jsr drawMissle5
    jsr drawMissle6
    jsr drawMissle7
    rts

drawMissle0
    #moveMacro icbm0, mLineData, origX0, origY0, destX0, destY0, icbmActve0
    jsr drawMissle
    jsr deactivate
    rts
drawMissle1
    #moveMacro icbm1, mLineData, origX1, origY1, destX1, destY1, icbmActve1
    jsr drawMissle
    jsr deactivate
    rts
drawMissle2
    #moveMacro icbm2, mLineData, origX2, origY2, destX2, destY2, icbmActve2
    jsr drawMissle
    jsr deactivate
    rts
drawMissle3
    #moveMacro icbm3, mLineData, origX3, origY3, destX3, destY3, icbmActve3
    jsr drawMissle
    jsr deactivate
    rts
drawMissle4
    #moveMacro icbm4, mLineData, origX4, origY4, destX4, destY4, icbmActve4
    jsr drawMissle
    jsr deactivate
    rts
drawMissle5
    #moveMacro icbm5, mLineData, origX5, origY5, destX5, destY5, icbmActve5
    jsr drawMissle
    jsr deactivate
    rts
drawMissle6
    #moveMacro icbm6, mLineData, origX6, origY6, destX6, destY6, icbmActve6
    jsr drawMissle
    jsr deactivate
    rts
drawMissle7
    #moveMacro icbm7, mLineData, origX7, origY7, destX7, destY7, icbmActve7
    jsr drawMissle
    jsr deactivate
    rts
setupRandomPath
_tryAgain

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
    lda <#$ff
    ldx >#$ff
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

    ldy #1
    lda (POINTER_SOURCEX),y
    cmp (POINTER_DESTX),y
    beq _checkLo
    rts
_checkLo
    lda (POINTER_SOURCEX)
    lda (POINTER_DESTX)
    beq _tryAgain
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
    aslmOkToMove
    sta r_seed
    rts

generateDestX
_tryAgain
    jsr getRandom
    sta mrandXStart
    sta r_seed
    jsr getRandom
    and #%00000001
    stz mrandXStart + 1

    lda mrandXStart
    cmp #$50
    bcc _tryAgain
    lda r_seed
    asl
    sta r_seed
    rts

checkWait
    ldx #0
    ldy #16
    lda icbmActve0
    cmp #0
    beq _check1
    lda icbm0, y
    cmp mLaunchWait
    bcs _check1
    inx
    rts
_check1
    rts
    lda icbmActve1
    cmp #0
    beq _check2
    ldy #16
    lda icbm1, y
    cmp mLaunchWait
    bcc _check2
    inx
    rts
_check2
    lda icbmActve2
    cmp #0
    beq _check3
    lda icbm2, y
    cmp mLaunchWait
    bcs _check3
    inx
    rts
_check3
    lda icbmActve3
    cmp #0
    beq _check4
    lda icbm3, y
    cmp mLaunchWait
    bcs _check4
    inx
    rts
_check4
    lda icbmActve4
    cmp #0
    beq _check5
    lda icbm4, y
    cmp mLaunchWait
    bcs _check5
    inx
    rts
_check5
    lda icbmActve5
    cmp #0
    beq _check6
    lda icbm5, y
    cmp mLaunchWait
    bcs _check6
    inx
    rts
_check6
    lda icbmActve6
    cmp #0
    beq _check7
    lda icbm6, y
    cmp mLaunchWait
    bcs _check7
    inx
    rts
_check7
    lda icbmActve7
    cmp #0
    beq _end
    lda icbm7, y
    cmp mLaunchWait
    bcs _end
    inx
_end
    rts

newAttack
    lda mCurrentWave
    asl
    sta pointer
    lda #100
    sec
    sbc pointer
    sta mLaunchWait
    ;202 - 2 * wave_number ; sta mydirection
    rts

;a lo
;b hi
setSpeed
    sta mSpeed
    stx mSpeed + 1
    rts

getX
    phy
    ldy #14
    lda (POINTER_ICBM), y
    pha
    iny
    lda (POINTER_ICBM), y
    tax
    pla
    ply
    rts

getY
    phy
    ldy #16
    lda (POINTER_ICBM), y
    pha
    iny
    lda (POINTER_ICBM), y
    tax
    pla
    ply
    rts

setMaxLaunch
    sta mMaxLaunch
    rts

isWaveOver
    lda mTotalLaunch
    cmp mMaxLaunch
    bcs _waitAllDeactive
    sec
    rts
_waitAllDeactive
    lda icbmActve0
    cmp #1
    beq _stillActive
    lda icbmActve1
    cmp #1
    beq _stillActive
    lda icbmActve3
    cmp #1
    beq _stillActive
    lda icbmActve4
    cmp #1
    beq _stillActive
    lda icbmActve5
    cmp #1
    beq _stillActive
    lda icbmActve6
    cmp #1
    beq _stillActive
    lda icbmActve7
    cmp #1
    beq _stillActive
    clc
    rts
_stillActive
    sec
    rts
.endsection
.section variables
icbm0
    .word $0 ;dx
    .word $0  ; dy 2
    .word $0  ; xi 4
    .word $0  ; yi 6
    .word $0 ; ai 8
    .word $0 ; bi 10
    .word $0 ; decision' 12
    ;poin.byte $0 ;
    .word $0 ; currentx 14
    .word $0 ; currenty
    .word $0 ; destX
    .word $0 ; destY
    .byte $0  ; steep
    .byte $00 ; dir
    .byte $00 ;dir
icbmActve0 .byte $0
icbmFrame0 .byte $0
icbmDestX0 .byte $00,$00
origX0 .byte $00, $00
origY0 .byte $00, $00
destX0 .byte $00, $00
destY0 .byte $00, $00

icbm1
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
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
icbmActve2 .byte $0
icbmFrame2 .byte $0
icbmDestX2 .byte $00,$00
origX2 .byte $00, $00
origY2 .byte $00, $00
destX2 .byte $00, $00
destY2 .byte $00, $00

icbm3
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
icbmActve3 .byte $0
icbmFrame3 .byte $0
icbmDestX3 .byte $00,$00
origX3 .byte $00, $00
origY3 .byte $00, $00
destX3 .byte $00, $00
destY3 .byte $00, $00

icbm4
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
icbmActve4 .byte $0
icbmFrame4 .byte $0
icbmDestX4 .byte $00,$00
origX4 .byte $00, $00
origY4 .byte $00, $00
destX4 .byte $00, $00
destY4 .byte $00, $00

icbm5
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
icbmActve5 .byte $0
icbmFrame5 .byte $0
icbmDestX5 .byte $00,$00
origX5 .byte $00, $00
origY5 .byte $00, $00
destX5 .byte $00, $00
destY5 .byte $00, $00

icbm6
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
icbmActve6 .byte $0
icbmFrame6 .byte $0
icbmDestX6 .byte $00,$00
origX6 .byte $00, $00
origY6 .byte $00, $00
destX6 .byte $00, $00
destY6 .byte $00, $00


icbm7
.word $0 ;dx
    .word $0  ; dy 2
    .word $0  ; xi 4
    .word $0  ; yi 6
    .word $0 ; ai 8
    .word $0 ; bi 10
    .word $0 ; decision' 12
    ;poin.byte $0 ;
    .word $0 ; currentx 14
    .word $0 ; currenty
    .word $0 ; destX
    .word $0 ; destY
    .byte $0  ; steep
    .byte $00 ; dir
    .byte $00 ;dir
icbmActve7 .byte $0
icbmFrame7 .byte $0
icbmDestX7 .byte $00,$00
origX7 .byte $00, $00
origY7 .byte $00, $00
destX7 .byte $00, $00
destY7 .byte $00, $00

frameTrack
    .byte $00
mrandXStart
    .byte $00, $00

mSpeed
    .byte $00, $00
mSpeedTracker
    .byte $00, $00
mOkToMove
    .byte $00
mLaunchWait
    .byte $00, $00
mLaunchCount
    .byte $00
mCurrentWave
    .byte $00
mLaunchNext
    .byte $00
mMaxLaunch
    .byte $00
mTotalLaunch
    .byte $00
.endsection
.endnamespace