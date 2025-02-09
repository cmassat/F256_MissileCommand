psg  .namespace
.section code
handle
    jsr explosion
    jsr a
    jsr pulse
    rts

playExplosion
    lda #10
    sta mExplosionVolTimer
    lda #127
    sta mExplosionTimer
    jsr psg_noise_left
    lda #$00
    sta mExplosionVol
    jsr psg_noise_vol_left
    rts 

explosion
    lda mExplosionTimer
    cmp #0
    bne _play
    rts
_play
    dec mExplosionVolTimer
    lda mExplosionVolTimer
    cmp #0
    beq _lowerVol
    bra _continue
_lowerVol
    inc mExplosionVol
    lda mExplosionVol
    jsr psg_noise_vol_left
    lda #10
    sta mExplosionVolTimer
_continue
  ;  inc mExplosionVol
  ;  lda mExplosionVol
  ;  jsr psg_noise_vol_left
    dec mExplosionTimer
    lda mExplosionTimer
    beq _turnOff
    rts
_turnOff
    lda #$f
    jsr psg_noise_vol_left
    stz mExplosionTimer
    rts

a
    lda mATimer
    cmp #0
    bne _play
    rts
_play
   ; inc mAVol
    lda #$e
    jsr psg_2_volume_left
    dec mATimer
    lda mATimer
    beq _turnOff
    rts
_turnOff
    lda #$f
    jsr psg_2_volume_left
    stz mATimer
    rts

playPulse
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
    rts

pulse
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
    bra _continue
_lowerVol
    dec mPulseVol
    lda mPulseVol
    jsr psg_2_volume_left
    lda #2
    sta mPulseVolTimer
_continue
    dec mPulseTimer
    lda mPulseTimer
    beq _turnOff
    rts
_turnOff
    lda #$f
    jsr psg_2_volume_left
    stz mPulseTimer
    rts



playA
    lda #127
    sta mATimer
    lda #<PSG_4A
    ldx #>PSG_4A
    jsr psg_2_freq_left

    lda #0
    sta mAVol
    jsr psg_2_volume_left
    rts

.endsection
.section variables
mExplosionTimer
    .byte $00
mExplosionVol
    .byte $00
mExplosionVolTimer
    .byte $00
mPulseTimer
    .byte $00
mPulseVol
    .byte $00
mPulseVolTimer
    .byte $00
mPulseRepeat
    .byte $00
mATimer
    .byte $00
mAVol
    .byte $00
.endsection
.endnamespace