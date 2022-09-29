rsdt_extract_pointer:
        push eax
        push ebx
        mov eax, [rsdp]
        mov ebx, [eax+16] ; uint32_t RsdtAddress is present with 16-byte offset from beginning of RSDP descriptor
        mov [rsdt], ebx
        pop ebx
        pop eax
        ret

rsdt_extract_length:
        push eax
        push ebx
        mov eax, [rsdt]
        mov ebx, [eax+4]
        mov [rsdt_length], ebx
        pop ebx
        pop eax
        ret

rsdt_validate:
        ; [rsdt] = address of RSDT start
        ; returns al = 0 if valid
        push ebx  ; ptr
        push ecx  ; end ptr
        xor eax, eax
        mov ebx, [rsdt]
        mov ecx, [rsdt]
        add ecx, [rsdt_length]
        dec ecx

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

rsdt_find_sdt:
        ; [rsdt]        = address of RSDT
        ; [rsdt_length] = length of RSDT
        ; ebx           = (dword) SDT signature in little endian (string = "FACP", dword = "PCAF") (mov ebx, "FACP" ; is enough)
        ; eax           = returned address, 0 if failed
        push ecx
        push edx

        mov ecx, [rsdt]
        mov edx, ecx
        add ecx, 36     ; add RSDT header size
        add edx, [rsdt_length]
.round:
        mov eax, [ecx]
        cmp [eax], ebx
        je .end
        add ecx, 4
        cmp ecx, edx
        jg .failed
        jmp .round

.failed:
        xor eax, eax
        jmp .end

.end:
        pop edx
        pop ecx
        ret