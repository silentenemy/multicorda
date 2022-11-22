payload:

        mov al, 0FDh
        out PIC1_DATA, al
        sti

.unmask_kbd:
        mov al, 0AEh
        out 64h, al     ; enable 1st port of PS/2 controller
        mov al, 0A8h
        out 64h, al     ; enable 2nd port

        mov al, 20h
        out 64h, al     ; request reading Controller Configuration Byte of PS/2 controller
        in al, 60h      ; read CCB

        or al, 3        ; enable 1st PS/2 port IRQ
        mov ah, al
        mov al, 60h
        out 64h, al     ; request writing to CCB
        mov al, ah
        out 60h, al     ; write CCB

.clean_buffer:
        in al, 64h
        test al, 1
        jnz .clean_buffer

.loop:
        jmp .loop
        hlt

.defines:

