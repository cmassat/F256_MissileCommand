
; stepLine  .namespace
; setOrginX
;     ldy #idxSourceX
; 	STA (POINTER_LINE),y
;     iny
;     txa
;     STA (POINTER_LINE),y
;     rts

; setOrginY
;     ldy #idxSourceY
; 	STA (POINTER_LINE),y
;     iny
;     txa
;     STA (POINTER_LINE),y
;     rts

; setDestX
; 	ldy #idxDestX
; 	STA (POINTER_LINE),y
;     iny
;     txa
;     STA (POINTER_LINE),y
;     rts
; setDestY
;     ldy #idxDestY
; 	STA (POINTER_LINE),y
;     iny
;     txa
;     STA (POINTER_LINE),y
;     rts

; calcXDir
;     ldy #idxSourceX
;     iny
;     lda (POINTER_LINE),y
;     sta mtemp1

;     ldy #idxDestX
;     iny
;     lda (POINTER_LINE),y
;     sta mtemp2

; 	lda mtemp1
; 	cmp mtemp2
; 	beq _checkLoX
; 	bcs _negX
; 	bcc _posX
; _checkLoX
;     ldy #idxSourceX
;     lda (POINTER_LINE),y
;     sta mtemp1

;     ldy #idxDestX
;     lda (POINTER_LINE),y
;     sta mtemp2

;     lda mtemp1
; 	cmp mtemp2
; 	beq _zeroX
; 	bcc _posX
; 	bcs _negX
; 	rts
; _posX
;     lda #lDirPos
; 	sta mXdir

; 	lda ls_x2
; 	SEC
; 	sbc ls_x1
; 	sta ls_dx

; 	lda ls_x2 + 1
; 	sbc ls_x1 + 1
; 	sta ls_dx + 1
; 	rts
; _negX
;     lda #lDirNeg
; 	sta mXdir

; 	lda ls_x1
; 	SEC
; 	sbc ls_x2
; 	sta ls_dx

; 	lda ls_x1 + 1
; 	sbc ls_x2 + 1
; 	sta ls_dx + 1
; 	rts
; _zeroX
;     lda #lDirZer
; 	sta mXdir
; 	;stz ls_dx
; 	;stz ls_dx + 1
;     rts

; calcYDir
; 	lda ls_y1 + 1
; 	cmp ls_y2 + 1
; 	beq _checkLoY
; 	bcs _negY
; 	bcc _posY
; _checkLoY
;     lda ls_y1
; 	cmp ls_y2
; 	bcc _posY
;     beq _zeroY
; 	bcs _negY
; 	rts
; _posY
;     lda #lDirPos
; 	sta mYdir

; 	lda ls_y2
; 	SEC
; 	sbc ls_y1
; 	sta ls_dy

; 	lda ls_y2 + 1
; 	sbc ls_y1 + 1
; 	sta ls_dy + 1

; 	rts
; _negY
;     lda #lDirNeg
; 	sta mYdir

; 	lda ls_y1
; 	SEC
; 	sbc ls_y2
; 	sta ls_dy

; 	lda ls_y1 + 1
; 	sbc ls_y2 + 1
; 	sta ls_dy + 1

; 	rts
; _zeroY
;     lda #lDirZer
; 	sta mYdir
; 	;stz ls_dy
; 	;stz ls_dy + 1
;     rts

; calcai
; 	lda mSteepLs
; 	cmp #1
; 	beq _setSteep
;     ;ai =2*dy
;     lda ls_dy
;     sta ls_ai
;     lda ls_dy + 1
;     sta ls_ai + 1

;     clc
;     lda ls_ai
;     asl
;     sta ls_ai

;     lda ls_ai + 1
;     rol
;     sta ls_ai + 1
;     rts
; _setSteep
; 	;ai =2*dx
;     lda ls_dx
;     sta ls_ai
;     lda ls_dx + 1
;     sta ls_ai + 1

;     clc
;     lda ls_ai
;     asl
;     sta ls_ai

;     lda ls_ai + 1
;     rol
;     sta ls_ai + 1
; 	rts

