.section .text
.global _start
.extern kernel_main

_start:
	ldr x0, =stack_top
	mov sp, x0
	
	ldr x1, =__bss_start
	ldr x2, =__bss_end
1:	cmp x1, x2
	b.ge 2f
	// mov w3, #0
	// str w3, [x1], #4
	str xzr, [x1], #8
	b 1b
2:
	bl kernel_main	

halt:
	wfe
	b halt

.section .bss
.align 16
.stack:
	.skip 4096
.align 16
stack_top:

.align  16
.exc_stack:
	.skip 4096

.global __bss_start
.global __bss_end
