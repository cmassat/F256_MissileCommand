wave1 .namespace
.section code

init
    stz mCurrentWave
    stx mState
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

play
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

    lda #0
    jsr setBitmapNumber


    lda #<BITMAP_START
    ldx #>BITMAP_START
    ldy #`BITMAP_START
    jsr setBitmapAddress

    lda #0
    jsr setBitmapClut

    jsr psg.playPulse

    lda #127
    sta mDelayTimer
    sta mDelayTimer + 1
    jsr showBitmap
    inc mState
    rts


.endsection
.section variables
stateSetup = 0
stateInfo = 1
statePlay = 2
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
mDelayTimer
    .byte $00, $00
.endsection
.endnamespace