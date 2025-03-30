cruise .namespace
.section code
init

    stz  mSpeedTracker
    stz  mSpeedTracker + 1

    lda #SPRITENUMBER_CRUISE
    jsr setSpriteNumber

    lda #<SPRITE_CRUISE
    ldx #>SPRITE_CRUISE
    ldy #`SPRITE_CRUISE
    jsr setSpriteAddress
    jsr reset

    lda #$70
    ldx #1
    jsr setSpeed
    rts

reset
    lda #inactiveStatus
    sta mCruiseStatus0

    lda #SPRITENUMBER_CRUISE
    jsr setSpriteNumber
    jsr hideSprite

    lda #0
    ldx #0
    jsr setSpriteX
    jsr setSpriteY

    rts

demo
    pha
    phx
    phy
    jsr draw
    ply
    plx
    pla
    rts
play
    pha
    phx
    phy
    jsr collision.handlecruise
    jsr draw
    ply
    plx
    pla
    rts

draw
    jsr initCruise
    jsr moveCruise
   rts

moveCruise
    lda mCruiseStatus0
    cmp #activeStatus
    beq _move
    rts
_move
    lda mSpeedTracker + 1
    cmp mSpeed + 1
    bne _continue
    stz mSpeedTracker + 1
_continue
    lda mSpeedTracker
    clc
    adc mSpeed
    sta mSpeedTracker
    lda mSpeedTracker + 1
    adc #0
    sta mSpeedTracker + 1

    lda mSpeedTracker + 1
    cmp #1
    bcs _move1
    rts
_move1
    jsr radar
    jsr setLineData
    jsr linestep
    jsr saveLineData
    lda #SPRITENUMBER_CRUISE
    jsr setSpriteNumber
    jsr getOriginX
    clc
    adc #24
    pha
    txa
    adc #0
    tax
    pla
    jsr setSpriteX
    jsr getOriginX
    sta mCruiseCurrentX0
    stx mCruiseCurrentX0 + 1

    jsr getOriginY
    clc
    adc #24
    ldx #0
    jsr setSpriteY


    jsr getOriginY
    sta mCruiseCurrentY0
    stx mCruiseCurrentY0 + 1
    jsr getOriginY
    sta mDebug
    jsr getOriginY
    cmp #$e5
    bcs _reset
    rts
_reset
    lda #0
    sta mCruiseStatus0
    jsr reset
    rts

radar
    jsr setLineData
    jsr getOriginY
    clc
    adc #16
    pha
    txa
    adc #0
    tax
    pla
    jsr setOrginY
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _moveLeft

    jsr getOriginX
    clc
    adc #8
    pha
    txa
    adc #0
    tax
    pla
    jsr setOrginX
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _moveLeft
    rts
_moveLeft
    jsr setLineData
    jsr getOriginX
    sec
    sbc #2
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX

    jsr getOriginY
    sec
    sbc #2
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginY

    jsr lineInit
    jsr linestep
    jsr saveLineData
    rts

setLineData
    phy
    phx
    pha
    ldy #0
_loop
    lda mCruisePathData0,y
    sta mLineData,y
    iny
    cpy #$19
    bne _loop
    pla
    plx
    ply
    rts

saveLineData
     phy
    phx
    pha
    ldy #0
_loop
    lda mLineData,y
    sta  mCruisePathData0,y
    iny
    cpy #$19
    bne _loop
     pla
    plx
    ply
    rts


initCruise
    lda mCruiseStatus0
    cmp #inactiveStatus
    beq _activate
    rts
_activate
    lda #activeStatus
    sta mCruiseStatus0

    jsr generateOriginX
    lda mrandXStart
    sta mCruiseStartX0

    lda mrandXStart + 1
    sta mCruiseStartX0 + 1

    lda #0
    sta mCruiseStartY0

    jsr generateDestX
    lda mrandXStart
    sta mCruiseDestX0

    lda mrandXStart + 1
    sta mCruiseDestX0 + 1

    lda #240
    sta mCruiseDestY0


    lda mCruiseStartX0
    ldx mCruiseStartX0 + 1
    jsr setOrginX

    lda mCruiseStartY0
    ldx #0
    jsr setOrginY

    lda mCruiseDestX0
    ldx mCruiseDestX0 + 1
    jsr setDestX

    lda mCruiseDestY0
    ldx #0
    jsr setDestY

    jsr lineInit
    jsr linestep

    jsr saveLineData
    lda #SPRITENUMBER_CRUISE
    jsr setSpriteNumber
    jsr showSprite
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
    cmp #1
    beq _checkLo
    bcs _tryAgain
    bcc _checkMin
    rts
_checkLo
    lda mrandXStart
    cmp <#300
    bcs _tryAgain

    lda r_seed
    asl
    sta r_seed
    rts
_checkMin
    lda mrandXStart
    cmp #20
    bcc _tryAgain
    rts

setSpeed
    sta mSpeed
    stx mSpeed + 1

    stz mSpeedTracker
    stz mSpeedTracker + 1
    rts

getX
    lda mCruiseCurrentX0
    ldx mCruiseCurrentX0 + 1
    rts

getY
    lda mCruiseCurrentY0
    ldx mCruiseCurrentY0 + 1
    rts

.endsection
.section variables
inactiveStatus = 0
activeStatus = 1
waitFrames = 120
lineLength = mlineDataEnd - mCruisePathData0
wave0 = 2
wave1 = 5
dataLength = dataEnd - dataStart

dataStart
mCruiseStatus0
    .byte $0
mCruiseCurrentX0
    .byte $00, $00
mCruiseCurrentY0
    .byte $00
mCruiseStartX0
    .byte $00, $00
mCruiseStartY0
    .byte $00
mCruiseDestX0
    .byte $00, $00
mCruiseDestY0
    .byte $00
mCruisePathData0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
    .word $0
cruisexpos
    .word $0
cruiseypos
    .word $0
    .word $0
    .word $0
    .byte $0
    .byte $00
    .byte $00
mlineDataEnd
mrandXStart
    .byte $00, $00
mWait
    .byte $0
mSpeed
    .byte $00, $00
mSpeedTracker
    .byte $00, $00
dataEnd
.endsection
.endnamespace