.section code 
initGame

    jsr initPsg
    jsr clearScreenMemory
    jsr clearLayers
    jsr loadDefaultPalette
    jsr state.init
    jsr splash.init
    jsr menu.init
    jsr waves.init
    jsr icbm.init
    jsr cruise.init
    jsr plane.init
    jsr saucer.init
    jsr abm.init
    jsr explosion.init

  ;  stz $D6E0
    rts 
.endsection