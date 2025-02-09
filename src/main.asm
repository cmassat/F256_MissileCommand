*=$1000
.dsection variables

*=$2000
.dsection code 


.section code
start
    jmp main
.include "api/include.asm"
.include "events.asm"
.include "splash.asm"
.include "state.asm"
.include "menu.asm"
.include "init.asm"
.include "psgSounds.asm"
.include "cities.asm"
.include "score.asm"
.include "wave1.asm"
.include "icbm.asm"
.include "cruise.asm"
.include "plane.asm"
.include "saucer.asm"
.include "abm.asm"
.include "site.asm"
.include "explosion.asm"
.include "collision/collision.asm"
.include "debug.asm"
main
    stz MMU_IO_CTRL
    jsr initGame
    jsr init_mouse

    jsr initEvents
    jsr setFrameTimer
    jsr handleEvents
_loop
    jmp _loop
    rts




.section variables
; wave1 = 5
; mMoveMisleFrame
;     .byte $00
; mx
;     .byte $00, $00
; my
;     .byte $00, $00
; mAi
;     .byte $00, $00
; mBi
;     .byte $00, $00
; mD
;     .byte $00, $00
; mDx
;     .byte $00, $00
; mDy
;     .byte $00, $00
; mS
;     .byte $00
mxdirection
    .byte $00
mydirection
    .byte $00
.endsection
.endsection
*=$a000
.binary "../assets/sprite.pal"

*=$10000
mBitmapData
*=$1F000

.binary "../assets/bitmap.bin"
mSpriteData
.binary "../assets/sprite.bin"

