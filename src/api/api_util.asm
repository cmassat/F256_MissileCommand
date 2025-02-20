.section code
; returns pseudo random 8 bit number in A. Affects A, X and Y.
; (r_seed) is the byte from which the number is generated and MUST be
; initialised to a non zero value or this function will always return
; zero. Also r_seed must be in RAM, you can see why......

rand_8
	lda #1
    sta $d6a6
	lda r_seed
	sta $D6A4
	lda $D6A4
	sta $D6A5
	ldx $D6A5
    lda $D6A4
	RTS			; done

getRandom
    lda r_seed
    cmp #0
    bne rand_8
    lda #127
    sta r_seed
    jsr rand_8
    rts
.endsection
.section variables
r_seed
	.byte	1		; prng seed byte (must not be zero)
.endsection

