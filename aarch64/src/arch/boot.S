.section .text
.global _start
.extern vectors
.extern kernel_main

_start:
	ldr x0, =stack_top
	and x0, x0, #-16
	mov sp, x0
	
	ldr x1, =__bss_start
	ldr x2, =__bss_end
1:	
	cmp x1, x2
	b.ge 2f
	str xzr, [x1], #8
	b 1b
2:
	ldr x0, =vectors
	msr VBAR_EL1, x0
	isb

	mrs x0, CurrentEL
	bl kernel_main
hang:
	wfe
	b hang

.section .stack

.align 16
stack:	
	.skip 4096
stack_top:
