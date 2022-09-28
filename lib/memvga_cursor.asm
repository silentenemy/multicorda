memvga_cursor_get_coordinates:
        ; returns eax = offset from B8000h
        push bx
        push cx
        push dx

        mov al, 0Fh
        mov dx, 03D4h
        out dx, al
        inc dx
        in ax, dx

        mov bx, ax
        shr bx, 8

        mov al, 0Eh
        mov dx, 03D4h
        out dx, al
        inc dx
        in ax, dx

        add ax, bx
        mov bx, 2
        mul bx

        pop dx
        pop cx
        pop bx
        ret

memvga_cursor_disable:
        push dx
        push ax

        mov dx, 3D4h
        mov al, 0Ah
        out dx, al
        mov dx, 3D5h
        mov al, 20h
        out dx, al

        pop ax
        pop dx
        ret