; calcbi
; 	lda mSteepLs
; 	cmp #1
; 	beq _setSteep
;     ;bi =2*(dy-dx)
;     LDA ls_dy
;     SEC
;     SBC ls_dx
;     sta ls_bi

;     LDA ls_dy + 1
;     SBC ls_dx + 1
;     sta ls_bi + 1

;     clc
;     lda ls_bi
;     asl
;     sta ls_bi

;     lda ls_bi + 1
;     rol
;     sta ls_bi + 1
;     rts
; _setSteep
; 	;bi =2*(dx-dy)
;     LDA ls_dx
;     SEC
;     SBC ls_dy
;     sta ls_bi

;     LDA ls_dx + 1
;     SBC ls_dy + 1
;     sta ls_bi + 1

;     clc
;     lda ls_bi
;     asl
;     sta ls_bi

;     lda ls_bi + 1
;     rol
;     sta ls_bi + 1
; 	rts

; calcDecision
;     ;decision = ai-dx
;     lda ls_ai
; 	sec
;     sbc ls_dx
; 	sta ls_d

; 	lda ls_ai + 1
; 	sbc ls_dx + 1
; 	sta ls_d + 1

; 	rts

; checkSteep
; 	lda mXdir
; 	cmp #lDirZer
; 	beq _skip

; 	lda ls_dy + 1
; 	cmp ls_dx + 1
; 	beq _checkLo
; 	bcs _steep
; _skip
; 	rts
; _checkLo
; 	lda ls_dy
; 	cmp ls_dx
; 	bcs _steep
; 	rts
; _steep
; 	lda #1
; 	sta mSteepLs
; 	rts

; lineUpdateDecision
; 	lda mXdir
; 	cmp #lDirZer
; 	beq _updateYOnly

; 	lda mYdir
; 	cmp #lDirZer
; 	beq _updateXOnly
;     lda ls_d + 1
; 	cmp #0
; 	bmi _isNeg

; 	lda ls_d
; 	clc
; 	adc ls_bi
; 	sta ls_d
; 	lda ls_d + 1
; 	adc ls_bi + 1
; 	sta ls_d + 1

; 	lda mSteepLs
; 	cmp #1
; 	beq _steepSlope

; 	lda ls_d + 1
; 	cmp #0
; 	bmi _updateX
; 	beq _updateY
; 	bpl _updateY
;     rts
; _isNeg
;     lda ls_d
; 	clc
; 	adc ls_ai
; 	sta ls_d
; 	lda ls_d + 1
; 	adc ls_ai + 1
; 	sta ls_d + 1

; 	lda mSteepLs
; 	cmp #1
; 	beq _steepSlope
; 	lda ls_d + 1
; 	cmp #0
; 	bmi _updateX
; 	beq _updateY
; 	bpl _updateY
;     rts
; _updateY
;     jsr lineUpdateY
; 	jsr lineUpdateX
; 	rts
; _updateX
;     jsr lineUpdateX
;     rts
; _updateYOnly
;     jsr lineUpdateY
;     rts
; _updateXOnly
; 	jsr lineUpdateX
; 	rts
; _steepSlope
; 	lda ls_d + 1
; 	cmp #0
; 	bmi _updateYOnly
; 	beq _updateY
; 	bpl _updateY
; 	rts

; lineUpdateX
;     lda mXdir
; 	cmp #lDirNeg
; 	beq _neg
; 	lda ls_x1
; 	clc
; 	adc #1
; 	sta ls_x1

; 	lda ls_x1 + 1
; 	adc #0
; 	sta ls_x1 + 1
;     rts
; _neg
;     lda ls_x1
; 	sec
; 	sbc #1
; 	sta ls_x1

; 	lda ls_x1 + 1
; 	sbc #0
; 	sta ls_x1 + 1
;     rts

; lineUpdateY
;     lda mYdir
; 	cmp #lDirNeg
; 	beq _neg
; 	lda ls_y1
; 	clc
; 	adc #1
; 	sta ls_y1

; 	lda ls_y1 + 1
; 	adc #0
; 	sta ls_y1 + 1
;     rts
; _neg
;     lda ls_y1
; 	sec
; 	sbc #1
; 	sta ls_y1

