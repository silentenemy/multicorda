payload:
        mov bl, 0DFh
        mov eax, s_payload+18
        call btohex

        call memvga_cursor_virtual_load
        mov esi, s_payload
        mov ah, 07h
        call memvga_puts
        call memvga_cursor_virtual_newline

        hlt

.defines:
        s_payload db "the given byte is **h", 0
