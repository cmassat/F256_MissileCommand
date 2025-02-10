.section code
debug
    phy
    phx
    pha
    lda #2
    sta MMU_IO_CTRL

    ldy #17
    lda explosion.mFrame
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    ldy #17
    lda explosion.mFrame
    and #$0F
    tay
    lda mHex, y
    sta $C001


    ldy #16
    lda explosion.mActive
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

     ldy #16
    lda explosion.mActive
    and #$0F
     tay
    lda mHex, y
    sta $C003
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda explosion.exp1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80

    lda explosion.exp1
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80


    lda explosion.exp2
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80

    lda  explosion.exp2
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #17
    lda collision.mCityHit4
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80+ 80

     ldx #17
    lda collision.mCityHit4
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80+ 80


     ldx #16
    lda collision.mCityHit5
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80+ 80

     ldx #16
    lda collision.mCityHit5
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