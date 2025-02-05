; .section code
; ; a is lo byte
; ; x is hi byte
; ; y is width
; setObjectCollisionA
;     sta mObjectStartA
;     stx mObjectStartA + 1
;     sty mObjectWidthA

;     lda mObjectStartA
;     clc
;     adc mObjectWidthA
;     sta mObjectEndA
;     lda mObjectStartA + 1
;     adc #0
;     sta mObjectEndA + 1
;     rts

; ; a is lo byte
; ; x is hi byte
; ; y is width
; setObjectCollisionB
;     sta mObjectStartB
;     stx mObjectStartB + 1
;     sty mObjectWidthB

;     lda mObjectStartB
;     clc
;     adc mObjectWidthB
;     sta mObjectEndB

;     lda mObjectStartB + 1
;     adc #0
;     sta mObjectEndB + 1
;     rts

; isCollision
;     lda mObjectEndA + 1
;     cmp mObjectStartB + 1
;     beq _check_box1_lo
;     bcs _check_box2
;     sec
;     rts
; _check_box1_lo
;     lda mObjectEndA
;     cmp mObjectStartB
;     bcs _check_box2
;     sec
;     rts
; _check_box2
;     lda mObjectEndB + 1
;     cmp mObjectStartA + 1
;     beq _check_box2_low
;     bcs _hit
;     sec
;     rts
; _check_box2_low
;     lda mObjectEndB
;     cmp mObjectStartA
;     bcs _hit
;     sec
;     rts
; _hit
;     clc
;     rts

; .endsection
; coollideMacro .macro
;     stz mXhit
;     stz mYhit
;     lda \1
;     ldx \1 + 1
;     ldy #\2
;     jsr setObjectCollisionA

;     lda  \3
;     ldx  \3 + 1
;     ldy #\4
;     jsr setObjectCollisionB
;     jsr isCollision
;     bcc _CheckY
;     rts
; _CheckY
;     lda #1
;     sta mXhit
;     lda \5
;     ldx \5 + 1
;     ldy #\6
;     jsr setObjectCollisionA

;     lda \7
;     ldx \7 + 1
;     ldy #\8
;     jsr setObjectCollisionB
;     jsr isCollision
;     bcc _collision
;     rts
; _collision
;      lda #1
;      sta mYhit
; .endmacro
; .section variables
; mObjectStartA
;     .byte $00, $00
; mObjectWidthA
;     .byte $00
; mObjectStartB
;     .byte $00, $00
; mObjectWidthB
;     .byte $00

; mObjectEndA
;     .byte $00, $00
; mObjectEndB
;     .byte $00, $00
; mYhit
;     .byte $00
; mXhit
;     .byte $00
; .endsection