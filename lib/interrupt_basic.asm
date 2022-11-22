interrupt_handler_stub:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_intstub
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        iret

int0h_handler:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_int0h_gpf
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        hlt

int1h_handler:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_int1h_happened
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        iret

.defines:
        s_intstub db "[!] Int happened but I am a stub handler!", 0
        s_int1h_happened db "[!] Caught int 1h!", 0
        s_int0h_gpf db "[!!!] Caught General Protection Fault, halting!", 0
