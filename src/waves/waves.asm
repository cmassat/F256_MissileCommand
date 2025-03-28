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

    jsr site.draw
    jsr icbm.play
    jsr abm.play
    jsr explosion.play
    jsr cities.play
    lda mCurrentWave
    cmp #2
    bcc _end
    jsr plane.play
    cmp #3
    bcc _end
    jsr saucer.play
    cmp #4
    bcc _end
    jsr cruise.play
    ;
    ;jsr saucer.play
   ; jsr debug
_end
    ply
    plx
    pla
    rts
_endGame
    jsr state.next
    jsr setSpeed
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
    jsr wave0setup
    rts
_setWave1
    jsr wave1setup
    rts
_setWave2
    jsr wave2setup
    rts
_setWave3
    jsr wave3setup
    rts
_setWave4
    jsr wave4setup
    rts
_setWave5
    jsr wave5setup
    rts
_setWave6
    jsr wave6setup
    rts
_setWave7
    jsr wave7setup
    rts
_setWave8
    jsr wave8setup
    rts
_setWave9
    jsr wave9setup
    rts
_setWave10
    jsr wave10setup
    rts
wave0setup
    lda #$20
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr blackBack
    rts
wave1setup
    lda #$40
    ldx #1
    jsr icbm.setSpeed
    jsr plane.setSpeed
    jsr cruise.setSpeed
    jsr saucer.setSpeed

    jsr blackBack
    rts
wave2setup
     lda #$60
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr blueBack
    rts

wave3setup
     lda #$70
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr blueBack
    rts

wave4setup
    lda #$80
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr cyanBack
    rts

wave5setup
    lda #$90
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr cyanBack
    rts

wave6setup
    lda #$a0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr magentaBack
    rts

wave7setup
     lda #$B0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr magentaBack
    rts

wave8setup
     lda #$C0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr yellowBack
    rts

wave9setup
    lda #$D0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr whiteBack
    rts

wave10setup
    lda #$E0
    ldx #1
    jsr icbm.setSpeed
    jsr cruise.setSpeed
    jsr plane.setSpeed
    jsr saucer.setSpeed
    jsr redBack
    rts

redBack
    lda #$00
    ldx #$00
    ldy #$FF
    jsr setBackgroundColor

    lda #$00
    ldx #$00
    ldy #$ff
    jsr abmColor

    lda #$00
    ldx #$00
    ldy #$00
    jsr icbmColor


    lda #black
    ldx #red
    ldy #1
    jsr setColorByLine

    lda #black
    ldx #red
    ldy #10
    jsr setColorByLine

    lda #blue
    ldx #red
    ldy #12
    jsr setColorByLine
    rts

blueBack
    lda #255
    ldx #0
    ldy #0
    jsr setBackgroundColor

    lda #$01
    ldx #$01
    ldy #$01
    jsr abmColor


    lda #$ff
    ldx #00
    ldy #$00
    jsr icbmColor

    lda #white
    ldx #blue
    ldy #1
    jsr setColorByLine

    lda #black
    ldx #blue
    ldy #10
    jsr setColorByLine

    lda #black
    ldx #blue
    ldy #12
    jsr setColorByLine
    rts

cyanBack
    lda #255
    ldx #255
    ldy #00
    jsr setBackgroundColor

    lda #$00
    ldx #$00
    ldy #$ff
    jsr abmColor


    lda #$ff
    ldx #00
    ldy #$00
    jsr icbmColor


    lda #blue
    ldx #cyan
    ldy #1
    jsr setColorByLine

    lda #blue
    ldx #cyan
    ldy #10
    jsr setColorByLine

    lda #blue
    ldx #cyan
    ldy #12
    jsr setColorByLine
    rts

blackBack
    lda #0
    ldx #0
    ldy #0
    jsr setBackgroundColor

    lda #$00
    ldx #$00
    ldy #$ff
    jsr abmColor


    lda #$ff
    ldx #00
    ldy #$00
    jsr icbmColor

    lda #blue
    ldx #black
    ldy #1
    jsr setColorByLine

    lda #blue
    ldx #black
    ldy #10
    jsr setColorByLine

    lda #blue
    ldx #black
    ldy #12
    jsr setColorByLine
    rts

whiteBack
    lda #255
    ldx #255
    ldy #255
    jsr setBackgroundColor

    lda #$00
    ldx #$ff
    ldy #$00
    jsr abmColor


    lda #$ff
    ldx #00
    ldy #$ff
    jsr icbmColor

    lda #violet
    ldx #white
    ldy #1
    jsr setColorByLine

    lda #violet
    ldx #white
    ldy #10
    jsr setColorByLine

    lda #violet
    ldx #white
    ldy #12
    jsr setColorByLine
    rts

yellowBack
    lda #0
    ldx #255
    ldy #255
    jsr setBackgroundColor

    lda #$ff
    ldx #$00
    ldy #$00
    jsr abmColor


    lda #$00
    ldx #00
    ldy #$00
    jsr icbmColor


    lda #red
    ldx #yellow
    ldy #1
    jsr setColorByLine

    lda #red
    ldx #yellow
    ldy #10
    jsr setColorByLine

    lda #red
    ldx #yellow
    ldy #12
    jsr setColorByLine
    rts

magentaBack
    lda #255
    ldx #0
    ldy #255
    jsr setBackgroundColor

    lda #$00
    ldx #$ff
    ldy #$ff
    jsr abmColor


    lda #$00
    ldx #00
    ldy #$00
    jsr icbmColor

    lda #yellow
    ldx #violet
    ldy #1
    jsr setColorByLine

    lda #yellow
    ldx #violet
    ldy #10
    jsr setColorByLine

    lda #yellow
    ldx #violet
    ldy #12
    jsr setColorByLine
    rts

setup
    jsr setSpeed
    jsr hideAllSprites


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