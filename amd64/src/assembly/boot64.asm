global long_mode_start
extern kernel_main
extern stack_top

section .text
bits 64
long_mode_start:
    mov ax, 0
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov rsp, stack_top
    and rsp, -16

	call kernel_main
    hlt
