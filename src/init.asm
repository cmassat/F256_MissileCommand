.section code 
initGame

    jsr clearVideo
    jsr clut_load_0
    jsr init_mouse
    stz $D6E0   ;hide mouse
    jsr hideAllSprites

    lda #0
    ldx #0
    ldy #0
    jsr setBackgroundColor

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

    rts 
.endsection