icbm .namespace
.section code
init
    stz  mSpeedTracker
    stz  mSpeedTracker + 1
    stz mLaunchCount
    lda #$ff
    sta mMaxLaunch
     jsr reset
    rts

reset
    stz mOkToMove
    stz mTotalLaunch
    stz mLaunchCount
    jsr targetCity
    lda #$64
    sta mLaunchYPos
    ldx #0
    jsr setFirstMissle
_loopOUter
    ldy #0
_loop
    lda #0
    sta (POINTER_ICBM),y
    iny
    cpy #icbmDataLength
    bne _loop
    inx
    cpx #8
    bne _nextMissle
    rts
_nextMissle
    jsr setNextMissle
    bra _loopOUter

    stz frameTrack
    stz mrandX
    stz mrandX + 1
    stz mrandY
    stz mSpeed
    stz mSpeed + 1
    stz mSpeedTracker
    stz mSpeedTracker + 1
    stz mOkToMove
    stz mLaunchWait
    stz mLaunchWait + 1
    stz mLaunchCount
    stz mCurrentWave
    stz mMaxLaunch
    stz mTotalLaunch

    lda #0
    sta mTarget0
    sta mTarget0 + 1
    sta mTarget0 + 2
    sta mTarget1
    sta mTarget1 + 1
    sta mTarget1 + 2
    sta mTarget2
    sta mTarget2 + 1
    sta mTarget2 + 2
    sta mTargetActive0
    sta mTargetActive1
    sta mTargetActive2
    lda $64
    sta mLaunchYPos

    rts
demo
    pha
    phx
    phy

    lda mSpeedTracker
    clc
    adc #$60
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
    jsr draw
    ply
    plx
    pla
    rts

play
    lda mSpeedTracker + 1
    cmp mSpeed + 1
    bne _continue
    stz mSpeedTracker + 1
_continue
    lda mSpeedTracker
    clc
    adc mSpeed
    sta mSpeedTracker
    lda mSpeedTracker + 1
    adc #0
    sta mSpeedTracker + 1

    lda mSpeedTracker + 1
    cmp #1
    bcs _move1
    rts
_move1
    jsr draw
    lda mSpeedTracker + 1
    cmp mSpeed + 1
    bcc _continue
    rts

draw

    jsr initMissle
    jsr moveMissile
    jsr deactivate
    rts

moveMissile
    jsr setFirstMissle
_checkMissile
    lda (POINTER_ICBM)
    cmp #activeStatus
    beq _move
_getNextMissle
    jsr setNextMissle
    jsr isLastMissle
    bcc _end
    bra _checkMissile
_end
    rts
_move
    lda POINTER_ICBM
    clc
    adc #offsetlineData
    sta POINTER_ICBM_LINE

    lda POINTER_ICBM + 1
    adc #0
    sta POINTER_ICBM_LINE + 1

    lda #MISSLE_CLR
    jsr setPixelColor
    jsr setLineData

    jsr linestep
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _explode
    jsr putPixel
    jsr saveLineData


    jsr getOriginY
    ldy #offsetCurrentY
    sta (POINTER_ICBM) ,y
    cmp #maxY
    bcs _deactivate
    bcc _getNextMissle
    rts
_explode
    lda #$25
    jsr score.addScore
    jsr psg.playExplosion
_deactivate
    lda #deactivateStatus
    sta (POINTER_ICBM)
    bra _getNextMissle
    rts

isLastMissle
    lda POINTER_ICBM_TBL + 1
    cmp >#icbmTableEnd
    beq _checkLo
    bra _no
    rts
_checkLo
    lda POINTER_ICBM_TBL
    cmp <#icbmTableEnd
    bne _no
    beq _yes
    rts
_no
    sec
    rts
_yes
    clc
    rts

setFirstMissle
    pha
    phx
    phy
    lda #<icbmTable
    sta POINTER_ICBM_TBL
    lda #>icbmTable
    sta POINTER_ICBM_TBL + 1

    ldy #0
    lda (POINTER_ICBM_TBL),y
    sta POINTER_ICBM ,y
    iny
    lda (POINTER_ICBM_TBL),y
    sta POINTER_ICBM,y
    ply
    plx
    pla
    rts

