.section code
setPixelColor
	sta mPixelColor
	rts

setOrginX
	STA l_x1
    stx l_x1 + 1
    rts

setOrginY
    STA l_y1
    stx l_y1 + 1
    rts

setDestX
	STA l_x2
    stx l_x2 + 1
    rts
setDestY
    STA l_y2
    stx l_y2 + 1
    rts

getOriginX
	lda l_x1
    ldx l_x1 + 1
    rts

getOriginY
    lda l_y1
    ldx l_y1 + 1
    rts
setAi
    lda l_ai
    ldx l_ai + 1
    rts

setBi
    lda l_bi
    ldx l_bi + 1
    rts
setD
    lda l_d
    ldx l_d + 1
    rts

setDx
    lda l_dx
    ldx l_dx + 1
    rts

setDy
    lda l_dy
    ldx l_dy + 1
    rts
setSteep
    sta mSteep
    rts

setXDir
	sta mXdir
	rts

setYDir
	sta mYdir
	rts

getDestX
	lda l_x2
    ldx l_x2 + 1
    rts


getDestY
    lda l_y2
    ldx l_y2 + 1
    rts

getAi
	lda l_ai
    ldx l_ai + 1
    rts
getBi
    lda l_bi
    ldx l_bi + 1
    rts

getD
    lda l_d
    ldx l_d + 1
    rts
getDx
    lda l_dx
    ldx l_dx + 1
    rts
getDy
    lda l_dy
    ldx l_dy + 1
    rts

getSteep
    lda mSteep
    rts

getXDir
	lda mXdir
	rts

getYDir
	lda mYdir
	rts

calcXDir
	lda l_x1 + 1
	cmp l_x2 + 1
	beq _checkLoX
	bcs _negX
	bcc _posX
_checkLoX
    lda l_x1
	cmp l_x2
	beq _zeroX
	bcc _posX 
	bcs _negX
	rts
_posX
    lda #lDirPos
	sta mXdir
	
	lda l_x2
	SEC
	sbc l_x1
	sta l_dx

	lda l_x2 + 1
	sbc l_x1 + 1
	sta l_dx + 1
	rts
_negX
    lda #lDirNeg
	sta mXdir

	lda l_x1
	SEC
	sbc l_x2
	sta l_dx

	lda l_x1 + 1
	sbc l_x2 + 1
	sta l_dx + 1
	rts
_zeroX
    lda #lDirZer
	sta mXdir
	;stz l_dx
	;stz l_dx + 1
    rts

calcYDir
	lda l_y1 + 1
	cmp l_y2 + 1
	beq _checkLoY
	bcs _negY
	bcc _posY
_checkLoY
    lda l_y1
	cmp l_y2
	bcc _posY
    beq _zeroY
	bcs _negY
	rts
_posY
    lda #lDirPos
	sta mYdir

	lda l_y2
	SEC
	sbc l_y1
	sta l_dy

	lda l_y2 + 1
	sbc l_y1 + 1
	sta l_dy + 1

	rts
_negY
    lda #lDirNeg
	sta mYdir

	lda l_y1
	SEC
	sbc l_y2
	sta l_dy

	lda l_y1 + 1
	sbc l_y2 + 1
	sta l_dy + 1

	rts
_zeroY
    lda #lDirZer
	sta mYdir
	;stz l_dy
	;stz l_dy + 1
    rts

calcai
	lda mSteep
	cmp #1
	beq _setSteep
    ;ai =2*dy
    lda l_dy
    sta l_ai
    lda l_dy + 1
    sta l_ai + 1

    clc
    lda l_ai
    asl
    sta l_ai
    
    lda l_ai + 1
    rol
    sta l_ai + 1
    rts
_setSteep
	;ai =2*dx
    lda l_dx
    sta l_ai
    lda l_dx + 1
    sta l_ai + 1

    clc
    lda l_ai
    asl
    sta l_ai

    lda l_ai + 1
    rol
    sta l_ai + 1
	rts

calcbi
	lda mSteep
	cmp #1
	beq _setSteep
    ;bi =2*(dy-dx)
    LDA l_dy
    SEC
    SBC l_dx
    sta l_bi

    LDA l_dy + 1
    SBC l_dx + 1
    sta l_bi + 1

    clc
    lda l_bi
    asl
    sta l_bi

    lda l_bi + 1
    rol
    sta l_bi + 1
    rts
_setSteep
	;bi =2*(dx-dy)
    LDA l_dx
    SEC
    SBC l_dy
    sta l_bi

    LDA l_dx + 1
    SBC l_dy + 1
    sta l_bi + 1

    clc
    lda l_bi
    asl
    sta l_bi

    lda l_bi + 1
    rol
    sta l_bi + 1
	rts

calcDecision
    ;decision = ai-dx
    lda l_ai 
	sec  
    sbc l_dx
	sta l_d

	lda l_ai + 1
	sbc l_dx + 1
	sta l_d + 1

	rts 

