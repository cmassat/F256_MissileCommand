;a and x address of text
;y line
drawText
    sta POINTER_SRC
    stx POINTER_SRC + 1

    lda #<mlineTable
    sta POINTER_TXT
    lda #>mlineTable + 1
    sta POINTER_TXT + 1
_findLine
    cpy #0
    beq _writeCharacters

    dey
    clc
    lda POINTER_TXT
    adc #2
    sta POINTER_TXT
    lda POINTER_TXT + 1
    adc #0
    sta POINTER_TXT + 1
    bra _findLine

_writeCharacters
    ldy #0
    lda (POINTER_TXT),y
    sta POINTER_DST
    iny
    lda (POINTER_TXT),y
    sta POINTER_DST + 1


    lda #2
    sta MMU_IO_CTRL
_loop
    lda (POINTER_SRC)
    cmp #0
    beq _end
    lda (POINTER_SRC)
    sta (POINTER_DST)

    lda POINTER_SRC
    clc
    adc #1
    sta POINTER_SRC
    lda POINTER_SRC + 1
    adc #0
    sta POINTER_SRC+ 1

    lda POINTER_DST
    clc
    adc #1
    sta POINTER_DST
    lda POINTER_DST + 1
    adc #0
    sta POINTER_DST + 1
    bra _loop
_end
    lda #0
    sta MMU_IO_CTRL
    rts

;a char
;x col
;y row
drawChar
    pha
    lda #<mlineTable
    sta POINTER_TXT
    lda #>mlineTable + 1
    sta POINTER_TXT + 1
    sty mRowFind
_findLine
    lda mRowFind
    cmp #0
    beq _writeCharacter

    lda mRowFind
    sec
    sbc #1
    sta mRowFind
    clc
    ;lda POINTER_TXT
    ;adc #2
    ;sta POINTER_TXT
    ;lda POINTER_TXT + 1
    ;adc #0
    ;sta POINTER_TXT + 1
    ;bra _findLine
_writeCharacter
    txa
    clc
    adc POINTER_TXT
    sta POINTER_TXT
    lda POINTER_TXT + 1
    adc #0
    sta POINTER_TXT + 1

    ;lda #2
    ;sta MMU_IO_CTRL
    pla
    ;sta (POINTER_TXT)
    ;lda #0
    ;sta MMU_IO_CTRL
    rts

;a foreground color
;b background color
;y line
setColorByLine
    sta POINTER_SRC
    stx POINTER_SRC + 1

    lda #<mlineTable
    sta POINTER_TXT
    lda #>mlineTable + 1
    sta POINTER_TXT + 1
_findLine
    cpy #0
    beq _colorCharacters

    dey
    clc
    lda POINTER_TXT
    adc #2
    sta POINTER_TXT
    lda POINTER_TXT + 1
    adc #0
    sta POINTER_TXT + 1
    bra _findLine

_colorCharacters
    ldy #0
    lda (POINTER_TXT),y
    sta POINTER_DST
    iny
    lda (POINTER_TXT),y
    sta POINTER_DST + 1


    ldy #40
    lda #3
    sta MMU_IO_CTRL
_loop
    cpy #0
    beq _end
    dey
    lda POINTER_SRC
    asl
    asl
    asl
    asl
    ora POINTER_SRC + 1
    sta (POINTER_DST)


    lda POINTER_DST
    clc
    adc #1
    sta POINTER_DST
    lda POINTER_DST + 1
    adc #0
    sta POINTER_DST + 1
    bra _loop
_end
    lda #0
    sta MMU_IO_CTRL
    rts

mlineTable
    .word $C000 ;+ (40 * 0)
    .word $C000 + (40 * 1)
    .word $C000 + (40 * 2)
    .word $C000 + (40 * 3)
    .word $C000 + (40 * 4)
    .word $C000 + (40 * 5)
    .word $C000 + (40 * 6)
    .word $C000 + (40 * 7)
    .word $C000 + (40 * 8)
    .word $C000 + (40 * 9)
    .word $C000 + (40 * 10)
    .word $C000 + (40 * 11)
    .word $C000 + (40 * 12)
    .word $C000 + (40 * 13)
    .word $C000 + (40 * 14)
    .word $C000 + (40 * 15)
    .word $C000 + (40 * 16)
    .word $C000 + (40 * 17)
    .word $C000 + (40 * 18)
    .word $C000 + (40 * 19)
    .word $C000 + (40 * 20)

mRowFind
    .byte $00

