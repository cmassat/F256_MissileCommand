.section code 
init_mouse
    lda #$1
    sta $D6E0 

    lda #100
    sta $D6E2
    sta $D6E4
    sta m_mouse_x_pos
    sta m_mouse_y_pos

    stz m_mouse_bl
    stz m_mouse_bm
    stz m_mouse_br
    rts 

mousex
    #mouse_find_cord event.mouse.delta.x, m_mouse_delta_x, m_mouse_x_pos
    rts
mousey
    #mouse_find_cord event.mouse.delta.y, m_mouse_delta_y, m_mouse_y_pos
    rts

checkButtonsClicked
    lda event.mouse.delta.buttons
    cmp #1
    bne _skip
    lda site.TEMP_X
    sta m_mouse_click_x
    lda site.TEMP_X + 1
    sta m_mouse_click_x + 1


    lda site.TEMP_Y
    sta m_mouse_click_y
    lda site.TEMP_Y + 1
    sta m_mouse_click_y + 1

    lda #1
    sta mLeftClicked
    rts
_skip
    rts

handle_mouse
    jsr mousex
    jsr mousey
    jsr adjust_off_screen
    jsr checkButtonsClicked

_plot_x 
    lda m_mouse_x_pos
    sta $D6E2
    lda m_mouse_x_pos + 1
    sta $D6E3

_plot_y
    lda m_mouse_y_pos
    sta $D6E4
    lda m_mouse_y_pos + 1
    sta $D6E5

    rts

adjust_off_screen

    lda m_mouse_x_pos + 1
    bmi _is_off_left

    lda m_mouse_y_pos + 1
    bmi _is_off_top

    lda m_mouse_x_pos + 1
    cmp #>640
    bcs _check_lx_byte 
    
    lda m_mouse_y_pos + 1
    cmp #>480
    bcs _check_ly_byte 

    rts  

_check_lx_byte 
    lda m_mouse_x_pos 
    cmp #<640
    bcs _is_off_right
    rts 

_check_ly_byte
    lda m_mouse_y_pos
    cmp #<480
    bcs _is_off_bottom
    rts

_is_off_right
    lda #<635
    sta m_mouse_x_pos 
    lda #>635
    sta m_mouse_x_pos + 1
    rts 


_is_off_left
    stz m_mouse_x_pos
    stz m_mouse_x_pos + 1
    rts 
_is_off_top
    stz m_mouse_y_pos
    stz m_mouse_y_pos + 1
    rts 
_is_off_bottom
    lda <#475
    sta m_mouse_y_pos 
    lda >#475
    sta m_mouse_y_pos + 1
    rts

isLeftClick
    lda mLeftClicked
    bne _yes
    stz mLeftClicked
    sec
    rts
_yes
    stz mLeftClicked
    clc
    rts

mouse_find_cord .macro delta,mem_delta, mem_position
    lda \delta
    sta \mem_delta
    bpl _is_not_negative

    lda \mem_delta
    eor #$ff
    adc #1
    sta \mem_delta

    lda \mem_position
    sec
    sbc \mem_delta
    sta \mem_position
    lda \mem_position + 1 
    sbc #0
    sta \mem_position + 1

    lda \mem_position + 1    
    bra _is_negative 
_is_not_negative
    lda \mem_position
    clc 
    adc \mem_delta
    sta \mem_position
    lda \mem_position + 1
    adc #0
    sta \mem_position + 1
_is_negative
.endmacro


getMouseX
    lda m_mouse_x_pos
    ldx m_mouse_x_pos + 1
    rts

getMouseY
    lda m_mouse_y_pos
    ldx m_mouse_y_pos + 1
    rts

getMouseClickX
    lda m_mouse_click_x
    ldx m_mouse_click_x + 1
    rts

getMouseClickY
    lda m_mouse_click_y
    ldx m_mouse_click_y + 1
    rts

.endsection

.section variables
m_mouse_delta_x  
    .byte $00, $00
m_mouse_delta_y 
    .byte $00, $00
m_mouse_shake
    .byte 0    
    
m_mouse_x_pos
    .byte $00, $00
m_mouse_y_pos 
    .byte $00, $00

m_mouse_bl
    .byte $00
m_mouse_bm
    .byte $00
m_mouse_br
    .byte $00
m_mouse_click_x
    .byte $00, $00

m_mouse_click_y
    .byte $00, $00

mLeftClicked
    .byte $0

.endsection