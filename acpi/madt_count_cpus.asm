madt_handle_flags:
        call madt_check_flags
        jne .dual_legacy_pics

.apic:
        call memvga_cursor_virtual_load
        mov esi, s_madt_masking_pic_interrupts
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline
        jmp .disable_pics

.dual_legacy_pics:
        call memvga_cursor_virtual_load
        mov esi, s_madt_dual_legacy_pics_present
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline

.disable_pics:
        call pic8259_disable

madt_count_cpus:
        call madt_detect_cores

.print_cores_num:
        mov  bl, [lapic_ids_length]
        mov eax, s_madt_count_cpus_num+17
        call btohex

        call memvga_cursor_virtual_load
        mov esi, s_madt_count_cpus_num
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline

.print_lapic_ids:
        mov ebx, dword [lapic_ids]
        mov eax, s_madt_count_cpus_ids+11
        call dtohex
        mov ebx, dword [lapic_ids+4]
        mov eax, s_madt_count_cpus_ids+20
        call dtohex
        mov ebx, dword [ioapic_address]
        mov eax, s_madt_count_cpus_ids+47
        call dtohex

        call memvga_cursor_virtual_load
        mov esi, s_madt_count_cpus_ids
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline

        jmp load_idt

.defines:
        lapic_ids            dq 0
        lapic_ids_length     db 0

        s_madt_dual_legacy_pics_present db "Dual legacy PICs present!", 0
        s_madt_masking_pic_interrupts db "No legacy PICs found.", 0
        s_madt_count_cpus_num   db "Number of cores: ZZh", 0
        s_madt_count_cpus_ids   db "LAPIC IDs: ........ ........ / IOAPIC address: ........", 0