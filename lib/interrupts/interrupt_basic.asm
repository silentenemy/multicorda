interrupt_handler_stub:
        xchg bx, bx
        cli
        call memvga_cursor_virtual_load
        mov esi, s_intstub
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        iret

int0h_handler:
        cli
        mov [dbz_ip], edx
        pop edx
        push edx
        xchg edx, [dbz_ip]
        pushf
        push eax
        push ebx

        mov ebx, [dbz_ip]
        mov eax, s_int0h_dbz+36
        call dtohex

        call memvga_cursor_virtual_load
        mov esi, s_int0h_dbz
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline

        xchg bx, bx ; Bochs breakpoint!
        hlt         ; Right now we won't manage the recovery of a system

        pop ebx
        pop eax
        popf
        iret

.defines:
        dbz_ip dd 0

int1h_handler:
        cli
        call memvga_cursor_virtual_load
        mov esi, s_int1h_happened
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        iret

int6h_handler:
        cli
        pop ebx
        mov eax, s_int6h_ud+35
        call dtohex
        call memvga_cursor_virtual_load
        mov esi, s_int6h_ud
        mov ah, 40h     ; dark red bg
        call memvga_puts
        call memvga_cursor_virtual_newline
        xchg bx, bx
        hlt

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
        s_int0h_dbz db "[!] Caught division by zero at addr XXXXXXXXh, halting!", 0
        s_int1h_happened db "[!] Caught int 1h!", 0
        s_int6h_ud db "[!!!] Found invalid opcode at addr XXXXXXXXh, halting!", 0
        s_int8h_df db "[!!] Caught double fault!", 0
        s_int0dh_gpf db "[!!!] Caught General Protection Fault, halting!", 0
        s_int20h_pit db "[!] Got PIT irq!", 0
