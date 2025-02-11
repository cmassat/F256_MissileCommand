.section code 
playBonusCity
    pha
    phx
    phy
    lda #60
    sta mBonusCityTimer
    lda #<PSG_4C
    ldx #>PSG_4C
    jsr psg_1_freq_right

    lda #$0
    sta mBonusCityVol
    jsr psg_1_volume_right
    lda #1
    sta mBonusCityflip
    sta mBonusCityDoPlay

    lda #3
    sta mBonusCityNoteTimer

    ply
    plx
    pla
    rts

bonusCity
    lda mBonusCityDoPlay
    cmp #0
    bne _okToPlay
    rts
_okToPlay
    lda mBonusCityTimer
    cmp #0
    bne _play
    beq _turnOff
    rts
_play
    dec mBonusCityNoteTimer
    dec mBonusCityTimer
    lda mBonusCityNoteTimer
    cmp #0
    beq _playNote
    rts
_playNote
    lda #3
    sta mBonusCityNoteTimer
    lda mBonusCityflip
    cmp #1
    beq _note1
    cmp #2
    beq _note2
    cmp #3
    beq _note3
    cmp #4
    beq _note4
_note1
    lda #2
    sta mBonusCityflip
    lda #<PSG_4C
    ldx #>PSG_4C
    jsr psg_1_freq_right
    rts
_note2
    lda #3
    sta mBonusCityflip
    lda #<PSG_4E
    ldx #>PSG_4E
    jsr psg_1_freq_right
    rts
_note3
    lda #4
    sta mBonusCityflip
    lda #<PSG_4G
    ldx #>PSG_4G
    jsr psg_1_freq_right
    rts
_note4
    lda #1
    sta mBonusCityflip
    lda #<PSG_5C
    ldx #>PSG_5C
    jsr psg_1_freq_right
    rts
_turnOff
    lda #$0f
    jsr psg_1_volume_right
    stz mBonusCityTimer
    stz mBonusCityDoPlay
    rts
.endsection
.section variables
mBonusCityTimer
    .byte $00
mBonusCityNoteTimer
    .byte $00
mBonusCityVol
    .byte $00
mBonusCityVolTimer
    .byte $00
mBonusCityflip
    .byte 0
mBonusCityRepeat
    .byte $0
mBonusCityDoPlay
    .byte $0
.endsection