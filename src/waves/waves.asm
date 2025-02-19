waves .namespace
.include "bonus.asm"
.include "start.asm"
.section code

init
    stz mCurrentWave
    stz mState
    stz mExtraCityTracker
    jsr reset
    rts

reset
    lda #waveFrameDelay
    sta mWaveFrameDelay
    stz mBonusIdx

  ;  jsr icbm.reset
   ;;copy ground
;    lda #1
;    sta $df00

;    lda <#mStaticBmpStart
;    sta $df04

;    lda >#mStaticBmpStart
;    sta $df05

;    lda `#mStaticBmpStart
;    sta $df06


;    lda <#15360
;    sta $df0c
;    lda >#15360
;    sta $df0d
;    lda `#15360
;    sta $df0e


;    lda <#mBitmapStart
;    sta $df08

;    lda >#mBitmapStart
;    sta $df09

;    lda `#mBitmapStart
;    sta $df0a

;    lda $df00
;    ora #%10000000
;    sta $df00
; _wait
;     lda $df01
;     cmp #$80
;     beq _wait

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
    jsr icbm.isWaveOver
    bcs _continue
    jsr initBonusStuff
    rts
_continue
    jsr score.handle
    jsr site.draw
    jsr icbm.play
    jsr abm.play
    jsr explosion.play
    jsr cities.play

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
    rts
_setWave0
    lda #14
    ldx #1
    jsr icbm.setSpeed
    rts
_setWave1
    lda #20
    ldx #1
    jsr icbm.setSpeed
    rts
_setWave2
    lda #34
    ldx #1
    jsr icbm.setSpeed
    rts
_setWave3
    lda #58
    ldx #1
    jsr icbm.setSpeed
    rts
_setWave4
    lda #96
    ldx #1
    jsr icbm.setSpeed
_setWave5
    lda #160
    ldx #1
    jsr icbm.setSpeed
    rts

setup
    jsr setSpeed
   ; jsr icbm.reset
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
waveFrameDelay = 20
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
mLaunchY
    .byte $00


mIcbmNumber
    .byte 12,15, 18, 12,16, 14,17,10,13,16,19,12,14,16,18,14,16,18,20


.endsection
.endnamespace