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
	jsr setHighScore
	rts

add2Livescore
	sed
	clc
	adc m_bonusLife_score
	sta m_bonusLife_score

	lda m_bonusLife_score + 1
	adc #0
	sta m_bonusLife_score + 1

	lda m_bonusLife_score + 2
	adc #0
	sta m_bonusLife_score + 2
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


;--------------------------------------------------------------------
getHighScoreDigit0
    lda m_hscore_0
	and #$0f

	rts
getHighScoreDigit1
	lda m_hscore_0
	lsr
	lsr
	lsr
	lsr

	rts
getHighScoreDigit2
	lda m_hscore_1
	and #$0f
	rts
getHighScoreDigit3
	lda m_hscore_1
	lsr
	lsr
	lsr
	lsr
	rts
getHighScoreDigit4
	lda m_hscore_2
	and #$0f
	rts
getHighScoreDigit5
	lda m_hscore_2
	lsr
	lsr
	lsr
	lsr
	rts
getHighScoreDigit6
	lda m_hscore_3
	and #$0f
	rts
;---------------------------------------------------------------------------------

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

getBonusLifeScoreDigit4
	lda m_bonusLife_score_2
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


setBonusRollOver
	sed
	lda #$0
	sta m_bonusLife_score_2
	cld
	rts

resetScore
    lda #$0
    sta m_score_0
    sta m_score_1
    sta m_score_2
    sta m_score_3
    sta m_score_4
    sta m_score_5
    sta m_score_6
    rts

resetBonusScore
    lda #$0
    sta m_bonus_score_0
    sta m_bonus_score_1
    sta m_bonus_score_2
    sta m_bonus_score_3
    sta m_bonus_score_4
    sta m_bonus_score_5
    sta m_bonus_score_6
    rts

resetBonusLifeScore
    lda #$0
    stz m_bonusLife_score_0
    stz m_bonusLife_score_1
    stz m_bonusLife_score_2
    rts

setHighScore
	lda m_hscore_6
    cmp m_score_6
    beq _check_byte_5
    bcs _no_new_hi_score
    bcc _setHighScore
	rts

_check_byte_5
	lda m_hscore_5
    cmp m_score_5
    beq _check_byte_4
    bcs _no_new_hi_score
    bcc _setHighScore
    rts

_check_byte_4
	lda m_hscore_4
    cmp m_score_4
    beq _check_byte_3
    bcs _no_new_hi_score
    bcc _setHighScore
    rts

_check_byte_3
	lda m_hscore_3
    cmp m_score_3
    beq _check_byte_2
    bcs _no_new_hi_score
    bcc _setHighScore
    rts

_check_byte_2
	lda m_hscore_2
    cmp m_score_2
    beq _check_byte_1
    bcs _no_new_hi_score
    bcc _setHighScore
    rts

_check_byte_1
	lda m_hscore_1
    cmp m_score_1
    beq _check_byte_0
    bcs _no_new_hi_score
    bcc _setHighScore
    rts

_check_byte_0
	lda m_score_0
    cmp m_hscore_0
    bcs _setHighScore
    rts
_no_new_hi_score
	rts
_setHighScore
	lda m_score_6
	sta m_hscore_6

	lda m_score_5
	sta m_hscore_5

	lda m_score_4
	sta m_hscore_4

	lda m_score_5
	sta m_hscore_5

	lda m_score_2
	sta m_hscore_2

	lda m_score_1
	sta m_hscore_1

	lda m_score_0
	sta m_hscore_0
	cld
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

m_bonusLife_score
m_bonusLife_score_0
 	.byte $00
m_bonusLife_score_1
 	.byte $00
m_bonusLife_score_2
 	.byte $00

m_hscore_0
 	.byte $00
m_hscore_1
 	.byte $00
m_hscore_2
 	.byte $00
m_hscore_3
 	.byte $00
m_hscore_4
 	.byte $00
m_hscore_5
 	.byte $00
m_hscore_6
 	.byte $00
.endsection