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
    rts

demo
    jsr draw
    rts
play
    pha
    phx
    phy
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
    jsr setSpriteX

    jsr getOriginY
    jsr setSpriteY

    jsr getOriginY
    cmp #0
    beq _reset
    rts
_reset
    lda #inactiveStatus
    sta mCruiseStatus0
    rts

radar
    jsr getOriginY
    clc
    adc #32
    pha
    txa
    adc #0
    tax
    pla
    jsr setOrginY
    jsr getPixel

    cmp #EXPLOSION_CLR
    beq _moveLeft
    rts
_moveLeft
    jsr getOriginX
    sec
    sbc #1
    pha
    txa
    sbc #0
    tax
    pla
    jsr setOrginX

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
  ;  clc
  ;  adc #32
    sta mCruiseStartX0
   lda mrandXStart + 1
  ;  adc #0

    sta mCruiseStartX0 + 1

    lda #16
    sta mCruiseStartY0

    jsr generateDestX
    lda mrandXStart
    ;clc
    ;adc #32
    sta mCruiseDestX0
    lda mrandXStart + 1
    ;adc #0
    sta mCruiseDestX0 + 1

    lda #255
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
setSpeed
    sta mSpeed
    stx mSpeed + 1

    stz mSpeedTracker
    stz mSpeedTracker + 1
    rts
getX
   ; lda mCruiseMissle + 14
  ;  ldx mCruiseMissle + 15
    rts

getY
   ; lda mCruiseMissle + 16
   ; ldx mCruiseMissle + 17
    rts

.endsection
.section variables
inactiveStatus = 0
activeStatus = 1

lineLength = mlineDataEnd - mCruisePathData0
wave0 = 2
wave1 = 5
mCruiseStatus0
    .byte $0
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
waitFrames = 120


mSpeed
    .byte $00, $00
mSpeedTracker
    .byte $00, $00

.endsection
.endnamespace