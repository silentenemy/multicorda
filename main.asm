format binary

use16
org 7C00h
include 'boot/mbr.asm'

org 7E00h
include 'boot/stage2.asm'

include 'acpi/rsdp_lookup.asm'

include 'lib/gdt.asm'
include 'lib/idt.asm'
include 'lib/memvga.asm'

include 'lib/acpi/rsdp.asm'
