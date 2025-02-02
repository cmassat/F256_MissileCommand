plane .namespace
.section code
init
    lda #0
    sta planeActve

    lda #SPRITENUMBER_PLANE1
    jsr setSpriteNumber

    lda #<SPRITE_PLANE1
    ldx #>SPRITE_PLANE1
    ldy #`SPRITE_PLANE1
    jsr setSpriteAddress


    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber

    lda #<SPRITE_PLANE2
    ldx #>SPRITE_PLANE2
    ldy #`SPRITE_PLANE2
    jsr setSpriteAddress
    rts


draw
    lda (POINTER_ACTIVE)
    cmp #0
    bne _move

    jsr setupRandomPath

    jsr getOrginX
    sta (POINTER_SOURCEX)
    txa
    ldy #1
    sta (POINTER_SOURCEX),y

    jsr getOrginY
    sta (POINTER_SOURCEY)
    txa
    ldy #1
    sta (POINTER_SOURCEY),y

    jsr getDestX
    sta (POINTER_DESTX)
    txa
    ldy #1
    sta (POINTER_DESTX),y

    jsr getDestY
    sta (POINTER_DESTY)
    txa
    ldy #1
    sta (POINTER_DESTY),y

    jsr lineInit

    jsr linestep
   ; jsr putPixel
    lda #1
    sta (POINTER_ACTIVE)

_saveLineData
    ;save line data for later

    ldy #0
_loop
    lda (POINTER_TX),y
    sta (POINTER_PLANE),y
    iny
    cpy lineDataLength
    bne _loop

    rts
_move
    lda (POINTER_FRAME)
    cmp #wave0
    beq _goodFrame
    lda (POINTER_FRAME)
    clc
    adc #1
    sta (POINTER_FRAME)
    rts
_goodFrame
   lda #0
   sta (POINTER_FRAME)

    ldy #0
_setLineDatagetPixel
    lda (POINTER_plane),y
    sta (POINTER_TX),y
    iny
    cpy lineDataLength
    bne _setLineDatagetPixel

    jsr linestep
    jsr getOrginx
    txa
    cmp #0
    beq _ok
    jsr getOrginx
    cmp #$FA
    bcs _deactivte

_ok
    lda #SPRITENUMBER_PLANE1
    jsr setSpriteNumber

    jsr getOrginX
    jsr setSpriteX
    jsr getOrginY
    jsr setSpriteY
    jsr showSprite

    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber

    jsr getOrginX
    sta spiteCalc
    stx spiteCalc + 1
    lda spiteCalc
    clc
    adc #16
    sta spiteCalc
    lda spiteCalc + 1
    adc #0
    sta spiteCalc + 1


    lda spiteCalc
    ldx spiteCalc + 1
    jsr setSpriteX

    jsr getOrginY
    jsr setSpriteY

    jsr showSprite

    jmp _saveLineData
    rts
_deactivte
    lda #0
    sta (POINTER_ACTIVE)
    lda #SPRITENUMBER_PLANE1
    jsr setSpriteNumber
    jsr hideSprite

    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber
    jsr hideSprite
    rts

planeMacro .macro
    lda <#\1
    sta POINTER_plane
    lda >#\1
    sta POINTER_plane + 1

    lda <#\2
    sta POINTER_TX
    lda >#\2
    sta POINTER_TX + 1

    lda #<\3
    sta POINTER_SOURCEX
    lda #>\3
    sta POINTER_SOURCEX + 1

    lda #<\4
    sta POINTER_SOURCEY
    lda #>\4
    sta POINTER_SOURCEY + 1

    lda #<\5
    sta POINTER_DESTX
    lda #>\5
    sta POINTER_DESTX + 1

    lda #<\6
    sta POINTER_DESTY
    lda #>\6
    sta POINTER_DESTY + 1

    lda #<\7
    sta POINTER_ACTIVE
    lda #>\7
    sta POINTER_ACTIVE + 1

    lda #<\8
    sta POINTER_FRAME
    lda #>\8
    sta POINTER_FRAME + 1
    jsr draw
.endmacro
drawPlane
    phy
    phx
    pha
    #planeMacro mplaneMissle, mLineData, origX, origY, destX, destY, planeActve, planeFrame
    pla
    plx
    ply
    rts

setupRandomPath
    lda #32
    ldx #00
    jsr setOrginX
    jsr generateOriginY
    lda mrandYStart
    ldx mrandYStart + 1
    jsr setOrginY

    lda <#352
    ldx >#352
    jsr setDestX
    lda mrandYStart
    ldx mrandYStart + 1
    jsr setDestY

    rts


generateOriginY
_tryAgain
    jsr getRandom
    sta mrandYStart
    lda mrandYStart
    cmp #200
    bcs _tryAgain
    cmp #80
    bcc _tryAgain
    lda r_seed
    asl
    sta r_seed
    rts

.endsection
.section variables
mplaneMissle
    .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
    .word $0  ; ZU - "dlugosc" y
    .word $0  ; U2 xi,yi - kierunek rysowania w osi x , y
    .word $0  ; U2
    .word $0 ; U2 step
    .word $0 ; U2 step
    .word $0 ; U2 'error'
    ;poin.byte $0 ;
    .word $0 ; ZU poczatek linii
    .word $0 ; ZU
    .word $0 ; ZU koniec linii
    .word $0 ; ZU
    .byte $0
    .byte $00
    .byte $00
planeActve .byte $0
planeFrame .byte $0
origX .byte $00, $00
origY .byte $00, $00
destX .byte $00, $00
destY .byte $00, $00

spiteCalc
    .byte $00, $00
mrandYStart
    .byte $00, $00
wave0 = 2
wave1 = 5
.endsection
.endnamespace