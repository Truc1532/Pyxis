#ifndef MEM_H
#define MEM_H

#include <stdint.h>
#include <stddef.h>

struct BumpAllocator {
	size_t heap_start;
	size_t heap_end;
	size_t next;
};

uint8_t* alloc(struct BumpAllocator *ba, size_t size, size_t align);

extern struct BumpAllocator allocator;

#endif
