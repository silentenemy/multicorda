load_idt:
        call idt_fill_48
        lidt [idt_descriptor]

.update_handlers:

        mov eax, 0h
        mov ebx, int0h_handler
        call idt_change_handler

        mov eax, 6h
        mov ebx, int6h_handler
        call idt_change_handler

        mov eax, 8h
        mov ebx, int8h_handler
        call idt_change_handler

        mov eax, 0Dh
        mov ebx, int0dh_handler
        call idt_change_handler

        mov eax, 21h
        mov ebx, int21h_handler
        call idt_change_handler

        mov eax, 20h
        mov ebx, int20h_handler
        call idt_change_handler

        jmp payload