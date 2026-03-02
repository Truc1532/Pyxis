#include <stdint.h>

#include "uart.h"
#include "mem.h"

void hang(void) {
	while (1) {
		asm volatile ("wfe");
	}
}

void kernel_main(uint64_t el) {
	uart_put_ptr((void*)el);
	uart_puts("\n");
	uart_puts("THIS CODE IS RUNNING FROM C\n");

		
	uint8_t *ptr1 = alloc(&allocator, 3, 8);
	if (!ptr1) {
		uart_puts("Alloc failed\n");
		hang();
	}

	//uart_put_ptr(ptr1);

	const uint8_t *ptr = (const uint8_t *)0xdeadbeef;

	uart_put_ptr(ptr1);
	uart_put_ptr(ptr);

    asm volatile ("svc #0");

	hang();
}
