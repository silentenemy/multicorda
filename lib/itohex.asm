dtohex:
        ; ebx = int
        ; eax = output memory address
        push ecx
        push edx
        mov edx, 8

.halfbyte:
        mov ecx, ebx

        shr ecx, 28             ; shift highest halfbyte right to the lowest halfbyte

        add ecx, hexbytes       ; ecx = offset of required symbol
        mov cl, [ecx]
        mov [eax], cl
        inc eax

        shl ebx, 4              ; remove highest halfbyte from ebx by shifting

        dec edx
        cmp edx, 0
        jne .halfbyte

.finished:
        sub eax, 4
        pop edx
        pop ecx
        ret

bytetohex:
        ; bl = int
        ; eax = output memory address
        push ecx
        mov cl, bl
        shr cl, 4
        add ecx, hexbytes
        mov cl, [ecx]
        mov [eax], cl
        inc eax
        mov cl, bl
        and cl, 0Fh
        add ecx, hexbytes
        mov cl, [ecx]
        mov [eax], cl
        dec eax
        pop ecx
        ret

