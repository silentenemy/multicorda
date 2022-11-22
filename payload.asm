payload:

.unmask_kbd:
        ;mov al, 0FEh
        mov al, 00h
        out PIC1_DATA, al
        sti
        jmp payload
        hlt

.defines:

