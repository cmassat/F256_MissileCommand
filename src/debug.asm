.section code
debug
    phy
    phx
    pha
    lda #2
    sta MMU_IO_CTRL

    ldy #17
    lda mVideoLayerCtrl01
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    ldy #17
    lda mVideoLayerCtrl01
    and #$0F
    tay
    lda mHex, y
    sta $C001


    ldy #16
    lda collision.mCityHit1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

     ldy #16
    lda collision.mCityHit1
    and #$0F
     tay
    lda mHex, y
    sta $C003
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda collision.mCityHit2
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80

    lda collision.mCityHit2
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80


    lda collision.mCityHit3
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80

    lda  collision.mCityHit3
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