setNextMissle
    pha
    phx
    phy
    lda POINTER_ICBM_TBL
    clc
    adc #2
    sta POINTER_ICBM_TBL

    lda POINTER_ICBM_TBL + 1
    adc #0
    sta POINTER_ICBM_TBL + 1

    ldy #0
    lda (POINTER_ICBM_TBL),y
    sta POINTER_ICBM ,y
    iny
    lda (POINTER_ICBM_TBL),y
    sta POINTER_ICBM,y
    ply
    plx
    pla
    rts

initMissle
    jsr areAnyMissilesLeft
    bcc _initMore
    rts
_initMore
    ;get first missle
    jsr setFirstMissle
    ;check if missle is inactive and
    ;activate if OK
_checkStatus
    ldy #0
    lda (POINTER_ICBM),y
    cmp #inactiveStatus
    beq _checkReady
    cmp #vanishedStatus
    beq _makeInactive
_nextMissle
    jsr setNextMissle
    jsr isLastMissle
    bcc _end
    bra _checkStatus
_end
    rts
_makeInactive
    lda #inactiveStatus
    sta (POINTER_ICBM)
    bra _nextMissle
    rts
_checkReady
    jsr isMissleReady
    bcc _activateMissle
    bra _nextMissle
    rts
_activateMissle
    lda POINTER_ICBM
    clc
    adc #offsetlineData
    sta POINTER_ICBM_LINE

    lda POINTER_ICBM + 1
    adc #0
    sta POINTER_ICBM_LINE + 1

    lda #activeStatus
    sta (POINTER_ICBM)

    jsr _setCoordinates

    ;init path
    ;set start
    ldy #offsetStartX
    lda (POINTER_ICBM),y
    pha
    iny
    lda (POINTER_ICBM),y
    tax
    pla
    jsr setOrginX

    ldy #offsetStartY
    lda (POINTER_ICBM),y
    ldx #0
    jsr setOrginY
_setDest
    ;set dest
    ldy #offsetDestX
    lda (POINTER_ICBM), y
    pha
    iny
    lda (POINTER_ICBM), y
    tax
    pla
    jsr setDestX
;
    ldy #offsetDestY
    lda (POINTER_ICBM), y
    ldx #0
    jsr setDestY

    jsr lineInit
    jsr linestep
    lda #2
    jsr setPixelColor
   ; jsr do_line
    ;jsr putPixel
    inc mTotalLaunch
    jsr saveLineData
    inc mLaunchCount
    bra _nextMissle
    rts
_setCoordinates
     ;start
    ldy #offsetStartX
    jsr generateRandomX
    sta (POINTER_ICBM), y
    iny
    txa
    sta (POINTER_ICBM), y

    ;Dest
    jsr generateRandomX
    ldy #offsetDestX
    sta (POINTER_ICBM), y
    iny
    txa
    sta (POINTER_ICBM), y

    ldy #offsetDestY
    lda #maxY
    sta (POINTER_ICBM), y
    jsr pickTarget
    jsr pickBunker
    rts

pickTarget
    jsr targetCity0
    jsr targetCity1
    jsr targetCity2
    rts

targetCity0
    lda <#mIcbmStatus0
    cmp POINTER_ICBM
    beq _checkHi
    rts
_checkHi
    lda >#mIcbmStatus0
    cmp POINTER_ICBM + 1
    beq _targetCity0
    rts
_targetCity0
    lda mTarget0
    ldx mTarget0 + 1
    ldy #offsetDestX
    sta (POINTER_ICBM), y
    iny
    txa
    sta (POINTER_ICBM), y

    ldy #offsetDestY
    lda mTarget0 + 2
    sta (POINTER_ICBM), y
    rts

targetCity1
    lda <#mIcbmStatus1
    cmp POINTER_ICBM
    beq _checkHi
    rts
_checkHi
    lda >#mIcbmStatus1
    cmp POINTER_ICBM + 1
    beq _targetCity
    rts
_targetCity
    lda mTarget1
    ldx mTarget1 + 1
    ldy #offsetDestX
    sta (POINTER_ICBM), y
    iny
    txa
    sta (POINTER_ICBM), y

    ldy #offsetDestY
    lda mTarget1 + 2
    sta (POINTER_ICBM), y
    rts

