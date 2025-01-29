.section code
debug
    lda #2
    sta MMU_IO_CTRL

    ldy #16
    lda icbm.origX1 + 1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C000

    ldy #16
    lda icbm.origX1 + 1
    and #$0F
    tay
    lda mHex, y
    sta $C001


    ldy #16
    lda icbm.origX1
    lsr
    lsr
    lsr
    lsr
    tay
    lda mHex, y
    sta $C002

    ldy #16
    lda icbm.origX1
    and #$0F
     tay
    lda mHex, y
    sta $C003

    ; ldy #15
    ; lda wave1.icbm0, y
    ; lsr
    ; lsr
    ; lsr
    ; lsr
    ; tay
    ; lda mHex, y
    ; sta $C005

    ; ldy #15
    ; lda wave1.icbm0, y
    ; and #$0F
    ; tay
    ; lda mHex, y
    ; sta $C006


    ; ldy #14
    ; lda wave1.icbm0, y
    ; lsr
    ; lsr
    ; lsr
    ; lsr
    ; tay
    ; lda mHex, y
    ; sta $C007

    ; ldy #14
    ; lda wave1.icbm0, y
    ; and #$0F
    ;  tay
    ; lda mHex, y
    ; sta $C008


    ; lda wave1.icbm0
    ; lsr
    ; lsr
    ; lsr
    ; lsr
    ; tay
    ; lda mHex, y
    ; sta $C009


    ; lda wave1.icbm0
    ; and #$0F
    ;  tay
    ; lda mHex, y
    ; sta $C00a

    stz MMU_IO_CTRL

rts
.endsection

.section variables
mHex
    .text '0123456789ABCDEF'
.endsection