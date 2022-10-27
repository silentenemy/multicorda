madt_extract_length:
        push eax
        push ebx
        mov eax, [madt]
        mov ebx, [eax+4]
        mov [madt_length], ebx
        pop ebx
        pop eax
        ret

madt_check_flags:
        ; [madt] = MADT offset in memory
        ; ZF = flags==0 (1 = Dual 8259 Legacy PICs installed, 0 = nope)

        push eax
        mov eax, [madt]
        cmp dword [eax+28h], 0
        pop eax
        ret

madt_detect_cores:
        ; [madt] = MADT offset in memory
        ; [madt_length] = size of MADT

        push eax
        push ebx
        push ecx

        mov eax, [madt]
        add eax, [madt_length]
        mov [madt_end], eax
        mov eax, [madt]
        add eax, 2Ch    ; beginning of entries

.round:
        cmp byte [eax], 0
        je .local_apic
        cmp byte [eax], 1
        je .io_apic
        cmp byte [eax], 2
        je .int_source_override
        cmp byte [eax], 3
        je .nmi_source
        cmp byte [eax], 4
        je .local_apic_nmi
        cmp byte [eax], 5
        je .local_apic_addr_override
        cmp byte [eax], 9
        je .local_x2apic
        jmp .end

.local_apic:
        add eax, 2                      ; skip header
        mov ebx, acpi_cpu_ids           ; load effective address of acpi_cpu_ids[]
        mov bl, [acpi_cpu_ids_length]   ; ebx = acpi_cpu_ids[offset]
        add ebx, acpi_cpu_ids
        mov cl, [eax]                   ; store ACPI processor ID of current entry in cl first
        mov [ebx], cl                   ; and then in acpi_cpu_ids[offset]
        inc [acpi_cpu_ids_length]       ; increment offset
        add eax, 6                      ; skip APIC ID and flags
        jmp .end_round

.io_apic:
        add eax, 12
        jmp .end_round

.int_source_override:
        add eax, 10
        jmp .end_round

.nmi_source:
        add eax, 10
        jmp .end_round

.local_apic_nmi:
        add eax, 6
        jmp .end_round

.local_apic_addr_override:
        add eax, 12
        jmp .end_round

.local_x2apic:
        add eax, 16
        jmp .end_round

.end_round:
        cmp eax, [madt_end]
        jge .end
        jmp .round

.end:
        pop ecx
        pop ebx
        pop eax
        ret

.defines:
        madt_end                dd 0