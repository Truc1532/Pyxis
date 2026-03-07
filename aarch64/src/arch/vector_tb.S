.section .rodata
panic_msg:
	.asciz "REACHED EXCEPTION\r\n"

.section .vectors, "ax"
.align 11
.global vectors
.extern asm_uputs

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
	msr daifset, #0xf
	ldr x0, =panic_msg
	bl asm_uputs

1:
	wfe 
	b 1b
	
