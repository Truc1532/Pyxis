#include <stddef.h>
#include <stdint.h>

#include "uart.h"
#include "mem.h"

extern uint8_t __heap_start[];
extern uint8_t __heap_end[];

struct BumpAllocator allocator = {
	.heap_start = (size_t)__heap_start,
	.heap_end   = (size_t)__heap_end,
	.next       = (size_t)__heap_start
};

static size_t align_up(size_t addr, size_t align) {
	return (addr + align - 1) & ~(align - 1);
}

uint8_t* alloc(struct BumpAllocator *ba, size_t size, size_t align) {
	if ((align & (align - 1)) != 0) return NULL;

	size_t aligned_next = align_up(ba->next, align);
	if (aligned_next > ba->heap_end - size) {
		uart_puts("Ran out of memory !");
		return NULL;
	} else {
		uint8_t *ptr = (uint8_t*)aligned_next;
		ba->next = aligned_next + size;
		return ptr;
	}
}
