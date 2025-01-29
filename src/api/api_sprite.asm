.section code
;------------------
;input a register
;set the appropiate 
;sprite pointer
;------------------
setSpriteNumber
    phx
    phy
    asl a
    tax
    lda mSpriteAttrAddr,x
    sta POINTER_SPR
    inx
    lda mSpriteAttrAddr,x
    sta POINTER_SPR + 1
    ply
    plx
    rts

;------------------
;input a,x,y register
;a = low
;x = mid
;y = hi
;set address of sprite
;------------------
setSpriteAddress
    phy 
    ldy #1
    sta (POINTER_SPR), y
    ldy #2
    txa
    sta (POINTER_SPR), y
    ply
    tya
    ldy #3
    sta (POINTER_SPR), y
    rts

;------------------
;input a,x register
;a = low
;x = hi
;y = hi
;set x addr of sprite
;------------------
setSpriteX
    ldy #4
    sta (POINTER_SPR), y
    ldy #5
    txa
    sta (POINTER_SPR), y
    rts
;------------------
;input a,x register
;a = low
;x = hi
;set y addr of sprite
;------------------
setSpriteY
    ldy #6
    sta (POINTER_SPR), y
    ldy #7
    txa
    sta (POINTER_SPR), y
    rts

showSprite
    lda #SPRITE16L0C0
    sta (POINTER_SPR)
    rts

hideSprite
    lda #0
    sta (POINTER_SPR)
    rts


; hideAllSprites
;     ldx #60
;     lda #60
;     sta mSpriteTracker
; _loop
;     cpx #0
;     beq _end
;     lda mSpriteTracker
;     jsr setSpriteNumber
;     lda #0
;     jsr showSprite
;     dec mSpriteTracker
;     dex
;     bra _loop
; _end
;     rts

hideAllSprites
    lda #0
    sta mSpriteTracker
    ldx #0
_loop
    lda mSpriteTracker
    jsr setSpriteNumber
    jsr hideSprite
    inc mSpriteTracker
    lda mSpriteTracker
    cmp #64
    bne _loop
    rts
.endsection
.section variables
;_ |size |layer |lut| enable
;1 |  2  |  2   |2  |  1
SPRITE16L0C0 = %01000001
SPRITE16L0C1 = %01000011
SPRITE16L1C1 = %01001011
SPRITE16L2C1 = %01011011
SPRITE24L0C2 = %00100101
SPRITE24L1C2 = %00101101
mSpriteTracker
    .byte $00
mSpriteAttrAddr
    .word $D900
    .word $D908
    .word $D910
    .word $D918
    .word $D920
    .word $D928
    .word $D930
    .word $D938
    .word $D940
    .word $D948
    .word $D950
    .word $D958
    .word $D960
    .word $D968
    .word $D970
    .word $D978
    .word $D980
    .word $D988
    .word $D990
    .word $D998
    .word $D9A0
    .word $D9A8
    .word $D9B0
    .word $D9B8
    .word $D9C0
    .word $D9C8
    .word $D9D0
    .word $D9D8
    .word $D9E0
    .word $D9E8
    .word $D9F0
    .word $D9F8
    .word $DA00
    .word $DA08
    .word $DA10
    .word $DA18
    .word $DA20
    .word $DA28
    .word $DA30
    .word $DA38
    .word $DA40
    .word $DA48
    .word $DA50
    .word $DA58
    .word $DA60
    .word $DA68
    .word $DA70
    .word $DA78
    .word $DA80
    .word $DA88
    .word $DA90
    .word $DA98
    .word $DAA0
    .word $DAA8
    .word $DAB0
    .word $DAB8
    .word $DAC0
    .word $DAC8
    .word $DAD0
    .word $DAD8
    .word $DAE0
    .word $DAE8
    .word $DAF0
    .word $DAF8

.endsection