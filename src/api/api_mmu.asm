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
    lda #16
    jsr clearMemory
    lda #17
    jsr clearMemory
    lda #0
    rts

clearMemory
    pha
    lda #$b3
    lda MMU_MEM_CTRL

    pla
    sta $d

    ldy #0
    lda #0
_loop
  lda #0
  sta $A000,y
  sta $A000 + $ff, y
  sta $A000 + $ff + $ff , y
  sta $A000 + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff, y
  sta $A000 + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $ff + $1f, y

  iny
  cpy #0
  bne _loop
rts