.section code
gameLoop
    lda mSOFSemaphore
    cmp #0
    beq _run
    rts
_run
    pha
    phx
    phy
    lda #1
    sta mSOFSemaphore
    jsr splash.handle
    jsr menu.handle
    jsr psg.handle
    inc r_seed
    ply
    plx
    pla
rts

handleEvents

   ; jsr gameLoop
_wait_for_event 
; Peek at the queue to see if anything is pending
    lda		kernel.args.events.pending  ; Negated count
    bpl		_done

    ; Get the next event.
    jsr		kernel.NextEvent
    bcs		_done

    ; Handle the event
    jsr		_dispatch
 _done
        ; Continue until the queue is drained.


    bra		handleEvents
    rts

 _dispatch
   ; Get the event's type
   lda		event.type

   ; Call the appropriate handler
    ; cmp	 #kernel.event.mouse.CLICKS
    ; beq	_mouse_clicked

    cmp #kernel.event.key.PRESSED
    beq keyPressed

    cmp #kernel.event.key.RELEASED
    beq keyReleased

    cmp #kernel.event.timer.EXPIRED
    beq handleTimerEvent

    cmp	 #kernel.event.mouse.DELTA
    beq	_mouse_moved


   rts
_mouse_moved
    pha
    phx
    phy
    jsr handle_mouse
    ply
    plx
    pla
   rts

keyPressed
   lda event.key.ascii
   sta mKeyPress
   jsr keyboardAnykey
   jsr keyboardPressed
   rts

keyReleased
    lda event.key.ascii
    sta mKeyRelease
    jsr keyboardReleased
    rts

handleTimerEvent
    lda event.timer.cookie
    cmp #42
    beq _sofTimer
    rts
_sofTimer
    lda mFireTimer
    cmp #0
    beq _next
    dec mFireTimer
_next
	 jsr setFrameTimer
     stz mSOFSemaphore
     jsr gameLoop
     inc mGameTicks
     lda mGameTicks
     cmp #60
     beq _updateSeconds
	rts
_updateSeconds
    inc mGameSeconds
    stz mGameTicks
    rts

setFrameTimer
    lda #0
	sta MMU_IO_CTRL
    lda #kernel.args.timer.FRAMES | kernel.args.timer.QUERY
    sta kernel.args.timer.units

    stz kernel.args.timer.absolute
    lda #42
    sta kernel.args.timer.cookie
    jsr kernel.Clock.SetTimer

    adc #1
    sta kernel.args.timer.absolute

    lda #kernel.args.timer.FRAMES
    sta kernel.args.timer.units

    lda #42
    sta kernel.args.timer.cookie
    jsr kernel.Clock.SetTimer
    rts
    
initEvents
    lda #<event
    sta kernel.args.events+0
    lda #>event
    sta kernel.args.events+1
    rts


.endsection

event	.dstruct	 kernel.event.event_t

.section variables
mFireTimer
    .byte $0
mSOFSemaphore
    .byte $00
mKeypress
    .byte $00
mKeyRelease
    .byte $01
v_sync
    .byte 0
mGameTicks
    .byte $00
mGameSeconds
    .byte $00
.endsection

