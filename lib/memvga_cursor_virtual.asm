memvga_cursor_virtual_set:
        ; EAX = coords
        mov [memvga_cursor_virtual_coordinates], eax
        ret

memvga_cursor_virtual_load:
        mov edi, 0B8000h
        add edi, [memvga_cursor_virtual_coordinates]
        ret

memvga_cursor_virtual_newline:
        push eax
        push ebx
        mov eax, [memvga_cursor_virtual_coordinates]
        mov bl, 160
        div bl
        shr ax, 8
        sub [memvga_cursor_virtual_coordinates], eax
        cmp dword [memvga_cursor_virtual_coordinates], (80*24*2)  ; if coords point to the last line,
        jae .last_line ; do scrolling
        add dword [memvga_cursor_virtual_coordinates], 160 ; else get to the next line
        jmp .end

.last_line:
        jmp .end
.end:
        pop ebx
        pop eax
        ret

memvga_cursor_virtual_coordinates dd 0