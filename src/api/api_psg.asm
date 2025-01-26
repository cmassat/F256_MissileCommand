SYS_CTRL = $d6a1

PSG_MONO_REG = $d608
PSG_LEFT_REG = $d600
PSG_RIGHT_REG = $d610

PSG_TONE_1_FREQ_MASK_L = %10000000
PSG_TONE_1_FREQ_MASK_H = %00000000
PSG_TONE_1_ATTN_MASK   = %10010000

PSG_TONE_2_FREQ_MASK_L = %10100000
PSG_TONE_2_FREQ_MASK_H = %00100000
PSG_TONE_2_ATTN_MASK   = %10110000

PSG_TONE_3_FREQ_MASK_L = %11000000
PSG_TONE_3_FREQ_MASK_H = %01000000
PSG_TONE_3_ATTN_MASK   = %11010000

;PSG_TONE_4_CTRL_MASK_WHT = %11100100
PSG_TONE_4_CTRL_MASK_WHT_0512 = %11100100 ;512
PSG_TONE_4_CTRL_MASK_WHT_1024 = %11100101 ;1024
PSG_TONE_4_CTRL_MASK_WHT_2048 = %11100110 ;2048
PSG_TONE_4_CTRL_MASK_WHT_TON3 = %11100111 ;Tone 3

PSG_TONE_4_CTRL_MASK_PRD_0512 = %11100100 ;512
PSG_TONE_4_CTRL_MASK_PRD_1024 = %11100101 ;1024
PSG_TONE_4_CTRL_MASK_PRD_2048 = %11100110 ;2048
PSG_TONE_4_CTRL_MASK_PRD_TON3 = %11100111 ;Tone 3

PSG_TONE_4_ATTN_MASK   = %11110000

initPsg
    lda #$ff
    jsr psg_1_volume_mono
    jsr psg_1_volume_left
    jsr psg_1_volume_right

    jsr psg_2_volume_mono
    jsr psg_2_volume_left
    jsr psg_2_volume_right

    jsr psg_3_volume_mono
    jsr psg_3_volume_left
    jsr psg_3_volume_right

    jsr psg_4_volume_mono
    jsr psg_4_volume_left
    jsr psg_4_volume_right

    jsr psg_stereo
    rts

psg_stereo 
    lda SYS_CTRL
    ora #%00000100
    sta SYS_CTRL
    rts 

psg_mono
    lda SYS_CTRL
    and #%11111011
    sta SYS_CTRL
    rts 

;a low byte freq 
;x med byte freq

psg_1_freq_mono
    sta mPSGFreqL1
    stx mPSGFreqH1
    
    lda mPSGFreqL1
    and #$0f 
    ora #PSG_TONE_1_FREQ_MASK_L
    sta PSG_MONO_REG
    clc
    lda mPSGFreqL1
    lsr
    lsr
    lsr
    lsr
    sta mPSGFreqL1
    lda mPSGFreqH1
    and #%00000011
    asl
    asl
    asl
    asl
    ora mPSGFreqL1
    ora #PSG_TONE_1_FREQ_MASK_H
    sta PSG_MONO_REG
    rts

psg_1_freq_left
    sta mPSGFreqL1
    stx mPSGFreqH1
    
    lda mPSGFreqL1
    and #$0f 
    ora #PSG_TONE_1_FREQ_MASK_L
    sta PSG_LEFT_REG
    sta mDebug
    clc
   
    ror mPSGFreqH1
    ror mPSGFreqL1
    
    ror mPSGFreqH1
    ror mPSGFreqL1
    
    ror mPSGFreqH1
    ror mPSGFreqL1
    
    ror mPSGFreqH1
    ror mPSGFreqL1
    
    lda mPSGFreqL1
    and #%01111111
    sta PSG_LEFT_REG
    sta mDebug + 1
    rts

