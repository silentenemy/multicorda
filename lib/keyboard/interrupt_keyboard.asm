int21h_handler:
        cli
        xchg bx, bx
        pushf
        push eax
        push ebx

        xor eax, eax
        xor ebx, ebx

        in al, 60h

        mov bl, al
        add ebx, sc_keypresses

        cmp al, 0E0h
        je .long_code

        test al, 10000000b
        jnz .key_released

.key_pressed:
        cmp byte [ebx], 1
        je .end

        mov byte [ebx], 1
        mov byte [last_scancode_pressed], al

        mov bl, al
        mov eax, s_key_pressed+4
        call btohex

        call memvga_cursor_virtual_load
        mov esi, s_key_pressed
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        jmp .end

.key_released:
        cmp byte [ebx], 0
        je .end

        sub ebx, 80h ; released scancode = pressed scancode + 80h
        mov byte [ebx], 0
        mov byte [last_scancode_released], al
        jmp .end

.long_code:

.end:
        mov al, 1h
        call pic8259_eoi

        pop ebx
        pop eax
        popf
        iret

.defines:
        s_key_pressed db "key XXh pressed!", 0
        sc_keypresses db 0 dup 256
        last_scancode_pressed db 0
        last_scancode_released db 0