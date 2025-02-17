.section code
debug
    phy
    phx
    pha
     lda #2
     sta MMU_IO_CTRL


    lda mDebug
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    lda mDebug
    and #$0F
    tay
    lda mHex, y
    sta $C001


    lda icbm.mOkToMove
    and #$0F
     tay
    lda mHex, y
    sta $C002

     lda icbm.mOkToMove
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C003


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;mTotalLaunch;;;;
    lda icbm.mLaunchCount
    and #$0F
     tay
    lda mHex, y
    sta $C005

     lda icbm.mLaunchCount
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C006
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;mTotalLaunch;;;;
    ldx #icbm.offsetCurrentY
    lda icbm.mIcbmStatus0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80

    lda icbm.mIcbmStatus0
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80


    lda icbm.mIcbmStatus0, x
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80

    lda icbm.mIcbmStatus0, x
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmStatus1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005 + 80

    lda icbm.mIcbmStatus1
    and #$0F
    tay
    lda mHex, y
    sta $C006 + 80

    lda icbm.mIcbmStatus1, x
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007 + 80

    lda icbm.mIcbmStatus1, x
    and #$0F
    tay
    lda mHex, y
    sta $C008 + 80

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmStatus2
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80 + 40

    lda icbm.mIcbmStatus2
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80 + 40


    lda icbm.mIcbmStatus2, x
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80 + 40

    lda icbm.mIcbmStatus2, x
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80 + 40

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmStatus3
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005 + 80 + 40

    lda icbm.mIcbmStatus3
    and #$0F
    tay
    lda mHex, y
    sta $C006 + 80 + 40


    lda icbm.mIcbmStatus3, x
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007 + 80 + 40

    lda icbm.mIcbmStatus3, x
    and #$0F
    tay
    lda mHex, y
    sta $C008 + 80 + 40

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmStatus4
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80 + (40 * 2)

    lda icbm.mIcbmStatus4
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80 + (40 * 2)


    lda icbm.mIcbmStatus4, x
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80 + (40 * 2)

    lda icbm.mIcbmStatus4, x
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80 + (40 * 2)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmStatus5
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005 + 80 + (40 * 2)

    lda icbm.mIcbmStatus5
    and #$0F
    tay
    lda mHex, y
    sta $C006 + 80 + (40 * 2)


    lda icbm.mIcbmStatus5, x
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007 + 80 + (40 * 2)

    lda icbm.mIcbmStatus5, x
    and #$0F
    tay
    lda mHex, y
    sta $C008 + 80 + (40 * 2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmStatus6
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80 + (40 * 3)

    lda icbm.mIcbmStatus6
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80 + (40 * 3)


    lda icbm.mIcbmStatus6, x
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80 + (40 * 3)

    lda icbm.mIcbmStatus6, x
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80 + (40 * 3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmStatus7
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005 + 80 + (40 * 3)

    lda icbm.mIcbmStatus7
    and #$0F
    tay
    lda mHex, y
    sta $C006 + 80 + (40 * 3)


    lda icbm.mIcbmStatus7, x
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007 + 80 + (40 * 3)

    lda icbm.mIcbmStatus7, x
    and #$0F
    tay
    lda mHex, y
    sta $C008 + 80 + (40 * 3)
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