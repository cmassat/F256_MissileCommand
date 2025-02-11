.section code
playExplosion
    pha
    phx
    phy
    lda #10
    sta mExplosionVolTimer
    lda #127
    sta mExplosionTimer
    jsr psg_noise_left
    lda #$00
    sta mExplosionVol
    jsr psg_noise_vol_left
    lda #1
    sta mExplosionDoPlay
    ply
    plx
    pla
    rts

explosion
    lda mExplosionDoPlay
    cmp #0
    bne _okToPlay
    rts
_okToPlay
    lda mExplosionTimer
    cmp #0
    bne _play
    beq _turnOff
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
  ;  lda mExplosionTimer
  ;  sec
  ;  sbc #1
  ;  sta mExplosionTimer
    ; lda mExplosionTimer
    ; cmp #0
  ;  beq _turnOff
    dec mExplosionTimer
    rts
_turnOff
    lda #$0f
    jsr psg_noise_vol_left
    stz mExplosionTimer
    rts

.endsection
.section variables
mExplosionTimer
    .byte $00
mExplosionVol
    .byte $00
mExplosionVolTimer
    .byte $00
mExplosionDoPlay
    .byte $00
.endsection