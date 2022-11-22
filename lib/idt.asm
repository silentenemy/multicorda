idt_start:
        dq 48 dup 0
idt_end:

idt_descriptor:
        dw idt_end - idt_start
        dq idt_start

idt_fill_48:
        push eax
        push ebx
        push ecx
        push edx

        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        mov edx, 64

.get_entry_offset:
        mov eax, ebx
        mul dl

.fill_entry:
        mov ecx, int1h_handler
        mov [idt_start+eax], cx ; bytes 0-15
        ;mov cx, 08E00h ; P + DPL + Gate Type + 00h (reserved)
        ;mov [idt_start+eax+4], ecx ; bytes 32-63
        ;mov cx, 08h
        ;mov [idt_start+eax+2], cx ; bytes 16-31
        mov word [idt_start+eax+4], 08E00h
        mov word [idt_start+eax+2], 0008h
        shr ecx, 16
        mov [idt_start+eax+6], cx

        inc ebx
        cmp ebx, 48
        je .done
        jmp .get_entry_offset

.done:
        pop edx
        pop ecx
        pop ebx
        pop eax
        ret

idt_change_handler:
        ; eax = index
        ; ebx = address

        push eax
        push ebx
        push ecx

        mov cx, 64
        mul cl

        mov [idt_start+eax], bx
        shr ebx, 16
        mov [idt_start+eax+6], bx

        pop ecx
        pop ebx
        pop eax
        ret