targetCity2
    lda <#mIcbmStatus2
    cmp POINTER_ICBM
    beq _checkHi
    rts
_checkHi
    lda >#mIcbmStatus2
    cmp POINTER_ICBM + 1
    beq _targetCity
    rts
_targetCity
    lda mTarget2
    ldx mTarget2 + 1
    ldy #offsetDestX
    sta (POINTER_ICBM), y
    iny
    txa
    sta (POINTER_ICBM), y

    ldy #offsetDestY
    lda mTarget2 + 2
    sta (POINTER_ICBM), y
    rts

pickBunker
    lda <#mIcbmStatus3
    cmp POINTER_ICBM
    beq _checkHi
    rts
_checkHi
    lda >#mIcbmStatus3
    cmp POINTER_ICBM + 1
    beq _targetBunker
    rts
_targetBunker
    jsr getRandom
    cmp #85
    bcc _bunkerCoord0
    cmp #170
    bcc _bunkerCoord1
    bcs _bunkerCoord2
    rts
_bunkerCoord0
    jsr abm.getBunkerCoord0
    phy
    ldy #offsetDestX
    sta (POINTER_ICBM), y
    iny
    txa
    sta (POINTER_ICBM), y
    ply
    tya
    ldy #offsetDestY
    sta (POINTER_ICBM), y
    rts
_bunkerCoord1
    jsr abm.getBunkerCoord1
    phy
    ldy #offsetDestX
    sta (POINTER_ICBM), y
    iny
    txa
    sta (POINTER_ICBM), y
    ply
    tya
    ldy #offsetDestY
    sta (POINTER_ICBM), y
    rts
_bunkerCoord2
    jsr abm.getBunkerCoord2
    phy
    ldy #offsetDestX
    sta (POINTER_ICBM), y
    iny
    txa
    sta (POINTER_ICBM), y
    ply
    tya
    ldy #offsetDestY
    sta (POINTER_ICBM), y
    rts




targetCity
    lda #inactiveStatus
    sta mTargetActive0
    sta mTargetActive1
    sta mTargetActive2
    jsr locate3Cities
    jsr locate3Cities
    jsr locate3Cities
    rts

locate3Cities
    jsr getRandom
    cmp #42
    bcc _cityCoord0
    cmp #84
    bcc _cityCoord1
    cmp #126
    bcc _cityCoord2
    cmp #168
    bcc _cityCoord3
    cmp #210
    bcc _cityCoord4
    cmp #255
    bcc _cityCoord5
    rts
_cityCoord5
    jsr cityCoordCoord5
    rts
_cityCoord0
    lda cities.mCityActive0
    cmp #cities.activeStatus
    bne _cityCoord1
    jsr cities.getCoord0
    jsr activateTarget
    rts
_cityCoord1
    lda cities.mCityActive1
    cmp #cities.activeStatus
    bne _cityCoord2
    jsr cities.getCoord1
    jsr activateTarget
    rts
_cityCoord2
     lda cities.mCityActive2
    cmp #cities.activeStatus
    bne _cityCoord3
    jsr cities.getCoord2
    jsr activateTarget
    rts
_cityCoord3
    lda cities.mCityActive3
    cmp #cities.activeStatus
    bne _cityCoord4
    jsr cities.getCoord3
    jsr activateTarget
    rts
_cityCoord4
    lda cities.mCityActive4
    cmp #cities.activeStatus
    bne cityCoordCoord5
    jsr cities.getCoord4
    jsr activateTarget
    rts
cityCoordCoord5
    lda cities.mCityActive5
    cmp #cities.activeStatus
    bne _end
    jsr cities.getCoord5
    jsr activateTarget
    rts
_end
    rts

activateTarget
    pha
    lda mTargetActive0
    cmp #inactiveStatus
    bne _pHole1
    pla
    sta mTarget0
    stx mTarget0 + 1
    sty mTarget0 + 2
    lda #activeStatus
    sta mTargetActive0
    rts
_pHole1
    lda mTargetActive1
    cmp #inactiveStatus
    bne _pHole2
    pla
    sta mTarget1
    stx mTarget1 + 1
    sty mTarget1 + 2
    lda #activeStatus
    sta mTargetActive1
    rts
