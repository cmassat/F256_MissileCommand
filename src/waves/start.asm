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

    lda #0
    ldx #0
    ldy #$ff
    jsr abmColor


    lda #$ff
    ldx #0
    ldy #$00
    jsr IcbmColor


    jsr displayPtMult

    rts
_next
    jsr reset
   ; jsr icbm.reset
    ;set max ICBM for Wave
    lda mCurrentWave
    cmp #20
    bcs _skip
    ldy mCurrentWave
    lda mIcbmNumber, y
    jsr icbm.setMaxLaunch
_skip
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
    lda mCurrentWave
    cmp #12
    bcs _set6
    ldy mCurrentWave
    lda mPtMult, y
    cmp #6
    bcs _set6
    bra _ok
_set6
    lda #6
_ok
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