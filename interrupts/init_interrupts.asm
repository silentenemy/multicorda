load_idt:
        call idt_fill_48
        lidt [idt_descriptor]

.update_handlers:

        mov eax, 1
        mov ebx, int1h_handler
        call idt_change_handler

        mov eax, 13
        mov ebx, int13h_handler
        call idt_change_handler

        mov eax, 21h
        mov ebx, int21h_handler
        call idt_change_handler

        jmp payload