interrupt_handler_stub:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_intstub
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        iret

int1h_handler:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_int1h_happened
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        iret

int8h_handler:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_int8h_df
        mov ah, 0Ch     ; light red fg
        call memvga_puts
        call memvga_cursor_virtual_newline
        iret

int0dh_handler:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_int0dh_gpf
        mov ah, 40h     ; dark red bg
        call memvga_puts
        call memvga_cursor_virtual_newline
        hlt

int20h_handler:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_int20h_pit
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        mov al, 20h
        out 20h, al
        iret

.defines:
        s_intstub db "[!] Int happened but I am a stub handler!", 0
        s_int1h_happened db "[!] Caught int 1h!", 0
        s_int8h_df db "[!!] Caught double fault!", 0
        s_int0dh_gpf db "[!!!] Caught General Protection Fault, halting!", 0
        s_int20h_pit db "[!] Got PIT irq!", 0
