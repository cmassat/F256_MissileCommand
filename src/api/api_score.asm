.section code
;a register is score to add
add2score
	sed
	clc
	adc m_score
	sta m_score

	lda m_score + 1
	adc #0
	sta m_score + 1

	lda m_score + 2
	adc #0
	sta m_score + 2

	lda m_score + 3
	adc #0
	sta m_score + 3

	lda m_score + 4
	adc #0
	sta m_score + 4

	lda m_score + 5
	adc #0
	sta m_score + 5

	lda m_score + 6
	adc #0
	sta m_score + 6

	cld
	rts

add2BonusScore
	sed
	clc
	adc m_bonus_score_0
	sta m_bonus_score_0

	lda m_bonus_score_1
	adc #0
	sta m_bonus_score_1

	lda m_bonus_score_2
	adc #0
	sta m_bonus_score_2

	lda m_bonus_score_3
	adc #0
	sta m_bonus_score_3

	lda m_bonus_score_4
	adc #0
	sta m_bonus_score_4

	lda m_bonus_score_5
	adc #0
	sta m_bonus_score_5

	lda m_bonus_score_6
	adc #0
	sta m_bonus_score_6

	cld
	rts

getScoreDigit0

    lda m_score
	and #$0f

	rts
getScoreDigit1
	lda m_score
	lsr
	lsr
	lsr
	lsr

	rts
getScoreDigit2
	lda m_score_1
	and #$0f
	rts
getScoreDigit3
	lda m_score_1
	lsr
	lsr
	lsr
	lsr
	rts
getScoreDigit4
	lda m_score_2
	and #$0f
	rts
getScoreDigit5
	lda m_score_2
	lsr
	lsr
	lsr
	lsr
	rts
getScoreDigit6
	lda m_score_3
	and #$0f
	rts

getBonusScoreDigit0
    lda m_bonus_score_0
	and #$0f

	rts
getBonusScoreDigit1
	lda m_bonus_score_0
	lsr
	lsr
	lsr
	lsr
	rts
getBonusScoreDigit2
	lda m_bonus_score_1
	and #$0f
	rts
getBonusScoreDigit3
	lda m_bonus_score_1
	lsr
	lsr
	lsr
	lsr
	rts

getBonusScoreDigit4
	lda m_bonus_score_2
	and #$0f
	rts
getBonusScoreDigit5
	lda m_bonus_score_2
	lsr
	lsr
	lsr
	lsr
	rts
getBonusScoreDigit6
	lda m_bonus_score_3
	and #$0f
	rts

resetScore
    lda #0
    sta m_score_0
    sta m_score_1
    sta m_score_2
    sta m_score_3
    sta m_score_4
    sta m_score_5
    sta m_score_6
    rts

resetBonusScore
    lda #0
    sta m_bonus_score_0
    sta m_bonus_score_1
    sta m_bonus_score_2
    sta m_bonus_score_3
    sta m_bonus_score_4
    sta m_bonus_score_5
    sta m_bonus_score_6
    rts
.endsection

.section variables
m_score
m_score_0
 	.byte $00
m_score_1
 	.byte $00
m_score_2
 	.byte $00
m_score_3
 	.byte $00
m_score_4
 	.byte $00
m_score_5
 	.byte $00
m_score_6
 	.byte $00


m_bonus_score_0
 	.byte $00
m_bonus_score_1
 	.byte $00
m_bonus_score_2
 	.byte $00
m_bonus_score_3
 	.byte $00
m_bonus_score_4
 	.byte $00
m_bonus_score_5
 	.byte $00
m_bonus_score_6
 	.byte $00
.endsection