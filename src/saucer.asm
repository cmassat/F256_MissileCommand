saucer .namespace
.section code
init
    lda #0
    sta saucerActve
    sta mWait
    jsr reset
    lda #$70
    ldx #1
    jsr setSpeed
    rts

reset
    lda #SPRITENUMBER_SAUCER
    jsr setSpriteNumber
    jsr hideSprite
    lda #0
    ldx #0
    jsr setSpriteX
    jsr setSpriteY
     lda #inactive
    sta saucerActve

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
    jsr collision.handlesaucer
    jsr draw
    ply
    plx
    pla
    rts

draw
    lda mDelayLaunch
    cmp #0
    beq _skip
    dec mDelayLaunch
_skip
    lda saucerActve
    cmp #active
    beq _move
    jsr activate
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
    lda #SPRITENUMBER_SAUCER
    jsr setSpriteNumber

    jsr setLineData
    jsr linestep
    jsr saveLineData

    lda #SPRITENUMBER_SAUCER
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
    sta currX
    stx currX + 1

    lda #SPRITENUMBER_SAUCER
    jsr setSpriteNumber
    jsr getOriginY
    clc
    adc #24
    ldx #0
    jsr setSpriteY
    jsr getOriginY
    sta currY
    stx currY + 1

    jsr outOfBounds
    rts

outOfBounds
    jsr rightOutOfBounds
    jsr leftOutOfBounds
    rts

rightOutOfBounds
    lda saucerDirection
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
    cmp #<320 + 24
    bcs _deactivate
    rts
_deactivate
    jsr reset
    rts

leftOutOfBounds
    lda saucerDirection
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
    lda #inactive
    sta saucerActve
    jsr reset
    rts

activate
    jsr plane.getX
    cmp #50
    bcs _checkUpper
    rts
_checkUpper
    jsr plane.getX
    txa
    cmp #1
    bne _ok
    jsr plane.getX
    cmp #10
    bcc _ok
    rts
_ok
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

    lda #SPRITENUMBER_SAUCER
    jsr setSpriteNumber
    jsr showSprite
    lda #active
    sta saucerActve
    rts

setupRandomPath
     jsr pickDirection
     lda saucerDirection
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

    lda #SPRITENUMBER_SAUCER
    jsr setSpriteNumber
    lda #<SPRITE_SAUCERRIGHT
    ldx #>SPRITE_SAUCERRIGHT
    ldy #`SPRITE_SAUCERRIGHT
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

    lda #SPRITENUMBER_SAUCER
    jsr setSpriteNumber
    lda #<SPRITE_SAUCERLEFT
    ldx #>SPRITE_SAUCERLEFT
    ldy #`SPRITE_SAUCERLEFT
    jsr setSpriteAddress
     jsr showSprite

    rts

pickDirection
    jsr getRandom
    cmp #127
    bcc _left
    lda #right
    sta saucerDirection
    rts
_left
    lda #left
    sta saucerDirection
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

getX
    lda currX
    ldx currX + 1
    rts

getY
    lda currY
    ldx currY + 1
    rts

saveLineData
    phy
    phx
    pha
    ldy #0
_loop
    lda mLineData,y
    sta msaucerPathData,y
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
    lda msaucerPathData,y
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
msaucerDataLength
waitFrames = 120
wave0 = 2
wave1 = 5
pathDataLength = msaucerPathDataEnd - msaucerPathData
msaucerPathData
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
msaucerPathDataEnd
saucerActve
    .byte $00
saucerDirection
    .byte $00
saucerFrame .byte $0
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
    .byte $0
.endsection
.endnamespace