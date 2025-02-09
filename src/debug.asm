.section code
debug
    phy
    phx
    pha
    lda #2
    sta MMU_IO_CTRL

    ldy #17
    lda icbm.mSpeedTracker + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    ldy #17
    lda icbm.mSpeedTracker + 1
    and #$0F
    tay
    lda mHex, y
    sta $C001


    ldy #16
    lda icbm.mSpeedTracker
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

     ldy #16
    lda icbm.mSpeedTracker
    and #$0F
     tay
    lda mHex, y
    sta $C003
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda explosion.exp2
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80

    lda explosion.exp2
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80


    lda explosion.exp3
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80

    lda  explosion.exp3
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #17
    lda explosion.exp4
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80+ 80

     ldx #17
    lda explosion.exp4
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80+ 80


     ldx #16
    lda explosion.exp5
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80+ 80

     ldx #16
    lda explosion.exp5
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80+ 80

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda explosion.exp6
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80+ 80+ 80

    lda explosion.exp6
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80+ 80+ 80


    lda explosion.exp7
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80+ 80+ 80

    lda explosion.exp7
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