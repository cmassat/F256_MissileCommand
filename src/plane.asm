plane .namespace
.section code
init
    lda #0
    sta planeActve
    sta mWait
    jsr reset
    stz  mSpeedTracker
    stz  mSpeedTracker + 1

    lda #$70
    ldx #1
    jsr setSpeed
    rts

reset
    lda #SPRITENUMBER_PLANE
    jsr setSpriteNumber
    jsr hideSprite
    lda #0
    ldx #0
    jsr setSpriteX
    jsr setSpriteY
    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber
    jsr hideSprite
    lda #0
    ldx #0
    jsr setSpriteX
    jsr setSpriteY

    lda #inactive
    sta planeActve

    lda #120
    sta mDelayLaunch
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

    lda mDelayLaunch
    cmp #0
    beq _skip
    dec mDelayLaunch
_skip
    jsr draw
    jsr collision.planeAbm
    ply
    plx
    pla
    rts

draw
    lda planeActve
    cmp #active
    beq _movePLane
    jsr activate
    rts
_movePLane
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
    lda #SPRITENUMBER_PLANE
    jsr setSpriteNumber

    jsr setLineData
    jsr linestep
    jsr saveLineData

    lda #SPRITENUMBER_PLANE
    jsr setSpriteNumber
    jsr getOriginX
    clc
    adc #32
    pha
    txa
    adc #0
    tax
    pla
    jsr setSpriteX
    jsr getOriginX
    sta currX
    stx currX + 1

    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber
    jsr getOriginX
    clc
    adc #46
    pha
    txa
    adc #0
    tax
    pla
    jsr setSpriteX

    lda #SPRITENUMBER_PLANE
    jsr setSpriteNumber
    jsr getOriginY
    clc
    adc #32
    ldx #0
    jsr setSpriteY
    jsr getOriginY
    sta currY
    stx currY + 1

    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber
    jsr getOriginY
    clc
    adc #32
    ldx #0
    jsr setSpriteY
    jsr outOfBounds
    rts

outOfBounds
    jsr rightOutOfBounds
    jsr leftOutOfBounds
    rts

rightOutOfBounds
    lda planeDirection
    cmp #right
    beq _check
    rts
_check
    lda currX + 1
    cmp #1
    bcs _checkLo
    rts
_checkLo
    lda currX
    cmp #<320 + 16
    bcs _deactivate
    rts
_deactivate

    jsr reset
    rts

leftOutOfBounds
    lda planeDirection
    cmp #left
    beq _check
    rts
_check
    lda currX + 1
    cmp #0
    beq _checkLo
    rts
_checkLo
    lda currX
    cmp #16
    bcc _deactivate
    rts
_deactivate
    jsr reset
    rts

activate
    lda mDelayLaunch
    cmp #0
    beq _activate
    rts
_activate
    jsr setupRandomPath
    jsr lineInit
    jsr linestep
    jsr saveLineData
    jsr getOriginX
    sta currX
    stx currX + 1

    jsr getOriginY
    sta currY
    stx currY + 1

    lda #SPRITENUMBER_PLANE
    jsr setSpriteNumber
    jsr showSprite
    lda #active
    sta planeActve
    rts

setupRandomPath
     jsr pickDirection
     lda planeDirection
     cmp #right
     beq rightPath
     jsr leftPath
    jsr leftPath
    rts

rightPath
    lda #0
    ldx #00
    jsr setOrginX
    sta origX
    stx origX + 1

    jsr generateOriginY
    lda origY
    ldx origY + 1
    jsr setOrginY

    lda <#352
    ldx >#352
    jsr setDestX
    sta destX
    stx destX + 1

    lda origY
    ldx origY + 1
    jsr setDestY
    sta destY
    stx destY + 1

    lda #SPRITENUMBER_PLANE
    jsr setSpriteNumber
    lda #<SPRITE_PLANE1
    ldx #>SPRITE_PLANE1
    ldy #`SPRITE_PLANE1
    jsr setSpriteAddress
    jsr showSprite

    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber
    lda #<SPRITE_PLANE2
    ldx #>SPRITE_PLANE2
    ldy #`SPRITE_PLANE2
    jsr setSpriteAddress
    jsr showSprite
    rts

leftPath
    lda #<352
    ldx #>352
    jsr setOrginX
    sta origX
    stx origX + 1
    jsr generateOriginY
    lda origY
    ldx origY + 1
    jsr setOrginY

    lda <#32
    ldx >#32
    jsr setDestX
    sta destX
    stx destX + 1

    lda origY
    ldx origY + 1
    jsr setDestY
    sta destY
    stx destY + 1

    lda #SPRITENUMBER_PLANE
    jsr setSpriteNumber
    lda #<SPRITE_PLANE3
    ldx #>SPRITE_PLANE3
    ldy #`SPRITE_PLANE3
    jsr setSpriteAddress
     jsr showSprite

    lda #SPRITENUMBER_PLANE2
    jsr setSpriteNumber
    lda #<SPRITE_PLANE4
    ldx #>SPRITE_PLANE4
    ldy #`SPRITE_PLANE4
    jsr setSpriteAddress
    jsr showSprite

    rts

pickDirection
    jsr getRandom
    cmp #127
    bcc _left
    lda #right
    sta planeDirection
    rts
_left
    lda #left
    sta planeDirection
    rts


generateOriginY
_tryAgain
    jsr getRandom
    asl
    sta r_seed
    jsr getRandom
    sta origY
    stz origY + 1
    lda origY
    cmp #150
    bcs _tryAgain
    cmp #80
    bcc _tryAgain
    lda r_seed
    asl
    sta r_seed
    rts

