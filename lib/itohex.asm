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

btohex:
        ; bl = int
        ; eax = output memory address
        push ecx
        xor ecx, ecx

        mov cl, bl              ; cl = byte
        shr cl, 4               ; cl is high halfbyte (F*h)
        add ecx, hexbytes       ; ecx = hexbytes[high_halfbyte] = &(ASCII of high halfbyte)
        mov cl, [ecx]           ; cl = ASCII of high halfbyte
        mov [eax], cl           ; *(eax) = ASCII of high halfbyte
        inc eax                 ; increment eax, now points to next symbol

        mov cl, bl              ; cl = byte
        and ecx, 0Fh             ; cl is low halfbyte (*Fh)
        add ecx, hexbytes
        mov cl, [ecx]
        mov [eax], cl
        dec eax
        pop ecx
        ret

