include 'memvga_cursor.asm'

memvga_putc:
        ; AX  = color:symbol word
        ; EDX = offset
        add edx, 0B8000h
        mov [edx], ax
        ret

memvga_puts:
        ; [stack+4 ] = color byte
        ; [stack+6 ] = source addr
        ; [stack+10] = dest addr

        ;push ebp
        ;mov ebp, esp

        ;push eax
        ;push esi
        ;push edi

        ;mov ax, [ebp+4]
        ;mov esi, [ebp+6]
        ;mov edi, [ebp+10]

.continue:
        lods byte [ds:esi]
        cmp al, 0
        jz .return
        stos word [es:edi]
        jmp .continue

.return:
        ;pop edi
        ;pop esi
        ;pop eax

        ;mov esp, ebp
        ;pop ebp
        ret