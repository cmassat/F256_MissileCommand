clearExtMem
    lda #8
    jsr clearMemory
    lda #9
    jsr clearMemory
    lda #10
    jsr clearMemory
    lda #11
    jsr clearMemory
    lda #12
    jsr clearMemory
    lda #13
    jsr clearMemory
    lda #14
    jsr clearMemory
    lda #15
    jsr clearMemory
   ; lda #16
   ; jsr clearMemory
    rts

initMMU
    stz MMU_IO_CTRL
    lda #$b3
    sta MMU_MEM_CTRL
    lda memBank5
    sta $d
    rts
clearMemory
    pha
    lda #$b3
    sta MMU_MEM_CTRL

    pla
    sta $d

    ldy #0
    lda #0
_loop
    sta $A000,y
    sta $A100,y
    sta $A200,y
    sta $A300,y
    sta $A400,y
    sta $A500,y
    sta $A600,y
    sta $A700,y
    sta $A800,y
    sta $A900,y
    sta $AA00,y
    sta $AB00,y
    sta $AC00,y
    sta $AD00,y
    sta $AE00,y
    sta $AF00,y
    sta $B000,y
    sta $B100,y
    sta $B200,y
    sta $B300,y
    sta $B400,y
    sta $B500,y
    sta $B600,y
    sta $B700,y
    sta $B800,y
    sta $B900,y
    sta $BA00,y
    sta $BB00,y
    sta $BC00,y
    sta $BD00,y
    sta $BE00,y
    sta $BF00,y

    iny
    cpy #0
    bne _loop

    lda memBank5
    sta $d
    rts