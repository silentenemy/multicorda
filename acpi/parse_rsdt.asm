parse_rsdt:

        call rsdt_extract_pointer
        call rsdt_extract_length
        call rsdt_validate

        cmp al, 0
        jne .rsdt_invalid

.rsdt_valid:
        call memvga_cursor_virtual_load
        mov ah, 07h
        mov esi, s_parse_rsdt_valid
        call memvga_puts
        call memvga_cursor_virtual_newline
        jmp .rsdt_find_madt

.rsdt_invalid:
        call memvga_cursor_virtual_load
        mov ah, 0Bh
        mov esi, s_parse_rsdt_invalid
        call memvga_puts
        call memvga_cursor_virtual_newline

        mov eax, s_parse_rsdt_length_hex+9
        mov ebx, [rsdt_length]
        call dtohex
        call memvga_cursor_virtual_load
        mov esi, s_parse_rsdt_length_hex
        mov ah, 0Bh
        call memvga_puts
        call memvga_cursor_virtual_newline

        call memvga_cursor_virtual_load
        mov esi, [rsdt]
        mov ebx, [rsdt_length]
        call memvga_puts_len

        hlt

.rsdt_find_madt:
        mov ebx, "APIC"
        call rsdt_find_sdt
        cmp eax, 0
        je .madt_not_found

.madt_found:
        mov [madt], eax
        mov ebx, eax
        mov eax, s_parse_rsdt_madt_f+14
        call dtohex
        call memvga_cursor_virtual_load
        mov esi, s_parse_rsdt_madt_f
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline

        call madt_extract_length
        jmp madt_handle_flags

.madt_not_found:
        call memvga_cursor_virtual_load
        mov esi, s_parse_rsdt_madt_nf
        mov ah, 0Bh
        call memvga_puts
        call memvga_cursor_virtual_newline

        hlt

.defines:
        rsdt dd 0
        rsdt_length dd 0
        madt dd 0
        madt_length dd 0
        s_parse_rsdt_valid      db "RSDT valid!"
                                db 0
        s_parse_rsdt_invalid    db "RSDT invalid!"
                                db 0
        s_parse_rsdt_length_hex db "length = DEADBEEFh"
                                db 0
        s_parse_rsdt_madt_f     db "MADT found at DEADBEEFh!"
                                db 0
        s_parse_rsdt_madt_nf    db "MADT not found!"
                                db 0