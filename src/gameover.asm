gameOver .namespace
.section code 
handle
    lda #state.gameOver
    jsr state.is
    bcc _ok
    rts
_ok
    lda mState
    cmp #stateShowMessage
    beq showGameOverMessage
    jsr clearTextScreen
    jsr clearExtMem
    jsr hideAllSprites
    lda #stateShowMessage
    sta mState
    rts

showGameOverMessage
    lda <#mGameOVer
    ldx >#mGameOVer
    ldy #10
    jsr drawText
    jsr explosion.play
    jsr score.handle
    jsr isSpacePressed
    bcc _reset
    rts
_reset
    jsr init
    lda #state.menu
    jsr state.setState
    jsr menu.init
    jsr waves.init
    stz mState
    jsr icbm.init
    jsr cities.init
    jsr collision.initCityCollision

    rts

init
    stz mState
    rts
.endsection
.section  variables
stateInit = 0
stateShowMessage = 1
mState
    .byte $00
mGameOVer
    .text '              Game Over'
.endsection
.endnamespace