.section code
playPulse
    pha
    phx
    phy
    lda #2
    sta mPulseRepeat
    lda #2
    sta mPulseVolTimer
    lda #32
    sta mPulseTimer
    lda #<PSG_5D_SHRP
    ldx #>PSG_5D_SHRP
    jsr psg_2_freq_left

    lda #$f
    sta mAVol
    jsr psg_2_volume_left

    lda #1
    sta mPulseDoPlay
    ply
    plx
    pla
    rts

pulse
    lda mPulseDoPlay
    cmp #0
    bne _continue
    rts
_continue
    lda mPulseTimer
    cmp #0
    bne _play
    lda mPulseRepeat
    cmp #0
    bne _again
    rts
_again
    dec mPulseRepeat
    lda #32
    sta mPulseTimer
    rts
_play
    dec mPulseVolTimer
    lda mPulseVolTimer
    cmp #0
    beq _lowerVol
    bra _next
_lowerVol
    dec mPulseVol
    lda mPulseVol
    jsr psg_2_volume_left
    lda #2
    sta mPulseVolTimer
_next
    dec mPulseTimer
    lda mPulseTimer
    beq _turnOff
    rts
_turnOff
    lda #$0f
    jsr psg_2_volume_left
    stz mPulseTimer
    lda mPulseRepeat
    cmp #0
    bne _end
    stz mPulseDoPlay
_end
    rts
.endsection
.section variables
mPulseTimer
    .byte $00
mPulseVol
    .byte $00
mPulseVolTimer
    .byte $00
mPulseflip
    .byte 0
mPulseRepeat
    .byte $0
mPulseDoPlay
    .byte $0
.endsection