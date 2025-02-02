wave1 .namespace
.section code

init
    stz mCurrentWave
    rts


handleWave

    rts


.endsection
.section variables

mCurrentWave
    .byte $00
mLaunchY
    .byte $00
.endsection
.endnamespace