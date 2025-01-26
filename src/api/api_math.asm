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
