dtohex:
        ; ebx = int
        ; eax = output memory address
        push ecx

.halfbyte:
        mov ecx, ebx

        shr ecx, 28             ; shift highest halfbyte right to the lowest halfbyte

        add ecx, hexbytes       ; ecx = offset of required symbol
        mov cl, [ecx]
        mov [eax], cl
        inc eax

        shl ebx, 4              ; remove highest halfbyte from ebx by shifting

        cmp ebx, 0
        jne .halfbyte

.finished:
        sub eax, 4
        pop ecx
        ret

.defines:
        hexbytes db "0123456789ABCDEF"
