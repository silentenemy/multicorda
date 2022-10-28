load_idt:
        lidt [idt_descriptor]

        jmp payload