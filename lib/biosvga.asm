include 'biosvga_cursor.asm'

biosvga_init:
        push ax
        mov ah, 00h ; Set video mode
        mov al, 03h ; to 03h (http://www.columbia.edu/~em36/wpdos/videomodes.txt)
        int 10h
        pop ax
        ret

biosvga_write_info:

        ; ARGS: AX = SEGMENT, BX = OFFSET, CX = LENGTH
        push ax
        push bx

        mov es, ax
        mov bp, bx

        mov ah, 13h ; Write string
        mov al, 00000001b       ; Write mode
        mov bh, 0       ; page
        mov bl, 07h     ; color light gray

        int 10h
        pop bx
        pop ax
        ret
