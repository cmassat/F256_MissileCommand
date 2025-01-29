wave1 .namespace
.section code 

init
    stz mCurrentWave
    rts

newAttack
    lda mCurrentWave
    asl
    sec
    sbc #202
    sta mLaunchY
    ;202 - 2 * wave_number ; sta mydirection
    rts




.endsection
.section variables


mCurrentWave
    .byte $00
mLaunchY
    .byte $00





.endsection
.endnamespace