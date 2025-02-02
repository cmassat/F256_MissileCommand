;a low
;x hi
setMulA
	sta $DE00
	txa
	sta $DE01
	rts
;a low
;x hi
setMulB
	sta $DE02
	txa
	sta $DE03
	rts

getMulResult
	lda $DE10
	pha
	lda $DE11
	tax
    lda $DE12
	tay
	pla
	rts


;a low
;x hi
setNum
	sta $DE06
	txa
	sta $DE07
	rts
;a low
;x hi
setDen
	sta $DE04
	txa
	sta $DE05
	rts

getDivResult
	lda $DDE14
	ldx $DE15
	rts