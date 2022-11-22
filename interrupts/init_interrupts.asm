load_idt:
        call idt_fill_48
        lidt [idt_descriptor]

        mov eax, 0
        mov ebx, int0h_handler
        call idt_change_handler

        mov eax, 1
        mov ebx, int1h_handler
        call idt_change_handler

        jmp payload