_pHole2
    lda mTargetActive2
    cmp #inactiveStatus
    bne _end
    pla
    sta mTarget2
    stx mTarget2 + 1
    sty mTarget2 + 2
    lda #activeStatus
    sta mTargetActive2
    rts
_end
    pla
    rts

deactivate
    jsr setFirstMissle
_checkStatus
    lda (POINTER_ICBM)
    cmp #deactivateStatus
    beq _deactivate
_getNextMissle
    jsr setNextMissle
    jsr isLastMissle
    bcc _end
    bra _checkStatus
_end
    rts
_deactivate
    ldy #offsetStartX
    lda (POINTER_ICBM), y
    pha
    iny
    lda (POINTER_ICBM), y
    tax
    pla
    jsr setOrginX

    ldy #offsetStartY
    lda (POINTER_ICBM), y
    ldx #0
    jsr setOrginY


    ldy #offsetDestX
    lda (POINTER_ICBM), y
    pha
    iny
    lda (POINTER_ICBM), y
    tax
    pla
    jsr setDestX

    ldy #offsetDestY
    lda (POINTER_ICBM), y
    ldx #0
    jsr setDestY

    lda POINTER_ICBM
    clc
    adc #offsetlineData
    sta POINTER_ICBM_LINE

    lda POINTER_ICBM + 1
    adc #0
    sta POINTER_ICBM_LINE + 1

    lda #0
    jsr setPixelColor
    jsr do_line

    lda #inactiveStatus
    sta (POINTER_ICBM)
    jsr resetLineData
    dec mLaunchCount
    bra _getNextMissle
    rts

resetLineData
    lda <#mLineData
    sta POINTER_SRC
    lda >#mLineData
    sta POINTER_SRC + 1

    ldy #0
_saveLineData
    lda #0
    sta (POINTER_ICBM_LINE),y
    iny
    cpy #lineDataLength
    bcc _saveLineData
    rts

saveLineData
    lda <#mLineData
    sta POINTER_SRC
    lda >#mLineData
    sta POINTER_SRC + 1

    ldy #0
_saveLineData
    lda (POINTER_SRC),y
    sta (POINTER_ICBM_LINE),y
    iny
    cpy #lineDataLength
    bcc _saveLineData
    rts

setLineData
    lda <#mLineData
    sta POINTER_DST
    lda >#mLineData + 1
    sta POINTER_DST + 1
    ldy #0
_setLineData
    lda (POINTER_ICBM_LINE),y
    sta (POINTER_DST),y
    iny
    cpy #lineDataLength
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


isMissleActive
    cmp #activeStatus
    beq _yes
    rts
_no
    sec
    rts
_yes
    clc
    rts

areAllMissilesPastY
    lda mIcbmStatus0
    cmp #activeStatus
    bne _check1
    ldx #offsetCurrentY
    lda mIcbmStatus0, x
    jsr isMissilePastYPos
    bcs _no
_check1
    lda mIcbmStatus1
    cmp #activeStatus
    bne _check2
    ldx #offsetCurrentY
    lda mIcbmStatus1, x
    jsr isMissilePastYPos
    bcs _no
_check2
    lda mIcbmStatus2
    cmp #activeStatus
    bne _check3
    lda mIcbmStatus2, x
    jsr isMissilePastYPos
    bcs _no
_check3
    lda mIcbmStatus3
    cmp #activeStatus
    bne _check4
    lda mIcbmStatus3, x
    jsr isMissilePastYPos
    bcs _no
_check4
    lda mIcbmStatus4
    cmp #activeStatus
    bne _check5
    lda mIcbmStatus4, x
    jsr isMissilePastYPos
    bcs _no
_check5
    lda mIcbmStatus5
    cmp #activeStatus
    bne _check6
    lda mIcbmStatus5, x
    jsr isMissilePastYPos
    bcs _no
_check6
    lda mIcbmStatus6
    cmp #activeStatus
    bne _check7
    lda mIcbmStatus6, x
    jsr isMissilePastYPos
    bcs _no
_check7
    lda mIcbmStatus7
    cmp #activeStatus
    bne _yes
    lda mIcbmStatus7, x
    jsr isMissilePastYPos
    bcs _no
    bra _yes
    rts
