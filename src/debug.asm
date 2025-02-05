.section code
debug
    phy
    phx
    pha
    lda #2
    sta MMU_IO_CTRL

    ldy #17
    lda explosion.exp0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    ldy #17
    lda explosion.exp0
    and #$0F
    tay
    lda mHex, y
    sta $C001


    ldy #16
    lda explosion.exp1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

     ldy #16
    lda explosion.exp1
    and #$0F
     tay
    lda mHex, y
    sta $C003
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda mDebug + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80

    lda mDebug + 1
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80


    lda mDebug
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80

    lda  mDebug
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #17
    lda  circle.PY
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80+ 80

     ldx #17
    lda icbm.icbmActve4
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80+ 80


     ldx #16
    lda icbm.icbmActve5
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80+ 80

     ldx #16
    lda icbm.icbmActve5
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80+ 80

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.icbmActve6
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80+ 80+ 80

    lda icbm.icbmActve6
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80+ 80+ 80


    lda icbm.icbmActve7
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80+ 80+ 80

    lda icbm.icbmActve7
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80+ 80+ 80


    pla
    plx
    ply
    stz MMU_IO_CTRL

rts
.endsection

.section variables
mHex
    .text '0123456789ABCDEF'

.endsection