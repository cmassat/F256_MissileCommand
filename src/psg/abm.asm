.section code
playABM
    lda #1
    sta mAbmDoPlay
    lda #16
    sta mAbmTimer
    lda #<PSG_2A
    ldx #>PSG_2A
    jsr psg_1_freq_left

    lda #$0
    sta mAbmVol
    jsr psg_1_volume_left

    rts

abm
   lda mAbmDoPlay
   cmp #0
   bne _continue
   rts
_continue
    lda mAbmTimer
    cmp #0
    bne _play
    beq _turnOff
    rts
_play
    dec mAbmTimer
    ;dec mAbmVol
    lda mAbmflip
    beq _note1
    bne _note2
_note1
    lda #1
    sta mAbmflip
    lda #<PSG_3B
    ldx #>PSG_3B
    jsr psg_1_freq_left
   ; lda mAbmVol
   ; jsr psg_1_volume_left
    rts
_note2
    stz mAbmflip
    lda #<PSG_4B
    ldx #>PSG_4B
    jsr psg_1_freq_left
   ; lda mAbmVol
    ;jsr psg_1_volume_left
    rts
_turnOff
    lda #$f
    jsr psg_1_volume_left
    stz mAbmTimer
    stz mAbmDoPlay
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
    .byte $00
mAbmRepeat
    .byte $00
mAbmDoPlay
    .byte $00
.endsection