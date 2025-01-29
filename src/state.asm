state .namespace
.section code 
handleState

    rts 

init
    lda #splash
    sta mState
    rts

is
    cmp mState
    beq _yes
    sec
    rts
_yes
    clc
    rts

next
    inc mState
    rts
.endsection
.section variables
splash = 0
menu = 1
wave1 = 2

mState
    .byte $00

.endsection
.endnamespace