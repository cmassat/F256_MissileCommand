.section code
debug
    lda #2
    sta MMU_IO_CTRL

    ldy #17
    lda abm.mAbmCount
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    ldy #17
    lda abm.mAbmCount
    and #$0F
    tay
    lda mHex, y
    sta $C001


    ldy #16
    lda abm.mFireDelay
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

     ldy #16
    lda abm.mFireDelay
    and #$0F
     tay
    lda mHex, y
    sta $C003
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.icbmActve2
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80

    lda icbm.icbmActve2
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80


    lda icbm.icbmActve3
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80

    lda icbm.icbmActve3
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #17
    lda icbm.icbmActve4
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


    stz MMU_IO_CTRL

rts
.endsection

.section variables
mHex
    .text '0123456789ABCDEF'

.endsection