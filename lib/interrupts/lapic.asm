LAPIC      equ 0xFEE00000
LAPIC_IDR  equ LAPIC+20h
LAPIC_EOIR equ LAPIC+0B0h
LAPIC_SIVR equ LAPIC+0F0h

lapic_eoi:
        push ebx
        mov ebx, LAPIC+100h  ; ISR registers of LAPIC have indices 0x10 - 0x17

.round:
        cmp [ebx], 0
        jnz .send_eoi   ; jnz = has at least one bit =1
        add ebx, 10h
        cmp ebx, LAPIC+180h ; all registers have been checked, ISR is not modified
        jz .isr_not_modified
        jmp .round

.send_eoi:
        mov [LAPIC_EOIR], 1
        jmp .end

.isr_not_modified:
.end:
        pop ebx
        ret