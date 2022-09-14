include 'biosvga_cursor.asm'

biosvga_init:
        mov ah, 00h ; Set video mode
        mov al, 03h ; to 03h (http://www.columbia.edu/~em36/wpdos/videomodes.txt)
        int 10h
	ret

biosvga_write_info:

	; ARGS: SEGMENT, OFFSET, LENGTH

	pop cx
	pop bx
	pop ax

        mov es, ax
        mov bp, bx

        mov ah, 13h ; Write string
        mov al, 00000001b       ; Write mode
        mov bl, 0Bh     ; color light cyan
        int 10h
	ret
