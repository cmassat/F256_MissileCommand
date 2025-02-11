psg  .namespace
.include "abm.asm"
.include "bonus.asm"
.include "pulse.asm"
.include "explosion.asm"
.include "bonusCity.asm"
.section code

handle
    pha
    phx
    phy
    jsr explosion
    jsr pulse
    jsr abm
    jsr bonus
    jsr bonusCity
    ply
    plx
    pla
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


mATimer
    .byte $00
mAVol
    .byte $00
.endsection
.endnamespace