.stage2_start:
        call biosvga_cursor_get_coordinates
        mov ax, 0
        mov bx, s_stage2_start
        mov cx, 15
        call biosvga_write_info

        hlt

.defines:
        s_stage2_start db "stage2 started!"