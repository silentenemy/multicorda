rsdp_find_signature:
        ; eax = start
        ; ebx = length of sector
        ; changes [rsdp] if found
        push ecx
        push esi
        push edi

        add ebx, eax

.start_scan:    ; resets registers
        mov esi, rsdp_signature ; defined signature
        mov edi, eax            ; memory address
        xor ecx, ecx            ; same byte counter

.round:         ; does a single byte comparison
        cmpsb
        jz .same_byte
        add eax, 16     ; remember that RSDP is aligned at 16-byte boundary
        cmp eax, ebx    ; reached end of sector
        jg .end
        jmp .start_scan

.same_byte:     ; processes a single byte found
        inc ecx
        cmp ecx, 8
        je .found
        jmp .round

.found:         ; moves found pointer into memory
        mov [rsdp], eax

.end:
        pop edi
        pop esi
        pop ecx
        ret

.defines:
        rsdp_signature db "RSD PTR "

rsdp_validate:
        ; [rsdp] = address of RSDP descriptor
        ; returns al = 0 if valid
        push ebx  ; ptr
        push ecx  ; end ptr
        xor eax, eax
        mov ebx, [rsdp]
        mov ecx, [rsdp]
        add ecx, 20

.round:
        add al, [ebx]
        inc ebx
        cmp ebx, ecx
        jg .end
        jmp .round

.end:
        pop ecx
        pop ebx
        ret


