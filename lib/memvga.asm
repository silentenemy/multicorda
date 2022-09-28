include 'memvga_cursor.asm'

memvga_putc:
        ; AX  = color:symbol word
        ; EDX = offset
        add edx, 0B8000h
        mov [edx], ax
        ret

memvga_puts:
        ; ds:esi = source
        ; es:esi = destionation
        ; ah     = color attribute

.continue:
        lods byte [ds:esi]
        cmp al, 0
        jz .return
        stos word [es:edi]
        jmp .continue

.return:
        ret