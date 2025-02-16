plane .namespace
.section code
init
    lda #0
    sta planeActve
    sta mWait

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

demo
    jsr drawPlane
    rts

draw
    lda (POINTER_ACTIVE)
    cmp #0
    bne _move

    lda #1
    sta (POINTER_ACTIVE)
    jsr setupRandomPath

    jsr getOriginX
    sta (POINTER_SOURCEX)
    txa
    ldy #1
    sta (POINTER_SOURCEX),y

    jsr getOriginY
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

   ; jsr linestep
   ; jsr putPixel


_saveLineData
    ;save line data for later

    ldy #0
_loop
    lda (POINTER_TX),y
    sta (POINTER_PLANE),y
    iny
    cpy mlineDataLength
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
    cpy mlineDataLength
    bne _setLineDatagetPixel

    jsr linestep
    jsr getOriginx
    txa
    cmp #0
    beq _ok
    jsr getOriginx

    cmp #<320 + 32
    bcs _checkHi
    bra _ok
_checkHi
    txa
    cmp #>320 + 32
    bcs _deactivate

_ok
    lda #SPRITENUMBER_PLANE1
    jsr setSpriteNumber

    jsr getOriginX
    jsr setSpriteX
    jsr getOriginY
    jsr setSpriteY
    jsr showSprite

    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber

    jsr getOriginX
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

    jsr getOriginY
    jsr setSpriteY

    jsr showSprite

    jmp _saveLineData
    rts
_deactivate
    jsr deactivate
    rts

deactivate
    lda #0
    sta (POINTER_ACTIVE)
    lda #SPRITENUMBER_PLANE1
    jsr setSpriteNumber
    jsr hideSprite

    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber
    jsr hideSprite

    lda #0
    ldx #0
    jsr setSpriteX
    jsr setSpriteY

    ldy #0
_loop
    lda #0
    sta (POINTER_PLANE),y
    iny
    cpy mlineDataLength
    bne _loop

    lda #0
    sta planeActve
    sta planeFrame
    sta origX
    sta origY
    sta destX
    sta destY

    lda #waitFrames
    sta mWait
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

.endmacro
drawPlane
    phy
    phx
    pha
    lda mWait
    cmp #0
    bne _wait
    #planeMacro mplaneMissle, mLineData, origX, origY, destX, destY, planeActve, planeFrame
    jsr draw
    jsr collision.handlePlane
    bcc _deactivate
    bra _end
_deactivate
    jsr deactivate
    bra _end
_wait
    dec mWait
_end
    pla
    plx
    ply
    rts

getX
    lda mplaneMissle + 14
    ldx mplaneMissle + 15
    rts

getY
    lda mplaneMissle + 16
    ldx mplaneMissle + 17
    rts

setupRandomPath
    lda #1
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

mWait
    .byte $0
waitFrames = 120
wave0 = 2
wave1 = 5

.endsection
.endnamespace