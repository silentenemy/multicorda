; RTFM! https://wiki.osdev.org/PIC

; PIC IO addresses
PIC1 equ 020h
PIC2 equ 0A0h
PIC1_DATA equ PIC1+1
PIC2_DATA equ PIC2+1

; PIC IO commands
PIC_EOI equ 020h

PIC_ICW1_ICW4 equ 01h ; ICW4 needed
PIC_ICW1_INIT equ 10h ; INIT!

PIC_ICW2_1 equ 020h ; offsets of vectors for PIC 1
PIC_ICW2_2 equ 028h ; and PIC 2

PIC_ICW3_MASTER equ 4 ; tell master there's a slave PIC at IRQ2 (0000 0100)
PIC_ICW3_SLAVE  equ 2 ; tell slave its cascade identity (0000 0010)

PIC_ICW4_8086   equ 01h ; 8086 mode

; PIC procedures
pic8259_iowait:
        push ax
        mov al, 0
        out 080h, al
        pop ax
        ret

pic8259_remap:
        push ax

        in al, PIC1_DATA
        mov [pic1_mask], al
        in al, PIC2_DATA
        mov [pic2_mask], al

        ; ICW1
        mov al, PIC_ICW1_INIT
        and al, PIC_ICW1_ICW4
        out PIC1, al
        call pic8259_iowait
        out PIC2, al
        call pic8259_iowait

        mov al, PIC_ICW2_1
        out PIC1_DATA, al
        call pic8259_iowait
        mov al, PIC_ICW2_2
        out PIC2_DATA, al
        call pic8259_iowait

        mov al, PIC_ICW3_MASTER
        out PIC1_DATA, al
        call pic8259_iowait
        mov al, PIC_ICW3_SLAVE
        out PIC2_DATA, al
        call pic8259_iowait

        mov al, PIC_ICW4_8086
        out PIC1_DATA, al
        call pic8259_iowait
        out PIC2_DATA, al
        call pic8259_iowait

        mov al, [pic1_mask]
        out PIC1_DATA, al
        mov al, [pic2_mask]
        out PIC2_DATA, al

        pop ax
        ret

.defines:
        pic1_mask db 0
        pic2_mask db 0

pic8259_disable:
        push ax
        mov al, 0FFh
        out PIC1_DATA, al
        out PIC2_DATA, al
        pop ax
        ret

pic8259_eoi:
        cmp ax, 8
        jb .only_master
        push ax
        mov al, PIC_EOI
        out PIC2, al
        pop ax
.only_master:
        push ax
        mov al, PIC_EOI
        out PIC1, al
        pop ax
        ret