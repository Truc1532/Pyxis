#include <stdint.h>

// #define UART0_BASE 0x3F201000 <- raspi3b UART BASE, won't work on -M virt

#define UART0_BASE 0x09000000

#define UART_DR ((volatile uint32_t*)(UART0_BASE + 0x00))
#define UART_FR ((volatile uint32_t*)(UART0_BASE + 0x18))

void uart_putc(char c) {
	while (*UART_FR & (1 << 5));

	*UART_DR = c;
}

void uart_puts(const char *s) {
	while (*s) {
		uart_putc(*s++);
	}
}

void uart_put_ptr(const void *ptr) {
	uart_putc('\n');
	uart_puts("0x");

	uintptr_t val = (uintptr_t)ptr;
	int started = 0;

	for (int shift = 15; shift >= 0; shift--) {
		uint8_t digit = (val >> (shift * 4)) & 0xF;
		if (digit != 0 || started || shift == 0) {
			started = 1;
			if (digit < 10) {
				uart_putc('0' + digit);
			} else {
				uart_putc('a' + (digit - 10));
			}
		}
	}
}
