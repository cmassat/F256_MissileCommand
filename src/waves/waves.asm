waves .namespace
.include "bonus.asm"
.include "start.asm"
.section code

init
    stz mState
    lda #0
    sta mExtraCityTracker
    lda #0
    sta mCurrentWave
    jsr reset
    rts

reset
    lda #waveFrameDelay
    sta mWaveFrameDelay
    stz mBonusIdx
    stz mAbmBonusComplete
    stz mCitiesBonusComplete
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
    cmp #stateStart
    beq _start
    cmp #statePlay
    beq _play
    cmp #stateWaveOver
    beq _waveOver
    cmp #stateBonusOverDelay
    beq _bonusOverDelay
    rts
_setup
    jsr setup
    rts
_start
    jsr start
    dec mDelayTimer
    rts
_play
    jsr play
    rts
_waveOver
    jsr waveOver
    rts
_bonusOverDelay
    jsr bonusOverDelay
    rts
play
    pha
    phx
    phy
    ldy #11
    lda mCurrentWave
    cmp #11
    bcs _getMult
    ldy mCurrentWave
_getMult
    lda mPtMult, y
    jsr score.setPointMultiplier
    lda mExtraCityTracker
    cmp #0
    bne _doNotEndGame
    jsr cities.getReamainingTotal
    cmp #0
    beq _endGame
_doNotEndGame
    jsr icbm.isWaveOver
    bcs _continue
    jsr initBonusStuff
    ply
    plx
    pla
    rts
_continue
    jsr score.handle
    jsr site.draw
    jsr icbm.play
    jsr abm.play
    jsr explosion.play
    jsr cities.play
    jsr cruise.play
    ;jsr plane.demo

    ply
    plx
    pla
    rts
_endGame
    jsr state.next

    ply
    plx
    pla
    rts
setSpeed
    lda mCurrentWave
    cmp #0
    beq _setWave0
    cmp #1
    beq _setWave1
    cmp #2
    beq _setWave2
    cmp #3
    beq _setWave3
    cmp #4
    beq _setWave4
    cmp #5
    beq _setWave5
    cmp #6
    beq _setWave6
    cmp #7
    beq _setWave7
    cmp #8
    beq _setWave8
    cmp #9
    beq _setWave9
    bra _setWave10
    rts
_setWave0
    lda #$20
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
_setWave1
    lda #$40
    ldx #1
    jsr icbm.setSpeed
_setWave2
    lda #$60
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
_setWave3
    lda #$70
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
_setWave4
    lda #$80
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
_setWave5
    lda #$90
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
_setWave6
    lda #$a0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
_setWave7
    lda #$B0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
_setWave8
    lda #$C0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
_setWave9
    lda #$D0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
_setWave10
    lda #$E0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    rts
setup
    jsr setSpeed
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

    jsr cities.init

    lda #127
    sta mDelayTimer
    sta mDelayTimer + 1
    ;jsr showBitmap
   ; jsr setupBitmap0
  ;  jsr setupBitmap0
   inc mState
    jsr psg.playPulse
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
waveFrameDelay = 4
stateSetup = 0
stateStart = 1
statePlay = 2
stateWaveOver = 3
stateBonusOverDelay =4
mNumbers
  .byte '0','1','2','3','4','5','6','7','8','9'
mState
    .byte $00
mCurrentWave
    .byte $00
; mLaunchY
;     .byte $00

mIcbmNumber
    .byte 12,15, 18, 12,16, 14,17,10,13,16,19,12,14,16,18,14,16,18,20,20
mIcbmSpeed
    .byte 15,20,25,30,35,40


.endsection
.endnamespace