ioapic_set_irq:
	; eax = irq
	; ebx = apic_id
	; ecx = vector

	mov [low_index], eax
	shl [low_index], 1
	add [low_index], 10h

	mov [high_index], eax
	shl [high_index], 1
	add [high_index], 11h

	push eax ; Load LAPIC address
	push ebx
	mov eax, [ioapic_address+high_index]
	and eax, 0FF000000h
	shr ebx, 24
	add eax, ebx
	mov [ioapic_address+high_index], eax

	mov ebx, 0FFFFFFFEh ; Unmask IRQ
	rol ebx, 16
	and eax, ebx

	mov ebx, 0FFFFFFFEh ; Set to physical delivery mode
	rol ebx, 11
	and eax, ebx

	

.defines:
	low_index dd 0
	high_index dd 0
	irq dd 0
