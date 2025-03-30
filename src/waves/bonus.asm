.section code

initBonusStuff
    lda #stateWaveOver
    sta mState

    ;sta mBonusTrackerAbm

    jsr cities.getReamainingTotal
    sta mBonusTrackerCityies

    lda #<mBonus
    ldx #>mBonus
    ldy #10
    jsr drawText

    ;jsr resetBonusScore
    jsr clearScreenMemory
    jsr clearExtMem

    lda #60
    sta mBonusFrameDelay

    jsr initPsg

    rts

waveOver
    jsr psg.turnOffExplosion
    jsr cruise.reset
    jsr score.handle
    jsr plane.reset
    jsr saucer.reset
    jsr setSpeed
    jsr showAbmBonus
    jsr showCityBonus
    jsr checkExtraCity
    jsr site.hide
    ;jsr rebuildCities
    ;jsr icbm.targetCity


   ; jsr icbm.rese
    jsr resetMouse
    jsr resetKeys
    lda #8
    jsr clearExtMem
    rts

showAbmBonus
    lda mAbmBonusComplete
    cmp #1
    beq _skip
    jsr abm.getReaminingTotal
    cmp #0
    bne _addAbmBonus
    lda #waveFrameDelay
    sta mWaveFrameDelay
    lda #1
    sta mAbmBonusComplete
_skip
    rts
_addAbmBonus
    dec mWaveFrameDelay
    nop
    nop
    nop
    nop
    lda mWaveFrameDelay
    cmp #0
    beq _showOnScreen
    bmi _showOnScreen
    rts
_showOnScreen
    jsr psg.playBonus
    lda #$5
    jsr score.addBonus
    lda #$5
    jsr score.addScore
    jsr abm.removeAbm
    lda #waveFrameDelay
    sta mWaveFrameDelay
    lda #2
    sta MMU_IO_CTRL

    lda <#$C000 + (40 * 12 + 5)
    sta POINTER_TXT
    lda >#$C000 + (40 * 12 + 5)
    sta POINTER_TXT + 1

    ldy #0
    jsr getBonusScoreDigit3
    tax
    lda mNumbers, x
    sta (POINTER_TXT),y

    iny
    jsr getBonusScoreDigit2
    tax
    lda mNumbers, x
    sta (POINTER_TXT),y

    iny
    jsr getBonusScoreDigit1
    tax
    lda mNumbers, x
    sta (POINTER_TXT),y
    iny

    jsr getBonusScoreDigit0
    tax
    lda mNumbers, x
    sta (POINTER_TXT),y
    iny
    lda <#$C000 + (40 * 12 + 10)
    sta POINTER_TXT
    lda >#$C000 + (40 * 12 + 10)
    sta POINTER_TXT + 1
    ldy mBonusIdx
    lda #0
    sta (POINTER_TXT), y
    lda #0
    sta MMU_IO_CTRL
    inc mBonusIdx
    jsr abm.getReaminingTotal
    cmp #0
    beq _resetIdx
    rts
_resetIdx
    stz mBonusIdx
    jsr resetBonusScore
    rts

showCityBonus
    lda mAbmBonusComplete
    cmp #0
    beq _skip
    lda mCitiesBonusComplete
    cmp #1
    beq _skip
    jsr abm.getReaminingTotal
    cmp #0
    beq _citiesLeft
_skip
    rts
_citiesLeft
    lda mBonusTrackerCityies
    cmp #0
    bne _addBonus
    rts
_addBonus
    dec mWaveFrameDelay
    nop
    nop
    nop
    nop
    lda mWaveFrameDelay
    cmp #0
    beq _showOnScreen
    bmi _showOnScreen
    rts
_showOnScreen
    jsr psg.playBonus
    lda #$99
    jsr score.addBonus
    lda #$01
    jsr score.addBonus
    lda #$99
    jsr score.addScore
    lda #$01
    jsr score.addScore
    dec mBonusTrackerCityies
    lda #waveFrameDelay
    sta mWaveFrameDelay
    lda #2
    sta MMU_IO_CTRL

    lda <#$C000 + (40 * 13 + 5)
    sta POINTER_TXT
    lda >#$C000 + (40 * 13 + 5)
    sta POINTER_TXT + 1
    ldy #0
    jsr getBonusScoreDigit3
    tax
    lda mNumbers, x
    sta (POINTER_TXT),y
    iny
    jsr getBonusScoreDigit2
    tax
    lda mNumbers, x
    sta (POINTER_TXT),y
    iny
    jsr getBonusScoreDigit1
    tax
    lda mNumbers, x
    sta (POINTER_TXT),y
    iny
    jsr getBonusScoreDigit0
    tax
    lda mNumbers, x
    sta (POINTER_TXT),y

    lda <#$C000 + (40 * 13 + 11)
    sta POINTER_TXT
    lda >#$C000 + (40 * 13 + 11)
    sta POINTER_TXT + 1
    ldy mBonusIdx
    lda #1
    sta (POINTER_TXT), y
    iny
    lda #2
    sta (POINTER_TXT), y
    lda #0
    sta MMU_IO_CTRL
    inc mBonusIdx
    inc mBonusIdx
    lda mBonusTrackerCityies
    cmp #0
    beq _reset
    rts
_reset
    lda #1
    sta mCitiesBonusComplete
    lda #waveFrameDelay
    sta mWaveFrameDelay
    jsr resetBonusScore
    rts

checkExtraCity
    lda mAbmBonusComplete
    cmp #1
    bne _skip
    lda mCitiesBonusComplete
    cmp #1
    bne _skip
    ; dec mWaveFrameDelay
    ; lda mWaveFrameDelay
    ; cmp #0
    ; bne _skip
    lda #stateBonusOverDelay
    sta mState
    jsr getBonusLifeScoreDigit4
    cmp #1
    beq _addExtraCity
_skip
    jsr rebuildCities
    rts
_addExtraCity
    lda mExtraCityTracker
    clc
    adc #1
    sta mExtraCityTracker
    jsr psg.playBonusCity
    jsr setBonusRollOver
_noBonusCity
    jsr rebuildCities
    rts

rebuildCities
    ldx #0
_checkBonusLeft
    cpx #6
    bcs _end
    jsr cities.getReamainingTotal
    cmp #6
    bcs _end
    lda mExtraCityTracker
    cmp #0
    bne _rebuild
_end
    rts
_rebuild
    inx
    jsr cities.renewCity
    sec
    lda mExtraCityTracker
    sbc #1
    sta mExtraCityTracker
    jsr _checkBonusLeft
    rts



bonusOverDelay
    lda mBonusFrameDelay
    cmp #0
    beq _end
    dec mBonusFrameDelay
    jsr getRandom
    tay
    jsr getRandom
    tax
    jsr getRandom
    jsr setBackgroundColor
    jsr clearScreenMemory
    rts
_end
    lda #stateStart
    sta mState
    jsr clearScreenMemory

    ; lda #0
    ; ldx #0
    ; ldy #0
    ; jsr setBackgroundColor

    jsr reset
    jsr icbm.reset
    jsr abm.reset
    jsr explosion.reset
    inc mCurrentWave
    jsr icbm.decMaxY
    jsr setSpeed

    rts
.endsection

.section variables
mCitiesBonusComplete
    .byte $00
mAbmBonusComplete
    .byte $00
mBonusTrackerCityies
    .byte $00
mWaveFrameDelay
    .byte $00
mBonusIdx
    .byte $00
mBonusFrameDelay
    .byte $00
mExtraCityTracker
    .byte $00
mBonus
    .text '           Bonus Points'
    .byte $00
.endsection