.section code
start

    lda mDelayTimer
    cmp #0
    beq _next
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

    jsr displayPtMult
    rts
_next
    jsr reset
    jsr icbm.reset
    ;set max ICBM for Wave
    ldy mCurrentWave
    lda mIcbmNumber, y
    jsr icbm.setMaxLaunch

    jsr clearScreenMemory
    lda #statePlay
    sta mState
    rts

displayPtMult
    lda #2
    sta MMU_IO_CTRL
    lda <#$C000 + (40 * 12 + 15)
    sta POINTER_TXT
    lda >#$C000 + (40 * 12 + 15)
    sta POINTER_TXT + 1
    ldy mCurrentWave
    lda mPtMult, y
    tax
    lda mNumbers, x
    sta (POINTER_TXT)
    stz MMU_IO_CTRL
    rts
.endsection
.section variables
mStartMessage
    .text '                Player 1'
    .byte $00
mPoints
    .text '                 X POINTS'
    .byte $00
    .text '0123456789012345678901234567890123456789'
    .byte $00

mPtMult
    .byte 1,1,2,2,3,3,4,4,5,5,6,6
mDelayTimer
    .byte $00, $00
.endsection