icbm .namespace
.section code
init
    jsr reset
    stz  mSpeedTracker
    stz  mSpeedTracker + 1
    stz mLaunchNext
    stz mLaunchCount
   ; jsr newAttack
    rts

reset
    lda #$ff
    sta mMaxLaunch
    rts
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
;      pha
;     phx
;     phy
;     lda mSpeedTracker
;     clc
;     adc mSpeed
;     sta mSpeedTracker
;     lda mSpeedTracker + 1
;     adc #0
;     sta mSpeedTracker + 1
;     lda  mSpeedTracker + 1
;     cmp #0
;     bne _move
;     ply
;     plx
;     pla
;     rts
; _move
;     lda  mSpeedTracker + 1
;     cmp  mSpeed + 1
;     beq _okToMove_reset
;     bcc _okToMove
;     ply
;     plx
;     pla
;     rts
; _okToMove_reset
;     stz mSpeedTracker + 1
; _okToMove
;     inc mOkToMove
;     jsr draw
;     stz mOkToMove
;     stz mLaunchNext
;   ;  stz mSpeedTracker + 1
;     ply
    ; plx
    ; pla
    jsr draw
    rts

draw
    jsr debug
    jsr initMissle0
    jsr moveMissile0
    jsr deactivate
    rts

moveMissile0
    lda mIcbmStatus0
    cmp #activeStatus
    beq _move
    rts
_move
    lda #2
    jsr setPixelColor
    jsr setLineData
    jsr linestep
    jsr putPixel
    jsr saveLineData
    jsr getOriginY
    sta mIcbmCurrentY0
    cmp #maxY
    bcs _deactivate
    rts
_deactivate
    lda #deactivateStatus
    sta mIcbmStatus0
    rts

initMissle0
    lda mIcbmStatus0
    cmp #inactiveStatus
    beq _checkReady
    rts
_checkReady
    jsr isMissleReady
    bcc _activateMissle
    rts
_activateMissle
    lda #activeStatus
    sta mIcbmStatus0

    ;start
    jsr generateRandomX
    sta mIcbmStartX0
    stx mIcbmStartX0 + 1
    lda #0
    sta mIcbmStartY0

    ;Dest
    jsr generateRandomX
    sta mIcbmDestX0
    stx mIcbmDestX0 + 1

    lda #maxY
    sta mIcbmDestY0

    ;init path
    ;set start
    lda mIcbmStartX0
    ldx mIcbmStartX0 + 1
    jsr setOrginX

    lda mIcbmStartY0
    ldx #0
    jsr setOrginY

    ;set dest
    lda mIcbmDestX0
    ldx mIcbmDestX0 + 1
    jsr setDestX

    lda mIcbmDestY0
    ldx #0
    jsr setDestY

    jsr lineInit
    jsr linestep
    lda #2
    jsr setPixelColor
    jsr putPixel

    jsr saveLineData
    rts

deactivate
    lda mIcbmStatus0
    cmp #deactivateStatus
    beq _deactivate
    rts
_deactivate
     lda #0
    jsr setPixelColor
    lda mIcbmStartX0
    ldx mIcbmStartX0 + 1
    jsr setOrginX

    lda mIcbmStartY0
    lda #0
    jsr setOrginY

    lda mIcbmDestX0
    ldx mIcbmDestX0 + 1
    jsr setDestX

    lda mIcbmDestY0
    ldx #0
    jsr setDestY

    jsr do_line

    lda #inactiveStatus
    sta mIcbmStatus0
    rts

saveLineData
    lda <#mLineData
    sta POINTER_SRC
    lda >#mLineData
    sta POINTER_SRC + 1

    lda <#mIcbmPathData0
    sta POINTER_DST
    lda >#mIcbmPathData0
    sta POINTER_DST + 1
    ldy #0
_saveLineData
    lda (POINTER_SRC),y
    sta (POINTER_DST),y
    iny
    cpy #19
    bcc _saveLineData
    rts

setLineData
    lda <#mIcbmPathData0
    sta POINTER_SRC
    lda >#mIcbmPathData0 + 1
    sta POINTER_SRC + 1

    lda <#mLineData
    sta POINTER_DST
    lda >#mLineData + 1
    sta POINTER_DST + 1
    ldy #0
_setLineData
    lda (POINTER_SRC),y
    sta (POINTER_DST),y
    iny
    cpy #19
    bcc _setLineData
    rts


;A register is current y
isMissilePastYPos
    cmp mLaunchYPos
    bcs _yes
    sec
    rts
_yes
    clc
    rts

areAllMissilesPastY
    lda mIcbmCurrentY0
    jsr isMissilePastYPos
    bcs _no
    bra _yes
_no
    sec
    rts
_yes
    clc
    rts

isMissleReady
    lda mLaunchCount
    cmp #4
    bcc _yes
    jsr areAllMissilesPastY
    bcc _yes
_no
    sec
    rts
_yes
    clc
    rts


generateRandomX
_tryAgain
    jsr getRandom
    sta mrandX
    jsr getRandom
    sta mrandX + 1
_checkOver320
    lda mrandX + 1
    cmp >#319
    beq _checkLo
    bcs _tryAgain
    bra _returnValues
    rts
_checkLo
    lda mrandX
    cmp <#319
    bcs _tryAgain
    lda r_seed
    asl r_seed
    sta r_seed
    bra _returnValues
    rts
_returnValues
    lda mrandX
    ldx mrandX + 1
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


.endsection
.section variables
maxY = 225
icbm_lengh = icbm0_end - icbm0
inactiveStatus = 00
activeStatus = 01
deactivateStatus = 02

icbmTable
    .word mIcbmStatus0
    .word mIcbmStatus1

mIcbmStatus0
    .byte $0
mIcbmCurrentY0
    .byte $00
mIcbmStartX0
    .byte $00, $00
mIcbmStartY0
    .byte $00
mIcbmDestX0
    .byte $00, $00
mIcbmDestY0
    .byte $00
mIcbmPathData0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .byte $0
    .byte $00
    .byte $00

mIcbmStatus1
    .byte $0
    .byte $00
    .byte $00, $00
    .byte $00
    .byte $00, $00
    .byte $00
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .byte $0
    .byte $00
    .byte $00

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
origX1 .word $00
origY1 .word $00
destX1 .word $00
destY1 .word $00

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
origX2 .word $00
origY2 .word $00
destX2 .word $00
destY2 .word $00

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
origX3 .word $00
origY3 .word $00
destX3 .word $00
destY3 .word $00

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
origX4 .word $00
origY4 .word $00
destX4 .word $00
destY4 .word $00

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
origX5 .word $00
origY5 .word $00
destX5 .word $00
destY5 .word $00

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
origX7 .word $00
origY7 .word $00
destX7 .word $00
destY7 .word $00
icbm_end
frameTrack
    .byte $00
mrandX
    .byte $00, $00
mrandY
    .byte $00
mSpeed
    .byte $00, $00
mSpeedTracker
    .byte $00, $00
mOkToMove
    .byte $00
mLaunchWait
    .byte 100, $00
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
mLaunchYPos
    .byte $00
.endsection
.endnamespace