psg_noise_mono
    lda #PSG_TONE_4_CTRL_MASK_WHT_0512
    
    sta PSG_MONO_REG
    rts 

psg_noise_vol
    and #$0F
    ora #PSG_TONE_4_ATTN_MASK
    sta PSG_MONO_REG
    rts 
;a register 0-15 
; 0 is the loudest
psg_1_volume_mono
    and #$0F
    sta mPSGVol1
    lda #PSG_TONE_1_ATTN_MASK
    ora mPSGVol1
    sta PSG_MONO_REG
    rts 

psg_1_volume_left
    and #$0F
    sta mPSGVol1
    lda #PSG_TONE_1_ATTN_MASK
    ora mPSGVol1
    sta PSG_LEFT_REG
    rts

psg_1_volume_right
    and #$0F
    sta mPSGVol1
    lda #PSG_TONE_1_ATTN_MASK
    ora mPSGVol1
    sta PSG_RIGHT_REG
    rts

psg_2_volume_mono 
    and #$0F
    sta mPSGVol2
    lda #PSG_TONE_2_ATTN_MASK
    ora mPSGVol2
    sta PSG_MONO_REG
    rts

psg_2_volume_left
    and #$0F
    sta mPSGVol2
    lda #PSG_TONE_2_ATTN_MASK
    ora mPSGVol2
    sta PSG_LEFT_REG
    rts

psg_2_volume_right
    and #$0F
    sta mPSGVol2
    lda #PSG_TONE_2_ATTN_MASK
    ora mPSGVol2
    sta PSG_RIGHT_REG
    rts

psg_3_volume_mono 
    and #$0F
    sta mPSGVol3
    lda #PSG_TONE_3_ATTN_MASK
    ora mPSGVol3
    sta PSG_MONO_REG
    rts

psg_3_volume_left
    and #$0F
    sta mPSGVol3
    lda #PSG_TONE_3_ATTN_MASK
    ora mPSGVol3
    sta PSG_LEFT_REG
    rts

psg_3_volume_right
    and #$0F
    sta mPSGVol3
    lda #PSG_TONE_3_ATTN_MASK
    ora mPSGVol3
    sta PSG_RIGHT_REG
    rts

psg_4_volume_mono 
    and #$0F
    sta mPSGVol4
    lda #PSG_TONE_3_ATTN_MASK
    ora mPSGVol4
    sta PSG_MONO_REG
    rts

psg_4_volume_left
    and #$0F
    sta mPSGVol4
    lda #PSG_TONE_3_ATTN_MASK
    ora mPSGVol4
    sta PSG_LEFT_REG
    rts

psg_4_volume_right
    and #$0F
    sta mPSGVol4
    lda #PSG_TONE_3_ATTN_MASK
    ora mPSGVol4
    sta PSG_RIGHT_REG
    rts

psg_2_freq_mono
    
    sta mPSGFreqL2
    stx mPSGFreqH2
    
    lda mPSGFreqL2
    and #$0f 
    ora #PSG_TONE_1_FREQ_MASK_L
    sta PSG_MONO_REG
    clc
    lda mPSGFreqL2
    lsr
    lsr
    lsr
    lsr
    sta mPSGFreqL2
    lda mPSGFreqH2
    and #%00000011
    asl
    asl
    asl
    asl
    ora mPSGFreqL2
    ora #PSG_TONE_1_FREQ_MASK_H
    sta PSG_MONO_REG
    rts 

mPSGFreqL1
    .byte $00
mPSGFreqH1
    .byte $00
mPSGVol1
    .byte $00
mPSGFreqL2
    .byte $00
mPSGFreqH2
    .byte $00
mPSGVol2
    .byte $00
mPSGFreqL3
    .byte $00
mPSGFreqH3
    .byte $00
mPSGVol3
    .byte $00
mPSGFreqL4
    .byte $00
mPSGFreqH4
    .byte $00
mPSGVol4
    .byte $00

mDebug
    .byte $00, $00
