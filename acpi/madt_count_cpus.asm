madt_count_cpus:

        call madt_detect_cores

.print_cores_num:
        mov  bl, [acpi_cpu_ids_length]
        mov eax, s_madt_count_cpus_num+17
        call dtohex

        call memvga_cursor_virtual_load
        mov esi, s_madt_count_cpus_num
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline

.print_cores_ids:
        mov ebx, dword [acpi_cpu_ids]
        mov eax, s_madt_count_cpus_ids+14
        call dtohex
        mov ebx, dword [acpi_cpu_ids+4]
        mov eax, s_madt_count_cpus_ids+23
        call dtohex

        call memvga_cursor_virtual_load
        mov esi, s_madt_count_cpus_ids
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline

        hlt

.defines:
        acpi_cpu_ids            dq 0
        acpi_cpu_ids_length     db 0

        s_madt_count_cpus_num   db "Number of cores: ZZZZZZZZh"
                                db 0
        s_madt_count_cpus_ids   db "CPU core IDs: ........ ........"
                                db 0