; RTFM!
; https://ethv.net/workshops/osdev/notes/notes-3.html
; https://wiki.osdev.org/APIC

enable_lapic:
        ; software-disable configuration bit for the local APIC is bit 8 of the Spurious Interrupt Vector register
        mov eax, [LAPIC_SIVR]
        or eax, 10000000h
        mov [LAPIC_SIVR], eax