moveMissle
    lda mMissleActive
    cmp #1
    beq _move
    jsr initMissleData
    rts
_move
    jsr setLineDataMissle
    jsr linestep
    jsr saveLineDataMissle
    lda #MISSLE_CLR
    jsr setPixelColor
    jsr putPixel
    jsr linestep
    jsr getPixel
    cmp #EXPLOSION_CLR
    beq _explode
    lda #ICBM_HEAD
    jsr setPixelColor
    jsr putPixel
    jsr saveLineData
    rts
_explode
    lda #$25
    jsr score.addScore
    jsr psg.playExplosion
    stz mPlaneMissleData

    lda mMissleSourceX
    ldx mMissleSourceX + 1
    jsr setOrginX

    lda mMissleSourceY
    ldx mMissleSourceY + 1
    jsr setOrginY

    lda mMissleDestX
    ldx mMissleDestX + 1
    jsr setDestX

    lda mMissleDestY
    ldx mMissleDestY + 1
    jsr setDestY
    rts

initMissleData
    lda planeActve
    cmp #1
    beq _okToActivate
    rts
_okToActivate
    lda currX
    cmp #30
    bcs _checkActive
    rts
_checkActive
    lda mMissleActive
    cmp #0
    beq _activate
    rts
_activate
    lda #1
    sta mMissleActive
    jsr getX
    jsr setOrginX
    sta mMissleSourceX
    stx mMissleSourceX + 1

    jsr getY
    jsr setOrginY
    sta mMissleSourceY
    stx mMissleSourceY + 1

    jsr generateRandomX
    lda mMissleDestX
    ldx mMissleDestX + 1
    jsr setDestX

    lda #240
    sta mMissleDestY
    lda #0
    sta mMissleDestY + 1

    lda mMissleDestY
    ldx mMissleDestY + 1
    jsr setDestY

    jsr lineInit
    jsr linestep
    jsr saveLineDataMissle
    rts

getX
    lda currX
    ldx currX + 1
    rts

getY
    lda currY
    ldx currY + 1
    rts


generateRandomX
_tryAgain
    jsr getRandom
    sta mMissleDestX
    jsr getRandom
    sta mMissleDestX + 1
_checkOver320
    lda mMissleDestX + 1
    cmp >#319
    beq _checkLo
    bcs _tryAgain
    bra _returnValues
    rts
_checkLo
    lda mMissleDestX
    cmp <#319
    bcs _tryAgain
    lda r_seed
    asl r_seed
    sta r_seed
    bra _returnValues
    rts
_returnValues
    jsr _checkMinX
_returnOk
    lda mMissleDestX
    ldx mMissleDestX + 1
    rts
_checkMinX
    lda mMissleDestX + 1
    cmp #1
    bcc _checkLoMin
    bra _returnOk
    rts
_checkLoMin
    lda mMissleDestX
    cmp #80 - 32
    bcc _tryAgain
    bra _returnOk
    rts

saveLineData
    phy
    phx
    pha
    ldy #0
_loop
    lda mLineData,y
    sta mPlanePathData,y
    iny
    cpy #pathDataLength
    bne _loop
    pla
    plx
    ply
    rts

saveLineDataMissle
    phy
    phx
    pha
    ldy #0
_loop
    lda mLineData,y
    sta mPlaneMissleData,y
    iny
    cpy #pathDataLength
    bne _loop
    pla
    plx
    ply
    rts

setLineDataMissle
    phy
    phx
    pha
    ldy #0
_loop
    lda mPlaneMissleData,y
    sta mLineData,y
    iny
    cpy #pathDataLength
    bne _loop
    pla
    plx
    ply
    rts

setLineData
    phy
    phx
    pha
    ldy #0
_loop
    lda mPlanePathData,y
    sta mLineData,y
    iny
    cpy #pathDataLength
    bne _loop
    pla
    plx
    ply
    rts

setSpeed
    sta mSpeed
    stx mSpeed + 1

    stz mSpeedTracker
    stz mSpeedTracker + 1
    rts
.endsection
.section variables
right = 0
left = 1
inactive = 0
active = 1
mPlaneDataLength
waitFrames = 120
wave0 = 2
wave1 = 5
pathDataLength = mPlanePathDataEnd - mPlanePathData
mPlanePathData
 .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
 .word $0  ; ZU - "dlugosc" y A
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
; mDWeight
;     .byte $00
mPlanePathDataEnd



planeActve
    .byte $00
planeDirection
    .byte $00
planeFrame .byte $0
origX .byte $00, $00
origY .byte $00, $00
destX .byte $00, $00
destY .byte $00, $00
currX
    .byte $00, $00
currY
    .byte $00, $00

spiteCalc
    .byte $00, $00
mWait
    .byte $0

mSpeed
    .byte $00, $00
mSpeedTracker
    .byte $00, $00
mDelayLaunch
    .byte $00

mMissleActive
    .byte $0
mMissleSourceX
    .byte $00, $00
mMissleSourceY
    .byte $00 ,$00
mMissleDestX
    .byte $00, $00
mMissleDestY
    .byte $00, $00
mPlaneMissleData
 .word $0 ; ZU - "dlugosc" x (rozpietosc na osi)
 .word $0  ; ZU - "dlugosc" y A
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
; mDWeight
;     .byte $00
mPlaneMissleDataEnd
.endsection
.endnamespace