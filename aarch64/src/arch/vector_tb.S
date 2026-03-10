.section .vectors, "ax"
.balign 2048
.global vectors
.extern asm_uputs

.macro VECTOR handler
	b \handler
	.space 128 - 4
.endm

vectors:

// Current EL with SP0
VECTOR panic
VECTOR panic
VECTOR panic
VECTOR panic

// Current EL with SPx 
VECTOR panic
VECTOR panic
VECTOR panic
VECTOR panic

// Lower EL using AArch64
VECTOR panic
VECTOR panic
VECTOR panic
VECTOR panic

// Lower EL using AArch32
VECTOR panic
VECTOR panic
VECTOR panic
VECTOR panic

.section .rodata
panic_msg:
	.asciz "REACHED EXCEPTION\r\n"

.section .text
panic:
	msr daifset, #0xf 

	ldr x0, =panic_msg
	bl asm_uputs
1:
	wfe
	b 1b
