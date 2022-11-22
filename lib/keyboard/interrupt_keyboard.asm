int21h_handler:
        cli
        mov al, 21h
        call pic8259_eoi
        call memvga_cursor_virtual_load
        mov esi, s_key_pressed
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        iret

.defines:
        s_key_pressed db "key pressed!", 0