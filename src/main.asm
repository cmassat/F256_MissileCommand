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
.include "psg/psgSounds.asm"
.include "score.asm"
.include "waves/waves.asm"
.include "icbm.asm"
.include "cruise.asm"
.include "plane.asm"
.include "saucer.asm"
.include "abm.asm"
.include "site.asm"
.include "explosion.asm"
.include "cities.asm"
.include "font.asm"
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
mBitmapStart
;.binary "../assets/bitmap.bin"
*=$24000
mBitmapStatic
*=$33000
mStaticBmpStart
    .binary "../assets/bitmap.bin"
mSpriteData
    .binary "../assets/sprite.bin"
