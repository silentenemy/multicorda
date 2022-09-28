rsdp_lookup:

.get_ebda_address:
        mov eax, 040Eh
        shl eax, 4
        mov [ebda_start], eax

.start_looking_up:
        mov ebx, 1024
        call rsdp_find_signature

        mov edi, 0B8000h+5*160
        mov ah, 07h
        cmp [rsdp], 0
        je .rsdp_not_found_in_ebda
        mov esi, s_rsdp_lookup_rsdp_found_1
        call memvga_puts
        jmp .lookup_finished

.rsdp_not_found_in_ebda:
        mov esi, s_rsdp_lookup_rsdp_not_found_1
        call memvga_puts

        mov eax, 0E0000h
        mov ebx, 01FFFFh
        call rsdp_find_signature

        mov edi, 0B8000h+6*160
        mov ah, 07h
        cmp [rsdp], 0
        je .rsdp_not_found_in_mba
        mov esi, s_rsdp_lookup_rsdp_found_2
        call memvga_puts
        jmp .lookup_finished

.rsdp_not_found_in_mba:
        mov esi, s_rsdp_lookup_rsdp_not_found_2
        call memvga_puts

.lookup_finished:
        call rsdp_validate
        mov edi, 0B8000h+7*160
        mov ah, 07h
        cmp al, 0
        jne .rsdp_invalid

.rsdp_valid:
        mov esi, s_rsdp_lookup_rsdp_valid
        call memvga_puts
        jmp .end

.rsdp_invalid:
        mov esi, s_rsdp_lookup_rsdp_invalid
        call memvga_puts
        hlt

.end:
        hlt

.defines:
        ebda_start dd 0
        rsdp       dd 0

        s_rsdp_lookup_rsdp_found_1 db "RSDP found successfully in EBDA!"
                                 db 0
        s_rsdp_lookup_rsdp_not_found_1 db "RSDP not found in EBDA!"
                                     db 0
        s_rsdp_lookup_rsdp_found_2 db "RSDP found successfully in main BIOS area!"
                                 db 0
        s_rsdp_lookup_rsdp_not_found_2 db "RSDP not found in main BIOS area!"
                                     db 0
        s_rsdp_lookup_rsdp_valid db "RSDP valid!"
                                 db 0
        s_rsdp_lookup_rsdp_invalid db "RSDP invalid!"
                                   db 0