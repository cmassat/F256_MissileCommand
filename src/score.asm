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

handle
    phy
    phx
    pha
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
    pla
    plx
    ply
    rts
init
    jsr resetScore
    rts
.endsection
.section variables
mNumbers
  .byte '0','1','2','3','4','5','6','7','8','9'
.endsection
.endnamespace