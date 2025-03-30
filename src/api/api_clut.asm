;TODO: Clean this S$it up
clutInc
    asl
    tay
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<$D020
    sta POINTER_CLUT_DEST

    lda #>$D020
    sta POINTER_CLUT_DEST  + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #5
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #10
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #15
    sta (POINTER_CLUT_DEST)
    stz  MMU_IO_CTRL

    rts

missleColor
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<CLUT_0_ADDR + (EXPLOSION_CLR * 4)
    sta POINTER_CLUT_DEST

    lda #>CLUT_0_ADDR + (EXPLOSION_CLR * 4)
    sta POINTER_CLUT_DEST   + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #5
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #10
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #15
    sta (POINTER_CLUT_DEST)
    stz  MMU_IO_CTRL
    rts


alphaColor
     pha
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<CLUT_0_ADDR + (APLHA_CLR * 4)
    sta POINTER_CLUT_DEST

    lda #>CLUT_0_ADDR + (APLHA_CLR * 4)
    sta POINTER_CLUT_DEST   + 1

    tya
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    txa
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    pla
    sta (POINTER_CLUT_DEST)
    stz  MMU_IO_CTRL
    rts

icbmColor
     pha
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<CLUT_0_ADDR + (MISSLE_CLR * 4)
    sta POINTER_CLUT_DEST

    lda #>CLUT_0_ADDR + (MISSLE_CLR * 4)
    sta POINTER_CLUT_DEST   + 1

    tya
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    txa
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    pla
    sta (POINTER_CLUT_DEST)
    stz  MMU_IO_CTRL
    rts

icbmHeadColor
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<CLUT_0_ADDR + (ICBM_HEAD * 4)
    sta POINTER_CLUT_DEST

    lda #>CLUT_0_ADDR + (ICBM_HEAD * 4)
    sta POINTER_CLUT_DEST   + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #5
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #10
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    lda (POINTER_CLUT_DEST)
    clc
    adc #15
    sta (POINTER_CLUT_DEST)
    stz  MMU_IO_CTRL
    rts

abmColor
    pha
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<CLUT_0_ADDR + (ABM_CLR * 4)
    sta POINTER_CLUT_DEST

    lda #>CLUT_0_ADDR + (ABM_CLR * 4)
    sta POINTER_CLUT_DEST   + 1

    tya
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    txa
    sta (POINTER_CLUT_DEST)

    lda POINTER_CLUT_DEST
    clc
    adc #1
    sta POINTER_CLUT_DEST
    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    pla
    sta (POINTER_CLUT_DEST)
    stz  MMU_IO_CTRL
    rts

clut_load_0
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<$A000
    sta POINTER_CLUT_SRC

    lda #>$A000
    sta POINTER_CLUT_SRC+1

    lda #<CLUT_0_ADDR
    sta POINTER_CLUT_DEST
    lda #>CLUT_0_ADDR
    sta POINTER_CLUT_DEST+1

    ldx #0
_clut_row
    ldy #0
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y

    lda POINTER_CLUT_SRC
    clc
    adc #4
    sta POINTER_CLUT_SRC

    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

     lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST

    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx #127
    bne _clut_row

    stz MMU_IO_CTRL
    rts

 clut_load_1
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<$A000
    sta POINTER_CLUT_SRC

    lda #>$A000
    sta POINTER_CLUT_SRC+1

    lda #<CLUT_1_ADDR
    sta POINTER_CLUT_DEST
    lda #>CLUT_1_ADDR
    sta POINTER_CLUT_DEST+1

    ldx #0
_clut_row1
    ldy #0
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y

    lda POINTER_CLUT_SRC
    clc
    adc #4
    sta POINTER_CLUT_SRC

    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

    lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST

    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx #$ff
    bne _clut_row1

    lda #0
    sta MMU_IO_CTRL
    rts

 clut_load_2
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<$A000
    sta POINTER_CLUT_SRC

    lda #>$A000
    sta POINTER_CLUT_SRC+1

    lda #<CLUT_2_ADDR
    sta POINTER_CLUT_DEST
    lda #>CLUT_2_ADDR
    sta POINTER_CLUT_DEST+1

    ldx #0
_clut_row2
    ldy #0
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y

    lda POINTER_CLUT_SRC
    clc
    adc #4
    sta POINTER_CLUT_SRC

    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

    lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST

    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx #$ff
    bne _clut_row2

    lda #0
    sta MMU_IO_CTRL
    rts

 clut_load_3
    lda #CLUT_IO
    sta MMU_IO_CTRL

    lda #<$A000
    sta POINTER_CLUT_SRC

    lda #>$A000
    sta POINTER_CLUT_SRC+1

    lda #<CLUT_3_ADDR
    sta POINTER_CLUT_DEST
    lda #>CLUT_3_ADDR
    sta POINTER_CLUT_DEST+1

    ldx #0
_clut_row3
    ldy #0
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y
    iny
    lda (POINTER_CLUT_SRC),y
    sta (POINTER_CLUT_DEST),y

    lda POINTER_CLUT_SRC
    clc
    adc #4
    sta POINTER_CLUT_SRC

    lda POINTER_CLUT_SRC + 1
    adc #0
    sta POINTER_CLUT_SRC + 1

    lda POINTER_CLUT_DEST
    clc
    adc #4
    sta POINTER_CLUT_DEST

    lda POINTER_CLUT_DEST + 1
    adc #0
    sta POINTER_CLUT_DEST + 1

    inx
    cpx #$ff
    bne _clut_row3+4


    lda #0
    sta MMU_IO_CTRL
    rts

setColor
    sta mRed
    stx mGreen
    sty mBlue
    rts

.section variables
mRed
    .byte $00
mGreen
    .byte $00
mBlue
    .byte $00


mColor1
    .byte $00
mclut
   .word $D000 ;0
   .word $D008 ;1
   .word $D00C ;2
   .word $D010 ;3
   .word $D014 ;3
   .word $D018 ;4
   .word $D01C ;5
   .word $D020 ;6
   .word $D024 ;7
   .word $D028 ;8
   .word $D02c


.endsection