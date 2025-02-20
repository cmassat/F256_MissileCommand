.section code
debug
    phy
    phx
    pha
     lda #2
     sta MMU_IO_CTRL


    lda score.mPtMultiplier
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    lda score.mPtMultiplier
    and #$0F
    tay
    lda mHex, y
    sta $C001


    lda score.mPtMultiplier
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

    lda score.mPtMultiplier
    and #$0F
    tay
    lda mHex, y
    sta $C003




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;mTotalLaunch;;;;
;   lda waves.mCurrentWave
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C005
;
;   lda waves.mCurrentWave
;   and #$0F
;    tay
;   lda mHex, y
;   sta $C006
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;mTotalLaunch;;;;
;   ldx icbm.offsetCurrentY
;   lda icbm.mTotalLaunch
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C000 + 80
;
;   lda icbm.mTotalLaunch
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C001 + 80
;
;
;   lda icbm.mMaxLaunch
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C002 + 80
;
;   lda icbm.mMaxLaunch
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C003 + 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   lda icbm.mIcbmStatus0
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C005 + 80
;
;   lda icbm.mIcbmStatus0
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C006 + 80
;
;   lda icbm.mIcbmStatus1
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C007 + 80
;
;   lda icbm.mIcbmStatus1
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C008 + 80
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   lda icbm.mIcbmStatus2
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C000 + 80 + 40
;
;   lda icbm.mIcbmStatus2
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C001 + 80 + 40
;
;
;   lda icbm.mIcbmStatus3
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C002 + 80 + 40
;
;   lda icbm.mIcbmStatus3
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C003 + 80 + 40
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   lda icbm.mIcbmStatus4
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C005 + 80 + 40
;
;   lda icbm.mIcbmStatus4
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C006 + 80 + 40
;
;
;   lda icbm.mIcbmStatus5
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C007 + 80 + 40
;
;   lda icbm.mIcbmStatus5
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C008 + 80 + 40
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   lda icbm.mIcbmStatus6
;   lsr
;   lsr
;   lsr
;   lsr
;   tay
;   lda mHex, y
;   sta $C000 + 80 + (40 * 2)
;
;   lda icbm.mIcbmStatus6
;   and #$0F
;   tay
;   lda mHex, y
;   sta $C001 + 80 + (40 * 2)
;
;
;    lda icbm.mIcbmStatus7
;    lsr
;    lsr
;    lsr
;    lsr
;    tay
;    lda mHex, y
;    sta $C002 + 80 + (40 * 2)
;
;    lda icbm.mIcbmStatus7
;    and #$0F
;    tay
;    lda mHex, y
;    sta $C003 + 80 + (40 * 2)
;
;    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    lda icbm.mIcbmStatus5
;    lsr
;    lsr
;    lsr
;    lsr
;    tay
;    lda mHex, y
;    sta $C005 + 80 + (40 * 2)
;
;    lda icbm.mIcbmStatus5
;    and #$0F
;    tay
;    lda mHex, y
;    sta $C006 + 80 + (40 * 2)
;
;
;    lda icbm.mIcbmStatus5, x
;    lsr
;    lsr
;    lsr
;    lsr
;    tay
;    lda mHex, y
;    sta $C007 + 80 + (40 * 2)
;
;    lda icbm.mIcbmStatus5, x
;    and #$0F
;    tay
;    lda mHex, y
;    sta $C008 + 80 + (40 * 2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    lda icbm.mIcbmStatus6
;    lsr
;    lsr
;    lsr
;    lsr
;    tay
;    lda mHex, y
;    sta $C000 + 80 + (40 * 3)
;
;    lda icbm.mIcbmStatus6
;    and #$0F
;    tay
;    lda mHex, y
;    sta $C001 + 80 + (40 * 3)
;
;
;    lda icbm.mIcbmStatus6, x
;    lsr
;    lsr
;    lsr
;    lsr
;    tay
;    lda mHex, y
;    sta $C002 + 80 + (40 * 3)
;
;    lda icbm.mIcbmStatus6, x
;    and #$0F
;    tay
;    lda mHex, y
;    sta $C003 + 80 + (40 * 3)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    lda icbm.mIcbmStatus7
;    lsr
;    lsr
;    lsr
;    lsr
;    tay
;    lda mHex, y
;    sta $C005 + 80 + (40 * 3)
;
;    lda icbm.mIcbmStatus7
;    and #$0F
;    tay
;    lda mHex, y
;    sta $C006 + 80 + (40 * 3)
;
;
;    lda icbm.mIcbmStatus7, x
;    lsr
;    lsr
;    lsr
;    lsr
;    tay
;    lda mHex, y
;    sta $C007 + 80 + (40 * 3)
;
;    lda icbm.mIcbmStatus7, x
;    and #$0F
;    tay
;    lda mHex, y
;    sta $C008 + 80 + (40 * 3)
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