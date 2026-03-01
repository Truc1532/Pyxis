ENTRY(_start)

SECTIONS {
	. = 0x800000;
	
	.text : ALIGN(4K)
	{
		*(.text*)
	}

	.rodata : ALIGN(4K)
	{
		*(.rodata*)
	}

	.data : ALIGN(4K)
	{
		*(.data*)
	}

	.bss : ALIGN(4K)
	{
		__bss_start = .;
		*(.bss*)
		*(COMMON)
		__bss_end = .;
	}

	.heap : ALIGN(4K) {
		__heap_start = .;
		. += 64K;
		__heap_end = .;
	}

}
