section .data

idt: times 256 dq 0

idt_descriptor:
	dw 2047
	dd idt


section .text
global setup_idt
global init_pic

default_handler:
	cli
	hlt
	jmp default_handler

int_handler_0:
        cli
	pushad
	push ds
	push es
	push fs
	push gs

	mov al, 0x20
	out 0x20, al

	pop gs
	pop fs
	pop es
	pop ds
	popad
	iret


init_pic:
	mov al, 0x11
	out 0x20, al
	out 0xA0, al

	mov al, 0x20
	out 0x21, al
	mov al, 0x28
	out 0xA1, al
	
	mov al, 0x04
	out 0x21, al
	mov al, 0x02
	out 0xA1, al
	
	mov al, 0x01
	out 0x21, al
	out 0xA1, al
	
	mov al, 0xFF
	out 0x21, al
	out 0xA1, al
	ret

setup_idt:
	mov eax, int_handler_0
	mov word [idt + 0x00], ax
	mov word [idt + 0x02], 0x08
	mov byte [idt + 0x04], 0x00
	mov byte [idt + 0x05], 0x8E
	shr eax, 16
	mov word [idt + 0x06], ax

	mov eax, default_handler
	mov word [idt + 0x08], ax
	mov word [idt + 0x0A], 0x08
	mov byte [idt + 0x0C], 0x00
	mov byte [idt + 0x0D], 0x8E
	shr eax, 16
	mov word [idt + 0x0E], ax
	
	lidt [idt_descriptor]

	call init_pic

	sti 
	ret
