.section code 
loadFont
    lda #1
    sta MMU_IO_CTRL
    ldy #0
_loop
    lda mFont, y
    sta $c000, y
    iny
    cpy #24
    bne _loop
    lda #0
    sta  MMU_IO_CTRL
    rts
.endsection

.section variables
mFont
.byte %00011000
.byte %00011000
.byte %00011000
.byte %00011000
.byte %01111110
.byte %01100110
.byte %01100110
.byte %00000000

.byte %00000000
.byte %00000000
.byte %00000000
.byte %00001000
.byte %00011000
.byte %01111100
.byte %11111111
.byte %11111111

.byte %00000000
.byte %00000000
.byte %00001000
.byte %00011000
.byte %00111010
.byte %11111110
.byte %11111110
.byte %11111110
.endsection