; 	lda ls_y1 + 1
; 	sbc #0
; 	sta ls_y1 + 1
;     rts

; lineInit
; 	pha
; 	phx
; 	phy
; 	stz mSteepLs
;     jsr calcXDir
; 	jsr calcYDir
; 	jsr checkSteep
; 	jsr calcai
; 	jsr calcbi
; 	jsr calcDecision
; 	ply
; 	plx
; 	pla
; 	rts

; linestep
; 	pha
; 	phx
; 	phy
; 	jsr lineUpdateDecision
; 	ply
; 	plx
; 	pla
; 	rts

; ; do_line
; ; 	jsr lineInit

; ; _loop
; ;     jsr putPixel

; ; ;updateDecision

; ; 	jsr lineUpdateDecision

; ; 	lda mXdir
; ; 	cmp #lDirZer
; ; 	beq _checkEOLY
; ; _checkEOL
; ; 	lda ls_x1+1
; ; 	cmp ls_x2 + 1
; ; 	beq _checklo
; ; 	bra _loop
; ; _checklo
; ; 	lda ls_x1
; ; 	cmp ls_x2
; ; 	bne _loop
; ; 	bra _putLastPixel
; ; 	rts
; ; _checkEOLY
; ; 	 lda ls_y1 + 1
; ; 	 cmp ls_y2 + 1
; ; 	 beq _checkloY
; ; 	 bra _loop
; ; _checkloY
; ; 	 lda ls_y1
; ; 	 cmp ls_y2
; ; 	 bne _loop
; ; _putLastPixel
; ;    lda ls_x2
; ;    sta ls_x1
; ;    lda ls_x2 + 1
; ;    sta ls_x1 + 1

; ;    lda ls_y2
; ;    sta ls_y1
; ;    lda ls_y2 + 1
; ;    sta ls_y1 + 1

; ;    jsr putPixel
; ;     rts

; getPixel
; 	phy
; 	phx
; 	;pha
; 	lda #<320
; 	ldx #>320
; 	jsr setMulA

; 	lda ls_y1
; 	ldx ls_y1 + 1
; 	jsr setMulB

; 	jsr getMulResult
; 	sta mPixel
; 	stx mPixel + 1
; 	sty mPixel + 2

; 	lda mPixel
; 	clc
; 	adc ls_x1
; 	sta mPixel
; 	lda mPixel + 1
; 	adc ls_x1 + 1
; 	sta mPixel + 1

; 	lda mPixel + 2
; 	adc #0
; 	sta mPixel + 2

; 	jsr getBank
; 	sta $d
; 	txa
; 	tay
; 	lda #$b3
; 	sta MMU_MEM_CTRL

; 	lda #<mLineOffset
; 	sta pointer
; 	lda #>mLineOffset + 1
; 	sta pointer + 1

; 	lda mPixel
; 	sec
; 	sbc (pointer),y
; 	sta mPixel

; 	lda mPixel + 1
; 	iny
; 	sbc (pointer),y
; 	sta mPixel + 1

; 	lda mPixel
; 	clc
; 	adc #<$a000
; 	sta POINTER_LINE

; 	lda mPixel + 1
; 	adc #>$a000
; 	sta POINTER_LINE + 1

; 	lda (POINTER_LINE)
; 	sta m_temp_pixel
; 	lda #5
; 	sta $d
; 	lda m_temp_pixel

; ;	pla
; 	plx
; 	ply

;   rts
; putPixel
; 	pha
; 	phx
; 	phy
; 	lda #<320
; 	ldx #>320
; 	jsr setMulA

; 	lda ls_y1
; 	ldx ls_y1 + 1
; 	jsr setMulB

; 	jsr getMulResult
; 	sta mPixel
; 	stx mPixel + 1
; 	sty mPixel + 2

; 	lda mPixel
; 	clc
; 	adc ls_x1
; 	sta mPixel
; 	lda mPixel + 1
; 	adc ls_x1 + 1
; 	sta mPixel + 1

; 	lda mPixel + 2
; 	adc #0
; 	sta mPixel + 2

