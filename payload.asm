payload:

        mov al, 0FDh
        out PIC1_DATA, al
        sti

.clean_buffer:
        in al, 60h
        in al, 64h
        test al, 1
        jnz .clean_buffer

.loop:
        jmp .loop
        hlt

.defines:

