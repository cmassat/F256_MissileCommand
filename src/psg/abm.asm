.section code
playABM
    lda #16
    sta mAbmTimer
    lda #<PSG_2A
    ldx #>PSG_2A
    jsr psg_2_freq_right

    lda #$0
    sta mAbmVol
    jsr psg_2_volume_right
    rts

abm
   lda mAbmTimer
   cmp #0
   bne _play
   beq _turnOff
   rts
_play
    dec mAbmTimer
    dec mAbmVol
    lda mAbmflip
    beq _note1
    bne _note2
_note1
  lda #1
  sta mAbmflip
   lda #<PSG_3B
   ldx #>PSG_3B
   jsr psg_2_freq_right
   lda mAbmVol
    jsr psg_2_volume_right
   rts
_note2
    stz mAbmflip
   ;lda #<PSG_4B
   ;ldx #>PSG_4B
   ;jsr psg_2_freq_right
   lda mAbmVol
    jsr psg_2_volume_right
   rts
_turnOff
   lda #$f
   jsr psg_2_volume_right
   stz mAbmTimer
    rts
.endsection
.section variables
mAbmTimer
    .byte $00
mAbmVol
    .byte $00
mAbmVolTimer
    .byte $00
mAbmflip
    .byte 0
mAbmRepeat
    .byte $0
.endsection