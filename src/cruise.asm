cruise .namespace
.section code
init
    lda #0
    sta cruiseActve

    lda #SPRITENUMBER_CRUISE
    jsr setSpriteNumber

    lda #<SPRITE_CRUISE
    ldx #>SPRITE_CRUISE
    ldy #`SPRITE_CRUISE
    jsr setSpriteAddress
    rts


demo
    jsr drawCruiseMissle
    rts

draw
    lda (POINTER_ACTIVE)
    cmp #0
    bne _move

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

    jsr linestep
   ; jsr putPixel
    lda #1
    sta (POINTER_ACTIVE)

_saveLineData
    ;save line data for later

    ldy #0
_loop
    lda (POINTER_TX),y
    sta (POINTER_CRUISE),y
    iny
    cpy mLineDataLength
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
    lda (POINTER_CRUISE),y
    sta (POINTER_TX),y
    iny
    cpy mlineDataLength
    bne _setLineDatagetPixel

    jsr linestep
    lda #SPRITENUMBER_CRUISE
    jsr setSpriteNumber

    jsr getOriginX
    jsr setSpriteX

    jsr getOriginY
    jsr setSpriteY
    jsr showSprite
    bra _saveLineData
    rts

cruiseMacro .macro
    lda <#\1
    sta POINTER_CRUISE
    lda >#\1
    sta POINTER_CRUISE + 1

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
drawCruiseMissle
     phy
     phx
     pha
     #cruiseMacro mCruiseMissle, mLineData, origX, origY, destX, destY, cruiseActve, cruiseFrame
     jsr draw
     jsr collision.handlecruise
     bcc _deactivate
     jsr isYMax
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

 deactivate
     lda #0
     sta (POINTER_ACTIVE)
     lda #SPRITENUMBER_CRUISE
     jsr setSpriteNumber
     jsr hideSprite
     lda #0
     ldx #0
     jsr setSpriteX
     jsr setSpriteY
     ldy #0
 _loop
     lda #0
     sta (POINTER_CRUISE),y
     iny
     cpy mlineDataLength
     bne _loop
     lda #0
     sta cruiseActve
     sta cruiseFrame
     sta origX
     sta origY
     sta destX
     sta destY
     lda #waitFrames
     sta mWait

     rts
setupRandomPath
    jsr generateOriginX
    lda mrandXStart
    ldx mrandXStart + 1
    jsr setOrginX
    lda <#0
    ldx >#0
    jsr setOrginY

    jsr generateDestX
    lda mrandXStart
    ldx mrandXStart + 1
    jsr setDestX
    lda <#240
    ldx >#240
    jsr setDestY
    rts

isYMax
    jsr getY
    cmp #<240 + 32
    bcs_checkHi
    bcc _no
_checkHi
    cpx #1
    bcs _yes
_no
    sec
    rts
_yes
    clc
    rts

generateOriginX
_tryAgain
    jsr getRandom
    sta mrandXStart
    jsr getRandom
    sta mrandXStart + 1
_checkOver320
    lda mrandXStart + 1
    cmp >#320
    beq _checkLo
    bcs _tryAgain
    rts
_checkLo
    lda mrandXStart
    cmp <#320
    bcs _tryAgain
    lda r_seed
    asl
    sta r_seed
    rts

generateDestX
_tryAgain
    jsr getRandom
    sta mrandXStart
    jsr getRandom
    and #%00000001
    sta mrandXStart + 1
_checkOver320
    lda mrandXStart + 1
    cmp >#300
    beq _checkLo
    bcs _tryAgain
    bcc _checkMin
    rts
_checkLo
    lda mrandXStart
    cmp <#300
    bcs _tryAgain

    cmp #80
    bcc _tryAgain
    lda r_seed
    asl
    sta r_seed
    rts
_checkMin
    lda mrandXStart
    cmp #70
    bcc _tryAgain
    rts

getX
    lda mCruiseMissle + 14
    ldx mCruiseMissle + 15
    rts

getY
    lda mCruiseMissle + 16
    ldx mCruiseMissle + 17
    rts

.endsection
.section variables
mCruiseMissle
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
    .byte $00
cruiseActve .byte $0
cruiseFrame .byte $0
origX .byte $00, $00
origY .byte $00, $00
destX .byte $00, $00
destY .byte $00, $00

mrandXStart
    .byte $00, $00


mWait
    .byte $0
waitFrames = 120
wave0 = 2
wave1 = 5
.endsection
.endnamespace