.section code 
initGame

    jsr hideAllSprites
    jsr clearExtMem
    jsr cities.init
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
    jsr gameOver.init
    jsr loadFont
    jsr resetBonusLifeScore
    stz $D6E0   ;hide mouse
    rts 
.endsection