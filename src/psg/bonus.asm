.section code
playBonus
    pha
    phx
    phy
    lda #1
    sta mBonusDoPlay
    lda #2
    sta mBonusTimer
    lda #<PSG_3C
    ldx #>PSG_3C
    jsr psg_2_freq_right

    lda #$0
    sta mBonusVol
    jsr psg_2_volume_right
    ply
    plx
    pla
    rts

bonus
    lda mBonusDoPlay
    cmp #0
    bne _continue
    rts
_continue
    lda mBonusTimer
    cmp #0
    bne _play
    beq _turnOff
    rts
_play
    dec mBonusTimer
    dec mBonusVol
    rts
_turnOff
    lda #$0f
    jsr psg_2_volume_right
    stz mBonusTimer
    stz mBonusDoPlay
    rts
.endsection
.section variables
mBonusTimer
    .byte $00
mBonusVol
    .byte $00
mBonusVolTimer
    .byte $00
mBonusflip
    .byte 0
mBonusRepeat
    .byte $0
mBonusDoPlay
    .byte $0
.endsection