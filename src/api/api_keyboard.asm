.section code
keyboardTimer
    jsr resetAnyKey
    lda mKeyboardDelay
    cmp #0
    bne _delay
    rts
_delay
    dec mKeyboardDelay
    rts 

resetAnyKey
    lda mKeyboardResetAnyKey
    cmp #0
    bne _delay
    stz mAnyKey
    rts
_delay
    dec mKeyboardResetAnyKey
    rts


keyboardAnykey
    lda mKeyboardDelay
    cmp #0
    beq _setKey
    rts
_setKey
    lda #1
    sta mAnyKey
    lda #10
    sta mKeyboardDelay
    lda #15
    sta mKeyboardResetAnyKey
    rts
    
keyboardPressed
    jsr set_w_pressed
    jsr set_a_pressed
    jsr set_s_pressed
    jsr set_d_pressed
    jsr set_l_pressed
    jsr set_space_pressed
    rts
keyboardReleased
    jsr set_w_released
    jsr set_a_released
    jsr set_s_released
    jsr set_d_released
    jsr set_l_released
    jsr set_space_released
    rts
resetControls
    stz mKeyW
    stz mKeyA
    stz mKeyS
    stz mKeyD
    rts 
keyPressMacro .macro
    lda mKeyPress
    cmp #\2
    beq _yes
    rts
_yes
    lda #1 
    sta \1
    stz mKeyPress
.endmacro


set_a_pressed
    #keyPressMacro mKeyA, 'a'
    rts

set_a_released
    lda mKeyRelease
    cmp #'a'
    beq _yes
    rts
_yes
    stz mKeyA
    rts

isAnyKeyPressed
    lda mKeyboardDelay
    cmp #0
    beq _checkAnyKey
    sec
    rts
_checkAnyKey
    lda mAnyKey
    cmp #1
    beq _yes
    sec
    rts
_yes
    stz mAnyKey
    clc
    rts

set_d_pressed
    #keyPressMacro mKeyD, 'd'
    rts

set_d_released
    lda mKeyRelease
    cmp #'d'
    beq _yes
    rts
_yes
    stz mKeyD
    rts

set_l_pressed
    #keyPressMacro mKeyL, 'l'
    rts

set_l_released

    lda mKeyRelease
    cmp #'l'
    beq _yes
    rts
_yes
    stz mKeyL
    rts

set_s_pressed
    #keyPressMacro mKeyS, 's'
    rts

set_s_released
    lda mKeyRelease
    cmp #'s'
    beq _yes
    rts
_yes
    stz mKeyS
    rts

set_q_pressed
    lda mKeyPress
    cmp #'q'
    beq _yes
    rts
_yes
    rts

set_w_pressed
    #keyPressMacro mKeyW, 'w'
    rts

set_w_released
    lda mKeyRelease
    cmp #'w'
    beq _yes
    rts
_yes
    stz mKeyW
    rts


set_space_pressed
    #keyPressMacro mKeySP, $20
    rts

set_space_released
    lda mKeyRelease
    cmp #$20
    beq _yes
    rts
_yes
    stz mKeySP
    rts


isWPressed
    lda mKeyW
    cmp #1
    beq _yes
    sec
    rts
 _yes
    clc
    rts

isAPressed
    lda mKeyA
    cmp #1
    beq _yes
    sec
    rts
 _yes
    clc
    rts

isSpacePressed
    lda mKeySP
    cmp #1
    beq _yes
    sec
    rts
 _yes
    clc
    rts

isSPressed
    lda mKeyS
    cmp #1
    beq _yes
    sec
    rts
 _yes
    clc
    rts

isDPressed
    lda mKeyD
    cmp #1
    beq _yes
    sec
    rts
 _yes
    clc
    rts
.endsection

.section variables
keyboardDelayTimer = 10
mKeyboardDelay
    .byte $00
mKeyboardResetAnyKey
    .byte $00
mAnyKey
    .byte $00
mKeyW
    .byte $00
mKeyA
    .byte $00
mKeyS
    .byte $00
mKeyD
    .byte $00
mKeyL
    .byte $00
mKeySP
    .byte $00
.endsection