checkSteep
	lda mXdir
	cmp #lDirZer
	beq _skip

	lda l_dy + 1
	cmp l_dx + 1
	beq _checkLo
	bcs _steep
_skip
	rts
_checkLo
	lda l_dy
	cmp l_dx
	bcs _steep
	rts
_steep
	lda #1
	sta mSteep
	rts

lineUpdateDecision
	lda mXdir
	cmp #lDirZer
	beq _updateYOnly

	lda mYdir
	cmp #lDirZer
	beq _updateXOnly
    lda l_d + 1
	cmp #0
	bmi _isNeg

	lda l_d 
	clc 
	adc l_bi 
	sta l_d 
	lda l_d + 1
	adc l_bi + 1
	sta l_d + 1

	lda mSteep
	cmp #1
	beq _steepSlope

	lda l_d + 1
	cmp #0
	bmi _updateX
	beq _updateY
	bpl _updateY
    rts 
_isNeg 
    lda l_d 
	clc
	adc l_ai 
	sta l_d
	lda l_d + 1
	adc l_ai + 1
	sta l_d + 1
	 
	lda mSteep
	cmp #1
	beq _steepSlope
	lda l_d + 1
	cmp #0
	bmi _updateX
	beq _updateY
	bpl _updateY
    rts
_updateY
    jsr lineUpdateY
	jsr lineUpdateX
	rts
_updateX
    jsr lineUpdateX
    rts
_updateYOnly
    jsr lineUpdateY
    rts
_updateXOnly
	jsr lineUpdateX
	rts
_steepSlope
	lda l_d + 1
	cmp #0
	bmi _updateYOnly
	beq _updateY
	bpl _updateY
	rts

lineUpdateX
    lda mXdir
	cmp #lDirNeg
	beq _neg 
	lda l_x1
	clc
	adc #1
	sta l_x1

	lda l_x1 + 1
	adc #0
	sta l_x1 + 1
    rts
_neg
    lda l_x1
	sec
	sbc #1
	sta l_x1

	lda l_x1 + 1
	sbc #0
	sta l_x1 + 1
    rts

lineUpdateY
    lda mYdir
	cmp #lDirNeg
	beq _neg
	lda l_y1
	clc
	adc #1
	sta l_y1

	lda l_y1 + 1
	adc #0
	sta l_y1 + 1
    rts  
_neg
    lda l_y1
	sec
	sbc #1
	sta l_y1

	lda l_y1 + 1
	sbc #0
	sta l_y1 + 1
    rts

lineInit
	pha
	phx
	phy
	stz mSteep
    jsr calcXDir
	jsr calcYDir
	jsr checkSteep
	jsr calcai
	jsr calcbi
	jsr calcDecision
	ply
	plx
	pla
	rts

linestep
	pha
	phx
	phy
	jsr lineUpdateDecision
	ply
	plx
	pla
	rts

do_line
	jsr lineInit

_loop
    jsr putPixel

;updateDecision

	jsr lineUpdateDecision

	lda mXdir
	cmp #lDirZer
	beq _checkEOLY
_checkEOL
	lda l_x1 + 1
	cmp l_x2 + 1
	beq _checklo
	bra _loop
_checklo
	lda l_x1
	cmp l_x2
	bne _loop
	bra _putLastPixel
	rts
_checkEOLY
	 lda l_y1 + 1
	 cmp l_y2 + 1
	 beq _checkloY
	 bra _loop
_checkloY
	 lda l_y1
	 cmp l_y2
	 bne _loop
_putLastPixel
   lda l_x2
   sta l_x1
   lda l_x2 + 1
   sta l_x1 + 1

   lda l_y2
   sta l_y1
   lda l_y2 + 1
   sta l_y1 + 1

   jsr putPixel
	rts

getPixel
	phy
	phx
	;pha
	lda #<320
	ldx #>320
	jsr setMulA

	lda l_y1
	ldx l_y1 + 1
	jsr setMulB

	jsr getMulResult
	sta mPixel
	stx mPixel + 1
	sty mPixel + 2

	lda mPixel
	clc
	adc l_x1
	sta mPixel
	lda mPixel + 1
	adc l_x1 + 1
	sta mPixel + 1

	lda mPixel + 2
	adc #0
	sta mPixel + 2

	jsr getBank
	sta $d
	txa
	tay
	lda #$b3
	lda MMU_MEM_CTRL

	lda #<mLineOffset
	sta pointer
	lda #>mLineOffset + 1
	sta pointer + 1

	lda mPixel
	sec
	sbc (pointer),y
	sta mPixel

	lda mPixel + 1
	iny
	sbc (pointer),y
	sta mPixel + 1

	lda mPixel
	clc
	adc #<$a000
	sta POINTER_LINE

	lda mPixel + 1
	adc #>$a000
	sta POINTER_LINE + 1


	lda (POINTER_LINE)
	sta m_temp_pixel
	lda #5
	sta $d
	lda m_temp_pixel

