; Bresenham's Circle Algorithm in 6502 Assembly
; Assumes `PlotPixel(X, Y)` is implemented elsewhere
; X and Y registers hold coordinates, radius is in `R`
circle .namespace
setCenterX
    sta X_REG
    stx X_REG + 1
    rts

setCenterY
    sta Y_REG
    stx Y_REG + 1
    rts

setRadius
    sta R
    stx R + 1
    rts

activate
    lda #0
    sta x_pos
    sta x_pos + 1

    LDA R           ; y = radius
    STA Y_POS
    lda R + 1
    sta Y_POS + 1

    lda #1
    sec
    sbc R
    sta D
    lda R + 1
    sbc #0
    sta D + 1

    rts

posX
    LDA X_POS
    CLC
    ADC X_REG       ; Xc + x
    STA PX
    LDA X_POS + 1
    ADC X_REG + 1
    STA PX + 1
    rts
negX
    LDA X_REG
    sec
    sbc X_POS       ; Xc + x
    STA PX
    LDA X_REG + 1
    sbc X_POS + 1
    STA PX + 1
    rts
posY
    LDA Y_POS
    CLC
    ADC Y_REG       ; Yc + y
    STA PY
    LDA Y_POS + 1
    adc Y_REG + 1
    sta PY + 1
    rts

negY
    LDA Y_REG
    sec
    sbc Y_POS      ; Yc + y
    STA PY
    LDA Y_REG + 1
    sbc Y_POS + 1
    sta PY + 1
    rts

rNegX
    LDA X_REG
    sec
    sbc Y_POS      ; Yc + y
    STA PX
    LDA X_REG + 1
    sbc Y_POS + 1
    sta PX + 1
    rts
rPosX
    LDA X_REG
    clc
    adc Y_POS      ; Yc + y
    STA PX
    LDA X_REG + 1
    adc Y_POS + 1
    sta PX + 1
    rts

rNegY
    LDA Y_REG
    sec
    sbc X_POS      ; Yc + y
    STA PY
    LDA Y_REG + 1
    sbc X_POS + 1
    sta PY + 1

    rts
rPosY
    LDA Y_REG
    clc
    adc X_POS      ; Yc + y
    STA PY
    LDA Y_REG + 1
    adc X_POS + 1
    sta PY + 1

    rts


plotCircle
    jsr plot1
    jsr plot2
    jsr plot3
    jsr plot4
    rts
plot1
    jsr posX
    jsr posY
    jsr PlotPixel
    jsr rPosX
    jsr rPosY
    jsr PlotPixel
    rts

plot2
    jsr posX
    jsr negY
    jsr PlotPixel
    jsr rPosX
    jsr rNegY
    jsr PlotPixel
    rts

plot3
    jsr negX
    jsr posY
    jsr PlotPixel
    jsr rNegX
    jsr rPosY
    jsr PlotPixel
    rts

plot4
    jsr negX
    jsr negY
    jsr PlotPixel
    jsr rNegX
    jsr rNegY
    jsr PlotPixel
    rts
;;;reverse

whileLoop
    lda Y_POS + 1
    cmp X_POS + 1
    beq _checkLo
    bcs _ok
_notOk
    sec
    rts
_checkLo
    lda Y_POS
    cmp X_POS
  ;  beq _notOk
    bcc _notOk
_ok
    clc
    rts
doCircle
    jsr plotCircle
_loop
    jsr whileLoop
    bcc _ok
    rts
_ok
    jsr plotCircle

    lda D+1
    cmp #0
    bmi _negDecision

   lda X_POS
   sec
   sbc Y_POS
   sta TEMP
   lda X_POS + 1
   sbc Y_POS + 1
   sta TEMP + 1

   asl TEMP
   rol TEMP + 1

   lda D
   clc
   adc TEMP
   sta D
   lda D + 1
   adc TEMP + 1
   sta  D + 1

   lda D
   clc
   adc #5
   sta D
   lda D + 1
   adc #0
   sta D + 1

   lda Y_POS
   sec
   sbc #1
   sta Y_POS
   lda Y_POS + 1
   sbc #0
   sta Y_POS + 1


   lda X_POS
   clc
   adc #1
   sta X_POS
   lda X_POS + 1
   adc #0
   sta X_POS + 1
    bra _loop
    rts
_negDecision
    lda X_POS
    sta TEMP
    lda X_POS + 1
    sta TEMP + 1

    asl TEMP
    rol TEMP + 1

    lda D
    clc
    adc TEMP
    sta D
    lda D + 1
    adc TEMP + 1
    sta  D + 1

    lda D
    clc
    adc #3
    sta D
    lda D + 1
    adc #0
    sta D + 1

    lda X_POS
    clc
    adc #1
    sta X_POS
    lda X_POS + 1
    adc #0
    sta X_POS + 1
    jmp _loop
    rts
; Subroutine to plot a pixel at (PX, PY)
PlotPixel:
    ; Implementation depends on graphics mode
    lda PX
    ldx PX + 1
    jsr setOrginX

    lda PY
    ldx PY + 1
    jsr setOrginY
    jsr putPixel
    RTS

X_POS: .BYTE 0,0
Y_POS: .BYTE 0,0
D:     .BYTE 0,0
R:     .BYTE 0,0
PX:    .BYTE 0,0
PY:    .BYTE 0,0
X_REG: .BYTE 0,0
Y_REG: .BYTE 0,0  ; Yc

temp
    .byte $00,$00
reversePlots
    .byte $00,$00

.endnamespace