.section code
gameLoop

    lda mSOFSemaphore
    cmp #1
    bcs _run
    rts
_run
    pha
    phx
    phy
    stz  mSOFSemaphore
    jsr handle_mouse
    jsr splash.handle
    jsr menu.handle
    jsr waves.handle
    jsr psg.handle
    jsr gameOver.handle
    jsr score.handle
    inc r_seed
    ply
    plx
    pla
rts

handleEvents

    jsr gameLoop

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
    lda	event.type

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
    ;jsr handle_mouse
    lda event.mouse.delta.x
    sta evtMouseDx
    lda event.mouse.delta.y
    sta evtMouseDy
    lda event.mouse.delta.buttons
    sta evtMouseBtn
    ply
    plx
    pla
    rts

keyPressed
    pha
    phx
    phy
    lda event.key.ascii
    sta mKeyPress
    jsr keyboardAnykey
    jsr keyboardPressed
    ply
    plx
    pla
    rts

keyReleased
    pha
    phx
    phy
    lda event.key.ascii
    sta mKeyRelease
    jsr keyboardReleased
    ply
    plx
    pla
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
     inc mSOFSemaphore
    ; stz mSOFSemaphore
     ;jsr gameLoop
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
evtMouseDx
    .byte $00
evtMouseDy
    .byte $00
evtMouseBtn
    .byte $00
.endsection

