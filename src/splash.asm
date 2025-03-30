splash  .namespace
.section code
handle
    lda #state.splash
    jsr state.is
    bcc _ok
    rts
_ok
    lda #8
    jsr clutInc

    lda #begin
    jsr is
    bcc _setup

    lda #statewait
    jsr is
    bcc _wait
    rts
_setup
    jsr setup
    rts

_wait
    jsr wait
    rts

wait
    jsr isSpacePressed
    bcc _yes
    rts
_yes
    jsr state.next
    rts

printletter .macro spritenumber, letter, x,y
    lda #\spritenumber
    jsr setSpriteNumber

    lda <#\letter
    ldx >#\letter
    ldy `#\letter
    jsr setSpriteAddress
    lda <#\x
    ldx >#\x
    jsr setSpriteX

    lda <#\y
    ldx >#\y
    jsr setSpriteY

    jsr showSprite

.endmacro
setup
    lda #0
    sta MMU_IO_CTRL
    jsr clearVideo
    jsr site.hide

    lda #0
    ldx #0
    ldy #0
    jsr setBackgroundColor
    jsr enableText
    jsr enableGrafix
    jsr enableSprite
    jsr setVideo


    #printletter 00, SPRITE_LETTER_M, 32 + 100 + (0* 16), 32 + 120 - 32
    #printletter 01, SPRITE_LETTER_I, 32 + 100 + (1* 16), 32 + 120 - 32
    #printletter 02, SPRITE_LETTER_S, 32 + 100 + (2* 16), 32 + 120 - 32
    #printletter 03, SPRITE_LETTER_S, 32 + 100 + (3* 16), 32 + 120 - 32
    #printletter 13, SPRITE_LETTER_I, 32 + 100 + (4* 16), 32 + 120 - 32
    #printletter 04, SPRITE_LETTER_L, 32 + 100 + (5* 16), 32 + 120 - 32
    #printletter 05, SPRITE_LETTER_E, 32 + 100 + (6* 16), 32 + 120 - 32

    #printletter 06, SPRITE_LETTER_C, 32 + 100 + (0* 16), 48 + 120 - 32
    #printletter 07, SPRITE_LETTER_O, 32 + 100 + (1* 16), 48 + 120 - 32
    #printletter 08, SPRITE_LETTER_M, 32 + 100 + (2* 16), 48 + 120 - 32
    #printletter 09, SPRITE_LETTER_M, 32 + 100 + (3* 16), 48 + 120 - 32
    #printletter 10, SPRITE_LETTER_A, 32 + 100 + (4* 16), 48 + 120 - 32
    #printletter 11, SPRITE_LETTER_N, 32 + 100 + (5* 16), 48 + 120 - 32
    #printletter 12, SPRITE_LETTER_D, 32 + 100 + (6* 16), 48 + 120 - 32
    jsr psg.playPulse
    inc mState

    jsr setDoubleText
    lda <#mHitSpace
    ldx >#mHitSpace
    ldy #20
    jsr drawText

    lda #dk_brown
    ldx #black
    ldy #20
    jsr setColorByLine

    lda <#mVersion
    ldx >#mVersion
    ldy #19
    jsr drawText
    lda #red
    ldx #black
    ldy #19
    jsr setColorByLine
    rts

init
    jsr hideAllSprites
    stz mState
    rts


is
    cmp mState
    beq _yes
    sec
    rts
_yes
    clc
    rts

.endsection
.section variables
begin = 0
statewait = 1
mState
    .byte $00
mHitSpace
    .text '         Press Space To Continue'
    .byte $00

mVersion
    .text '         Version 00.01.01-a.1'
    .byte $00

.endsection
.endnamespace