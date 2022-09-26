.stage2_start:
        call biosvga_cursor_get_coordinates
        mov ax, 0
        mov bx, s_stage2_start
        mov cx, 15
        call biosvga_write_info
        call biosvga_cursor_newline

.init_gdt:
        cli
        lgdt [gdt_descriptor]
        call biosvga_cursor_get_coordinates
        mov ax, 0
        mov bx, s_stage2_gdt_ok
        mov cx, 11
        call biosvga_write_info
        call biosvga_cursor_newline

.enter_protected_mode:
        mov eax, cr0
        or eax, 1h
        mov cr0, eax
        jmp 08h:.fix_segment_registers ; jump to 32-bit first

use32
.fix_segment_registers:
        mov eax, gdt_data-gdt_start    ; then fix registers
        mov ds, ax
        mov es, ax
        mov fs, ax
        mov ss, ax

.pm_ok:
        ;push dword 0B8000h+154
        ;push dword s_stage2_pm_ok
        ;push word  0B00h
        mov esi, s_stage2_pm_ok
        mov edi, 0B8000h+4*(160)
        mov ah, 07h
        call memvga_puts

        mov esi, s_stage2_vga_ok
        mov edi, 0B8000h+4*(160)+2*36
        mov ah, 0Bh
        call memvga_puts
        call memvga_cursor_disable
        ;add esp, 9

        hlt

.defines:
        s_stage2_start db "stage2 started!"
        s_stage2_gdt_ok db "GDT loaded!"
        s_stage2_pm_ok db "Entered protected mode, writing via *** buffer!"
                       db 0
        s_stage2_vga_ok db "VGA"
                        db 0