; 	jsr getBank
; 	sta $d
; 	txa
; 	tay
; 	lda #$b3
; 	sta MMU_MEM_CTRL

; 	lda #<mLineOffset
; 	sta pointer
; 	lda #>mLineOffset + 1
; 	sta pointer + 1

; 	lda mPixel
; 	sec
; 	sbc (pointer),y
; 	sta mPixel

; 	lda mPixel + 1
; 	iny
; 	sbc (pointer),y
; 	sta mPixel + 1

; 	lda mPixel
; 	clc
; 	adc #<$a000
; 	sta POINTER_LINE

; 	lda mPixel + 1
; 	adc #>$a000
; 	sta POINTER_LINE + 1
; 	lda #112
; 	sta (POINTER_LINE)

; 	lda #5
; 	sta $d
; 	ply
; 	plx
; 	pla
;   rts

; ;POINTER_LINE = $B4
; getBank
; 	lda mPixel + 2
; 	cmp #1
; 	beq _checkOverlap
; 	lda mPixel + 1
; 	cmp #$e0
; 	bcs _15
; 	cmp #$c0
; 	bcs _14
; 	cmp #$a0
; 	bcs _13
; 	cmp #$80
; 	bcs _12
; 	cmp #$60
; 	bcs _11
; 	cmp #$40
; 	bcs _10
; 	cmp #$20
; 	bcs _9
; 	cmp #$00
; 	bcs _8
; 	rts
; _8
; 	lda #8
; 	ldx #00
; 	rts
; _9
; 	lda #9
; 	ldx #02
; 	rts
; _10
; 	lda #10
; 	ldx #04
; 	rts
; _11
; 	lda #11
; 	ldx #06
; 	rts
; _12
; 	lda #12
; 	ldx #08
; 	rts
; _13
; 	lda #13
; 	ldx #10
; 	rts
; _14
; 	lda #14
; 	ldx #12
; 	rts
; _15
; 	lda #15
; 	ldx #14
; 	rts

; _checkOverlap
; 	lda mPixel + 1
; 	cmp #$20
; 	bcs _bank17
; 	lda #16
; 	ldx #16
; 	rts
; _bank17
; 	lda #17
; 	ldx #18
; 	rts
; mLineData
; ;ls_dx .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
; ;ls_dy .word $0  ; ZU - "dlugosc" y A
; ;ls_xi .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
; ;ls_yi .word $0  ; U2
; ;ls_ai .word $0 ; U2 step
; ;ls_bi .word $0 ; U2 step
; ;ls_d  .word $0 ; U2 'error'
; ;
; ;;poin.byte $0 ;
; ;ls_x1 .word $0 ; ZU poczatek linii ; 14
; ;ls_y1 .word $0 ; ZU 16
; ;ls_x2 .word $0 ; ZU koniec linii 18
; ;ls_y2 .word $0 ; ZU 20
; ;mSteepLs
; ;	.byte $0
; idxDx = 0
; idxDy = 2
; idxXi = 4
; idxYi = 6
; idxAi = 8
; idxBi = 10
; idxD = 12
; idxSourceX = 14
; idxSourceY = 16
; idxDestX = 18
; idxDestY = 20
; idxSteep = 22
; mLineDateEnd
; lineDataLength
; 	.byte mLineDateEnd - mLineData
; mPixel
; 	.byte $00, $00, $00
; mXdir
;     .byte $00
; mYdir
;     .byte $00
; ; mLineError
; ; 	.byte $00,$00
; ; mLineError2
; ; 	.byte $00,$00
; ; mLineTemp
; ; 	.byte $00, $00
; mtemp1
;     .byte $00
; mtemp2
;     .byte $00
; mLineOffset
; 	.word $0000
; 	.word $2000
; 	.word $4000
; 	.word $6000
; 	.word $8000
; 	.word $a000
; 	.word $c000
; 	.word $e000
; 	.word $0000
; 	.word $2000

; lDirZer = 0
; lDirNeg = 1
; lDirPos = 2

; mDWeight
;     .byte $00

; lWeight1 = 0
; lWeightX = 2
; lWeightY= 3
; .endnamespace