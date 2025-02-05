handle
    lda #icbm.icbmActve0
    cmp #0
    bne _checkCollision

    rts
_checkCollision
    lda #<icbm.icbm0
    sta POINTER_ICBM
    lda #>icbm.icbm0
    sta POINTER_ICBM + 1

    ldy #14
    lda (POINTER_ICBM) ,y
    sta mcolObjAX
    iny
    lda (POINTER_ICBM) ,y
    sta mcolObjAX + 1
    iny
    lda (POINTER_ICBM) ,y
    sta mcolObjAY
    iny
    lda (POINTER_ICBM) ,y
    sta mcolObjAY + 1

    lda #<icbm.abm0
    sta POINTER_ABM
    lda #>icbm.abm0
    sta POINTER_ABM + 1

    lda #<exp0
    sta POINTER_EXP
    lda #>exp0
    sta POINTER_EXP + 1
    ldy #2
    lda (POINTER_EXP),y
    sta mcolObjBX
    iny
    lda (POINTER_EXP),y
    sta mcolObjBX + 1
    iny
    lda (POINTER_EXP),y
    sta mcolObjBY
    iny
    lda (POINTER_EXP),y
    sta mcolObjBY + 1

    #coollideMacro mcolObjAX, 2, mcolObjBX, 16, mcolObjAY, 2,mcolObjBY, 16
    lda #objectCollided
    sta mPlayerStatus
    lda #objectInactive
    sta mHomingMissleStatus00
    rts

mcolObjAX
    .byte $00, $00
mcolObjAY
    .byte $00, $00

mcolObjBX
    .byte $00, $00
mcolObjBY
    .byte $00, $00