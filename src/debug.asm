.section code
debug
    phy
    phx
    pha
     lda #2
     sta MMU_IO_CTRL


    ; lda mdebug
    ; lsr
    ; lsr
    ; lsr
    ; lsr
    ; tay
    ; lda mHex, y
    ; sta $C000

    ; lda mdebug
    ; and #$0F
    ; tay
    ; lda mHex, y
    ; sta $C001



    ; lda collision.mCityHit0
    ; lsr
    ; lsr
    ; lsr
    ; lsr
    ; tay
    ; lda mHex, y
    ; sta $C002

    ; lda collision.mCityHit0
    ; and #$0F
    ; tay
    ; lda mHex, y
    ; sta $C003
    ; lda mHex, y
    ; sta $C003


    lda cruise.mCruiseStatus0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    lda cruise.mCruiseStatus0
    and #$0F
    tay
    lda mHex, y
    sta $C001


    lda cruise.mCruiseDestY0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

    lda cruise.mCruiseDestY0
    and #$0F
    tay
    lda mHex, y
    sta $C003


    lda mDebug
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005

    lda mDebug
    and #$0F
    tay
    lda mHex, y
    sta $C006

    lda cruise.mCruiseCurrentX0 + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C008

    lda cruise.mCruiseCurrentX0 + 1
    and #$0F
    tay
    lda mHex, y
    sta $C009


    lda cruise.mCruiseCurrentX0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C00a

    lda cruise.mCruiseCurrentX0
    and #$0F
    tay
    lda mHex, y
    sta $C00b


    lda cruise.mCruiseCurrentY0 + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C00c

    lda cruise.mCruiseCurrentY0 + 1
    and #$0F
    tay
    lda mHex, y
    sta $C00d


    lda cruise.mCruiseCurrentY0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C00e

    lda cruise.mCruiseCurrentY0
    and #$0F
    tay
    lda mHex, y
    sta $C00f

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;mTotalLaunch;;;;
;     lda plane.currX + 1
;     lsr
;     lsr
;     lsr
;     lsr
;     tay
;     lda mHex, y
;     sta $C000 + 40

;     lda plane.currX + 1
;     and #$0F
;     tay
;     lda mHex, y
;     sta $C001 + 40


;     lda plane.currX
;     lsr
;     lsr
;     lsr
;     lsr
;     tay
;     lda mHex, y
;     sta $C002 + 40

;     lda plane.currX
;     and #$0F
;     tay
;     lda mHex, y
;     sta $C003 + 40


;     lda plane.destY + 1
;     lsr
;     lsr
;     lsr
;     lsr
;     tay
;     lda mHex, y
;     sta $C005 + 40

;     lda plane.destY + 1
;     and #$0F
;     tay
;     lda mHex, y
;     sta $C006 + 40

;     lda plane.destY
;     lsr
;     lsr
;     lsr
;     lsr
;     tay
;     lda mHex, y
;     sta $C007 + 40

;     lda plane.destY
;     and #$0F
;     tay
;     lda mHex, y
;     sta $C008 + 40
; ;
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