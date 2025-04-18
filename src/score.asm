score .namespace
.section code 
writeScoreMacro .macro
    pha
    lda #2
    sta MMU_IO_CTRL
    pla
    tay
    lda mNumbers, y
    sta \1
    lda #0
    sta MMU_IO_CTRL
.endmacro
init
    jsr resetScore
    rts

handle
    phy
    phx
    pha
    lda #state.splash
    jsr state.is
    bcs _display
    pla
    plx
    ply
    rts
_display
    jsr getScoreDigit0
    #writeScoreMacro $c009 + (1 * 40)
    jsr getScoreDigit1
    #writeScoreMacro $c008 + (1 * 40)
     jsr getScoreDigit2
    #writeScoreMacro $c007 + (1 * 40)
    jsr getScoreDigit3
    #writeScoreMacro $c006 + (1 * 40)
    jsr getScoreDigit4
    #writeScoreMacro $c005 + (1 * 40)
    jsr getScoreDigit5
    #writeScoreMacro $c004 + (1 * 40)
    jsr getScoreDigit6
    #writeScoreMacro $c003 + (1 * 40)


    jsr getHighScoreDigit0
    #writeScoreMacro $c018 + (1 * 40)
    jsr getHighScoreDigit1
    #writeScoreMacro $c017 + (1 * 40)
    jsr getHighScoreDigit2
    #writeScoreMacro $c016 + (1 * 40)
    jsr getHighScoreDigit3
    #writeScoreMacro $c015 + (1 * 40)
    jsr getHighScoreDigit4
    #writeScoreMacro $c014 + (1 * 40)
    jsr getHighScoreDigit5
    #writeScoreMacro $c013 + (1 * 40)
    jsr getHighScoreDigit6
    #writeScoreMacro $c012 + (1 * 40)
    pla
    plx
    ply
    rts

addScore
    phx
    sta mscore
    ldx #0
_addMore
    lda mscore
    jsr add2score
    lda mscore
    jsr add2Livescore
    inx
    cpx mPtMultiplier
    bcc _addMore
    plx
    rts

addBonus
    phx
    sta mscore
    ldx #0
_addMore
    lda mscore
    jsr add2BonusScore
    inx
    cpx mPtMultiplier
    bcc _addMore
    plx
    rts

setPointMultiplier
    sta mPtMultiplier
    rts


.endsection
.section variables
mscore
    .byte $00
mPtMultiplier
    .byte $00
mNumbers
  .byte '0','1','2','3','4','5','6','7','8','9'
.endsection
.endnamespace