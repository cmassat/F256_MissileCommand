.section code
debug
    phy
    phx
    pha
     lda #2
     sta MMU_IO_CTRL

    ; ldy #17
    ; lda icbm.mMaxLaunch
    ; lsr
    ; lsr
    ; lsr
    ; lsr
    ; tay
    ; lda mHex, y
    ; sta $C000

    ; ldy #17
    ; lda icbm.mMaxLaunch
    ; and #$0F
    ; tay
    ; lda mHex, y
    ; sta $C001


    ; ldy #16
    ; lda icbm.mTotalLaunch
    ; lsr
    ; lsr
    ; lsr
    ; lsr
    ; tay
    ; lda mHex, y
    ; sta $C002

    ;  ldy #16
    ; lda icbm.mTotalLaunch
    ; and #$0F
    ;  tay
    ; lda mHex, y
    ; sta $C003
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;mTotalLaunch;;;;
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


    lda icbm.mIcbmStatus1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80

    lda icbm.mIcbmStatus1
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #17
    lda icbm.mIcbmStartY0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005 + 80

     ldx #17
    lda icbm.mIcbmStartY0
    and #$0F
    tay
    lda mHex, y
    sta $C006 + 80


    ldx #16
    lda icbm.mIcbmStartY0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007 + 80

     ldx #16
    lda icbm.mIcbmStartY0
    and #$0F
    tay
    lda mHex, y
    sta $C008 + 80

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmDestX0 + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000 + 80 + 40

    lda icbm.mIcbmDestX0 + 1
    and #$0F
    tay
    lda mHex, y
    sta $C001 + 80 + 40


    lda icbm.mIcbmDestX0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002 + 80 + 40

    lda icbm.mIcbmDestX0
    and #$0F
    tay
    lda mHex, y
    sta $C003 + 80 + 40

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda icbm.mIcbmDestY0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C005 + 80 + 40

    lda icbm.mIcbmDestY0
    and #$0F
    tay
    lda mHex, y
    sta $C006 + 80 + 40


    lda icbm.mIcbmDestY0
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C007 + 80 + 40

    lda icbm.mIcbmDestY0
    and #$0F
    tay
    lda mHex, y
    sta $C008 + 80 + 40

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