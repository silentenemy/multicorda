.init_stack:
	;mov ax, 1440h
	;mov ss, ax
	mov esp, 14400h

.mbr_start:
	call biosvga_init

	push 0h 	; SEGMENT
	push s_mbr_start; OFFSET
	push 28		; LENGTH
	call biosvga_write_info

.load_from_drive:

	; READ THE SECTOR NOW!

	mov ax, 07E0h
	mov es, ax	; buffer segment
	mov bx, 0000h	; buffer offset

	mov ah, 02h	; Set operation to 'read sector'
	mov al, 2	; Read exactly two sectors
	mov dh, 0	; on the first head
	mov ch, 0	; first cylinder
	mov cl, 2	; second sector

	int 13h
	jc .read_error

.mbr_done:
	push 0h		; SEGMENT
	push s_mbr_done	; OFFSET
	push 30		; LENGTH
	call biosvga_write_info

.enter_stage2:
	jmp 0000:7E00h

.read_error:
	push 0h		; SEGMENT
	push s_mbr_error; OFFSET
	push 31		; LENGTH
	call biosvga_write_info

	hlt

.defines:
	include '../lib/biosvga.asm'
	s_mbr_start 	db "MBR alive, loading stage2..."
	s_mbr_done	db "MBR done, jumping to stage2..."
	s_mbr_error 	db "MBR failed: error reading disk!"

.signature:
	times 510 - ($ - $$) db 0
	db 0x55
	db 0xAA