;	pla
	plx
	ply

  rts

clearPixel
	pha
	phx
	phy
	lda #<320
	ldx #>320
	jsr setMulA

	lda l_y1
	ldx l_y1 + 1
	jsr setMulB

	jsr getMulResult
	sta mPixel
	stx mPixel + 1
	sty mPixel + 2

	lda mPixel
	clc
	adc l_x1
	sta mPixel
	lda mPixel + 1
	adc l_x1 + 1
	sta mPixel + 1

	lda mPixel + 2
	adc #0
	sta mPixel + 2

	jsr getBank
	sta $d
	txa
	tay
	lda #$b3
	lda MMU_MEM_CTRL

	lda #<mLineOffset
	sta pointer
	lda #>mLineOffset + 1
	sta pointer + 1

	lda mPixel
	sec
	sbc (pointer),y
	sta mPixel

	lda mPixel + 1
	iny
	sbc (pointer),y
	sta mPixel + 1

	lda mPixel
	clc
	adc #<$a000
	sta POINTER_LINE

	lda mPixel + 1
	adc #>$a000
	sta POINTER_LINE + 1
	lda #112
	sta (POINTER_LINE)

	lda #5
	sta $d
	ply
	plx
	pla
	rts

putPixel
	lda #<320
	ldx #>320
	jsr setMulA

	lda l_y1
	ldx l_y1 + 1
	jsr setMulB

	jsr getMulResult
	sta mPixel
	stx mPixel + 1
	sty mPixel + 2

	lda mPixel
	clc
	adc l_x1
	sta mPixel
	lda mPixel + 1
	adc l_x1 + 1
	sta mPixel + 1

	lda mPixel + 2
	adc #0
	sta mPixel + 2

	jsr getBank
	sta $d
	txa
	tay
	lda #$b3
	lda MMU_MEM_CTRL

	lda #<mLineOffset
	sta pointer
	lda #>mLineOffset + 1
	sta pointer + 1

	lda mPixel
	sec
	sbc (pointer),y
	sta mPixel

	lda mPixel + 1
	iny
	sbc (pointer),y
	sta mPixel + 1

	lda mPixel
	clc
	adc #<$a000
	sta POINTER_LINE

	lda mPixel + 1
	adc #>$a000
	sta POINTER_LINE + 1
	lda mPixelColor
	sta (POINTER_LINE)

	lda #5
	sta $d
  	rts

;POINTER_LINE = $B4
getBank
	lda mPixel + 2
	cmp #1
	beq _checkOverlap
	lda mPixel + 1
	cmp #$e0
	bcs _15
	cmp #$c0
	bcs _14
	cmp #$a0
	bcs _13
	cmp #$80
	bcs _12
	cmp #$60
	bcs _11
	cmp #$40
	bcs _10
	cmp #$20
	bcs _9
	cmp #$00
	bcs _8
	rts
_8
	lda #8
	ldx #00
	rts
_9
	lda #9
	ldx #02
	rts
_10
	lda #10
	ldx #04
	rts
_11
	lda #11
	ldx #06
	rts
_12
	lda #12
	ldx #08
	rts
_13
	lda #13
	ldx #10
	rts
_14
	lda #14
	ldx #12
	rts
_15
	lda #15
	ldx #14
	rts

_checkOverlap
	lda mPixel + 1
	cmp #$20
	bcs _bank17
	lda #16
	ldx #16
	rts
_bank17
	lda #17
	ldx #18
	rts
.endsection
.section variables
mLineData
l_dx .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
l_dy .word $0  ; ZU - "dlugosc" y A
l_xi .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
l_yi .word $0  ; U2
l_ai .word $0 ; U2 step
l_bi .word $0 ; U2 step
l_d  .word $0 ; U2 'error'

;poin.byte $0 ;
l_x1 .word $0 ; ZU poczatek linii
l_y1 .word $0 ; ZU
l_x2 .word $0 ; ZU koniec linii
l_y2 .word $0 ; ZU
mSteep
	.byte $0
mXdir
    .byte $00
mYdir
    .byte $00
; mDWeight
;     .byte $00

mLineDateEnd
mLineDataLength
	.byte mLineDateEnd - mLineData
mPixel
	.byte $00, $00, $00
m_temp_pixel
	.byte $00
mPixelColor
	.byte $00
mLineOffset
	.word $0000
	.word $2000
	.word $4000
	.word $6000
	.word $8000
	.word $a000
	.word $c000
	.word $e000
	.word $0000
	.word $2000

lDirZer = 0
lDirNeg = 1
lDirPos = 2


lWeight1 = 0
lWeightX = 2
lWeightY= 3

.endsection