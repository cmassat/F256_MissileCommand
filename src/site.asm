site .namespace
.section code

handle
    jsr draw
    rts
draw
     stz $D6E0
    lda m_mouse_x_pos
    ldx m_mouse_x_pos + 1
    jsr setNum

    lda #2
    ldx #0
    jsr setDen

    jsr getDivResult
    sta TEMP_X
    stx TEMP_X + 1

    lda m_mouse_y_pos
    ldx m_mouse_y_pos + 1
    jsr setNum

    lda #2
    ldx #0
    jsr setDen

    jsr getDivResult
    sta TEMP_Y
    stx TEMP_Y + 1


    lda TEMP_X
    clc
    adc #32 - 8
    sta TEMP_X

    lda TEMP_X + 1
    adc #0
    sta TEMP_X + 1


    lda TEMP_Y
    clc
    adc #32 - 8
    sta TEMP_Y

    lda TEMP_Y + 1
    adc #0
    sta TEMP_Y + 1

    lda #SPRITENUMBER_REDICLE
    jsr setSpriteNumber

    lda TEMP_X
    ldx TEMP_X + 1
    jsr setSpriteX

    lda TEMP_Y
    ldx TEMP_Y + 1
    jsr setSpriteY

    jsr showSprite

    rts
.endsection
.section variables
TEMP_X
    .byte $00, $00
TEMP_Y
    .byte $00, $00
.endsection
.endnamespace