format binary

global_start:

use16
org 7C00h
include 'boot/mbr.asm'

org 7E00h
include 'boot/stage2.asm'

include 'acpi/rsdp_lookup.asm'
include 'acpi/parse_rsdt.asm'
include 'acpi/madt_count_cpus.asm'
include 'interrupts/init_interrupts.asm'

include 'lib/gdt.asm'
include 'lib/memvga.asm'

include 'lib/acpi/rsdp.asm'
include 'lib/acpi/rsdt.asm'
include 'lib/acpi/madt.asm'

include 'lib/interrupts/pic8259.asm'
include 'lib/interrupts/interrupt_basic.asm'
include 'lib/interrupts/idt.asm'
include 'lib/interrupts/lapic.asm'

include 'lib/keyboard/interrupt_keyboard.asm'
include 'lib/keyboard/scancodes.asm'

include 'payload.asm'

include 'lib/itohex.asm'

include 'lib/defines.asm'

global_end: