.init_stack:
;       mov ax, 1A40h
;       mov ss, ax
        mov esp, 1A400h

.mbr_start:
        call biosvga_init
        call biosvga_cursor_get_coordinates
        mov ax, 0h              ; SEGMENT
        mov bx, s_mbr_start     ; OFFSET
        mov cx, 28              ; LENGTH
        call biosvga_write_info
        call biosvga_cursor_newline

.load_from_drive:

        ; READ THE SECTOR NOW!

        mov ax, 07E0h
        mov es, ax      ; buffer segment
        mov bx, 0000h   ; buffer offset

        mov ah, 02h     ; Set operation to 'read sector'
        mov al, 2       ; Read exactly TWO sectors
        mov dh, 0       ; on the first head
        mov ch, 0       ; first cylinder
        mov cl, 2       ; second sector

        int 13h
        jc .read_error

.mbr_done:
        call biosvga_cursor_get_coordinates
        mov ax, 0h              ; SEGMENT
        mov bx, s_mbr_done      ; OFFSET
        mov cx, 30              ; LENGTH
        call biosvga_write_info
        call biosvga_cursor_newline

.enter_stage2:
        jmp 0000:7E00h

.read_error:
        mov ax, 0h              ; SEGMENT
        mov bx, s_mbr_error     ; OFFSET
        mov cx, 31              ; LENGTH
        call biosvga_write_info

        hlt

.defines:
        include '../lib/biosvga.asm'
        s_mbr_start     db "MBR alive, loading stage2..."
        s_mbr_done      db "MBR done, jumping to stage2..."
        s_mbr_error     db "MBR failed: error reading disk!"

.signature:
        times 510 - ($ - $$) db 0
        db 0x55
        db 0xAA