_no
    lda #1
    sta mDebug
    sec

    rts
_yes
    lda #0
    sta mDebug
    clc
    rts

isMissleReady
    phy
    phx
    pha
    lda mLaunchCount
    cmp #5
    bne _ok
    lda #1
    sta mOkToMove
_ok
    lda mLaunchCount
    cmp #4
    bcc _yes
    lda mOkToMove
    cmp #1
    beq _yes
    jsr areAllMissilesPastY
    bcc _yes
_no
    pla
    plx
    ply
    sec
    rts
_yes
    pla
    plx
    ply
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
    jsr _checkMinX
_returnOk
    lda mrandX
    ldx mrandX + 1
    rts

_checkMinX
    lda mrandX + 1
    cmp #1
    bcc _checkLoMin
    bra _returnOk
    rts
_checkLoMin
    lda mrandX
    cmp #80 - 32
    bcc _tryAgain
    bra _returnOk
    rts

;a lo
;b hi
setSpeed
    sta mSpeed
    stx mSpeed + 1

    stz mSpeedTracker
    stz mSpeedTracker + 1
    rts

isWaveOver
    jsr areAnyMissilesLeft
    bcs _checkAllInactive
    sec
    rts
_checkAllInactive

    lda mIcbmStatus0
    cmp #inactiveStatus
    bne _no
    lda mIcbmStatus1
    cmp #inactiveStatus
    bne _no
    lda mIcbmStatus2
    cmp #inactiveStatus
    bne _no
    lda mIcbmStatus3
    cmp #inactiveStatus
    bne _no
    lda mIcbmStatus4
    cmp #inactiveStatus
    bne _no
    lda mIcbmStatus5
    cmp #inactiveStatus
    bne _no
    lda mIcbmStatus6
    cmp #inactiveStatus
    bne _no
    lda mIcbmStatus7
    cmp #inactiveStatus
    bne _no
    bra _yes
    rts
_no
    sec
    rts
_yes
    clc
    rts

areAnyMissilesLeft
    lda mTotalLaunch
    cmp mMaxLaunch
    bcc _yes
    sec
    rts
_yes
    clc
    rts

setMaxLaunch
    sta mMaxLaunch
    rts

decMaxY
    lda mLaunchYPos
    cmp #10
    bcs _continue
    rts
_continue
    lda mLaunchYPos
    sec
    sbc #$10
    sta mLaunchYPos
    rts

.endsection
.section variables
maxY = 225
icbm_lengh = icbm0_end - icbm0
inactiveStatus = 00
activeStatus = 01
deactivateStatus = 02
vanishedStatus = 03

offsetStartX = mIcbmStartX0 - mIcbmStatus0
offsetStartY = mIcbmStartY0 - mIcbmStatus0
offsetDestX = mIcbmDestX0 - mIcbmStatus0
offsetDestY = mIcbmDestY0 - mIcbmStatus0
offsetlineData = mIcbmPathData0 - mIcbmStatus0
lineDataLength = mIcbmStatus1 - mIcbmPathData0
icbmDataLength = mIcbmStatus1 - mIcbmStatus0
offsetCurrentY = mIcbmCurrentY0 - mIcbmStatus0

icbmTable
    .word mIcbmStatus0
    .word mIcbmStatus1
    .word mIcbmStatus2
    .word mIcbmStatus3
    .word mIcbmStatus4
    .word mIcbmStatus5
    .word mIcbmStatus6
    .word mIcbmStatus7
icbmTableEnd

icbmCount
    .byte $00

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

mIcbmStatus2
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

mIcbmStatus3
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

mIcbmStatus4
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

mIcbmStatus5
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

mIcbmStatus6
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


mIcbmStatus7
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
mMaxLaunch
    .byte $00
mTotalLaunch
    .byte $00
mLaunchYPos
    .byte $64

mTarget0
    .byte $00,$00,$00
mTargetActive0
    .byte $00
mTarget1
    .byte $00,$00,$00
mTargetActive1
    .byte $00
mTarget2
    .byte $00,$00,$00
mTargetActive2
    .byte $00
.endsection
.endnamespace

