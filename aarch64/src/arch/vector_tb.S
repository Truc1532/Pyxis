.section .vectors, "ax"
.extern uart_putc
.align 11
.global vectors

vectors:

b panic
.align 7

b panic
.align 7

b panic
.align 7

b panic
.align 7

b panic
.align 7

b panic
.align 7

b panic
.align 7

b panic
.align 7

.rept 8
	b panic
	.align 7
.endr

panic:
	mov x0, #'E'
	bl uart_putc
	b panic_2
panic_2:	
	wfe 
	b panic_2
