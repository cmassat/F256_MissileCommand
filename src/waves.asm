waves .namespace
.section code

init
    stz mCurrentWave
    stz mState
    jsr reset
    rts

reset
    lda #waveFrameDelay
    sta mWaveFrameDelay
    stz mBonusIdx
    rts

handle
     lda #state.wave1
    jsr state.is
    bcc _ok
    rts
_ok

    lda mState
    cmp #0
    beq _setup
    cmp #stateInfo
    beq _info
    cmp #statePlay
    beq _play
    cmp #stateWaveOver
    beq _waveOver
    rts
_setup
    jsr setup
    rts
_info
    jsr info
    dec mDelayTimer
    rts
_play
    jsr play
    rts
_waveOver
    jsr waveOver
    rts

play
    jsr icbm.isWaveOver
    bcs _continue
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

    rts
_continue
    jsr score.handle

    ;set max ICBM for Wave
    ldy mCurrentWave
    lda mIcbmNumber, y
    jsr icbm.setMaxLaunch

    jsr site.draw
    jsr icbm.play
    jsr abm.play
    jsr explosion.play
    jsr cities.play

    rts

info
    jsr cities.init
    lda mDelayTimer
    cmp #0
    beq _next
    rts
_next
    jsr clearScreenMemory
    inc mState
    rts

setSpeed
    lda mCurrentWave
    cmp #0
    beq _setWave0
    rts
_setWave0
    lda #14
    ldx #1
    jsr icbm.setSpeed
    rts

waveOver
    jsr explosion.play
    jsr score.handle
    lda mBonusTrackerAbm
    cmp #0
    bne showAbmBonus
    lda mBonusTrackerCityies
    cmp #0
    bne _showCityBonus
    jsr icbm.reset
    rts
_showCityBonus
    jsr showCityBonus
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
    lda #$25
    jsr add2BonusScore
    lda #$25
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

setup
    jsr setSpeed
    jsr icbm.reset
    jsr hideAllSprites

    lda #0
    ldx #0
    ldy #0
    jsr setBackgroundColor

    jsr clearVideo
    jsr clearScreenMemory
    jsr setBitmapLayer0
    jsr enableText
    jsr enableGrafix
    jsr enableSprite
    jsr enableBitmap
    jsr setVideo
    jsr clearExtMem

    jsr setDoubleText
    lda #<mStartMessage
    ldx #>mStartMessage
    ldy #10
    jsr drawText

    lda #<mPoints
    ldx #>mPoints
    ldy #12
    jsr drawText

    lda #blue
    ldx #black
    ldy #10
    jsr setColorByLine

    lda #blue
    ldx #black
    ldy #12
    jsr setColorByLine



    jsr psg.playPulse

    lda #127
    sta mDelayTimer
    sta mDelayTimer + 1
    ;jsr showBitmap


   ; jsr setupBitmap0
  ;  jsr setupBitmap0
    inc mState
    rts



setupBitmap0
    lda #0
    jsr setBitmapNumber


    lda #<BITMAP_START
    ldx #>BITMAP_START
    ldy #`BITMAP_START
    jsr setBitmapAddress


    jsr setBitmapClut0
    jsr showBitmap
    rts

setupBitmap1
     lda #1
    jsr setBitmapNumber
    lda #<$20000
    ldx #>$20000
    ldy #`$20000
    jsr setBitmapAddress

    jsr setBitmapClut0

    jsr showBitmap
    rts
.endsection
.section variables
waveFrameDelay = 20
stateSetup = 0
stateInfo = 1
statePlay = 2
stateWaveOver = 3
mNumbers
  .byte '0','1','2','3','4','5','6','7','8','9'
mState
    .byte $00
mCurrentWave
    .byte $00
mLaunchY
    .byte $00
mStartMessage
    .text '                Player 1'
    .byte $00
mPoints
    .text '               1 X POINTS'
    .byte $00
    .text '0123456789012345678901234567890123456789'
    .byte $00
mBonus
    .text '           Bonus Points'
    .byte $00

mDelayTimer
    .byte $00, $00

mIcbmNumber
    .byte 12,15, 18, 12,16, 14,17,10,13,16,19,12,14,16,18,14,16,18,20
mBonusTrackerAbm
    .byte $00
mBonusTrackerCityies
    .byte $00
mWaveFrameDelay
    .byte $00
mBonusIdx
    .byte $00
.endsection
.endnamespace