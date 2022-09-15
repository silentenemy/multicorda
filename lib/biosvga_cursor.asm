biosvga_cursor_get_coordinates:
        push ax
        push bx
        push cx
        mov ah, 03h     ; get cursor position
        mov bh, 00h ; page 0
        int 10h
        pop cx
        pop bx
        pop ax
        ret     ; DH = row, DL = column

biosvga_cursor_set_coordinates: ; DH = row, DL = column
        push ax
        push bx
        mov ah, 02h
        mov bh, 00h ; page
        int 10h
        pop bx
        pop ax
        ret

biosvga_cursor_scroll_up:
        push ax
        push bx
        push cx
        push dx
        mov ah, 06h
        mov al, 1
        mov bh, 0Fh ; 0 - black, F - white
        mov ch, 0
        mov cl, 0
        mov dh, 24
        mov dl, 79
        int 10h
        pop dx
        pop cx
        pop bx
        pop ax
        ret

biosvga_cursor_push_left:
        push dx
        dec dl
        call biosvga_cursor_set_coordinates
        pop dx
        ret

biosvga_cursor_push_right:
        push dx
        call biosvga_cursor_get_coordinates
        cmp dl, 79
        jnz .not_equal
        mov dl, 0
        call biosvga_cursor_set_coordinates
        call biosvga_cursor_scroll_up
        pop dx
        ret

        .not_equal: inc dl
        call biosvga_cursor_set_coordinates
        pop dx
        ret

biosvga_cursor_newline:
        push dx
        call biosvga_cursor_get_coordinates
        cmp dh, 24
        je .scroll_up

        inc dh
        mov dl, 0
        call biosvga_cursor_set_coordinates     
        pop dx
        ret

.scroll_up:
        mov dh, 24
        mov dl, 0
        call biosvga_cursor_set_coordinates
        call biosvga_cursor_scroll_up
        pop dx
        ret
