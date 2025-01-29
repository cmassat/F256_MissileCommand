.section code 
initGame
    jsr state.init
    jsr splash.init
    jsr menu.init
    jsr wave1.init
    jsr icbm.init
    rts 
.endsection