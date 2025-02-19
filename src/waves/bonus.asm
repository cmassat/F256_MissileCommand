.section code

initBonusStuff
    lda #stateWaveOver
    sta mState
    jsr abm.getReaminingTotal
    sta mBonusTrackerAbm

    jsr cities.getReamainingTotal
    sta mBonusTrackerCityies

    lda #<mBonus
    ldx #>mBonus
    ldy #10
    jsr drawText

    jsr resetBonusScore
    jsr clearScreenMemory
    jsr clearExtMem

    lda #60
    sta mBonusFrameDelay


    rts

waveOver
    jsr explosion.play
    jsr score.handle
    lda mBonusTrackerAbm
    cmp #0
    bne _showAbmBonus
    lda mBonusTrackerCityies
    cmp #0
    bne _showCityBonus
    bra _checkExtraCity
   ; jsr icbm.reset
    jsr reset


    lda #8
    jsr clearExtMem
    rts
_showCityBonus
    jsr showCityBonus
    rts
_showAbmBonus
    jsr showAbmBonus
    rts
_checkExtraCity
    jsr checkExtraCity
    rts
showAbmBonus
    lda mBonusTrackerAbm
    cmp #0
    bne _addAbmBonus
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
    jsr add2BonusScore
    lda #$5
    jsr add2Score
    dec mBonusTrackerAbm
    lda #waveFrameDelay
    sta mWaveFrameDelay
    lda #2
    sta MMU_IO_CTRL

    lda <#$C000 + (40 * 12 + 5)
    sta POINTER_TXT
    lda >#$C000 + (40 * 12 + 5)
    sta POINTER_TXT + 1
    ldy #0
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
    lda <#$C000 + (40 * 12 + 11)
    sta POINTER_TXT
    lda >#$C000 + (40 * 12 + 11)
    sta POINTER_TXT + 1
    ldy mBonusIdx
    lda #0
    sta (POINTER_TXT), y
    lda #0
    sta MMU_IO_CTRL
    inc mBonusIdx
    lda mBonusTrackerAbm
    cmp #0
    beq _resetIdx
    rts
_resetIdx
    stz mBonusIdx
    jsr resetBonusScore
    rts
showCityBonus
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
    jsr add2BonusScore
    lda #$01
    jsr add2BonusScore
    lda #$99
    jsr add2Score
    lda #$01
    jsr add2Score
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
    rts

checkExtraCity
    lda #stateBonusOverDelay
    sta mState
    jsr getScoreDigit4
    cmp mExtraCityTracker
    bne _addExtraCity
    rts
_addExtraCity
    sta mExtraCityTracker
    jsr psg.playBonusCity

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

    lda #0
    ldx #0
    ldy #0
    jsr setBackgroundColor

    jsr reset
    jsr icbm.reset
    jsr abm.reset
    jsr explosion.reset
    inc mCurrentWave
    jsr setSpeed
    jsr  psg.playBonusCity
    rts
.endsection

.section variables
mBonusTrackerAbm
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