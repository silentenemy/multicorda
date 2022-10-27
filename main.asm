format binary

use16
org 7C00h
include 'boot/mbr.asm'

org 7E00h
include 'boot/stage2.asm'

include 'acpi/rsdp_lookup.asm'
include 'acpi/parse_rsdt.asm'
include 'acpi/madt_count_cpus.asm'

include 'lib/gdt.asm'
include 'lib/idt.asm'
include 'lib/memvga.asm'

include 'lib/acpi/rsdp.asm'
include 'lib/acpi/rsdt.asm'
include 'lib/acpi/madt.asm'

include 'lib/pic8259.asm'

include 'payload.asm'

include 'lib/itohex.asm'

include 'lib/defines.asm'