interrupt_handler_stub:
        iret

int1h_handler:
        cli
        ;call memvga_cursor_virtual_load
        ;mov esi, s_int1h_happened
        ;mov ah, 07h
        ;call memvga_puts
        ;call memvga_cursor_virtual_newline
        hlt
        iret

.defines:
        s_int1h_happened db "[!] Caught int 1h!", 0