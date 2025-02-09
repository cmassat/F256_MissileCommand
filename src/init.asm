.section code 
initGame

    jsr clearScreenMemory
    jsr loadDefaultPalette
    jsr state.init
    jsr splash.init
    jsr menu.init
    jsr wave1.init
    jsr icbm.init
    jsr cruise.init
    jsr plane.init
    jsr saucer.init
    jsr abm.init
    jsr explosion.init

    stz $D6E0
    rts 
.endsection