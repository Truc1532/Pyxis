#include "include/print.h"
#include "include/functions.h"

void kernel_main() {
	clear();
	set_color(PRINT_COLOR_LIGHT_GRAY, PRINT_COLOR_BLACK);
	print("Welcome to Pyxis 0.1!\n");
	print("Date: ");
	print_date();
	newline();
	print("Time: ");
	print_time();

	while (1) {
		asm volatile("hlt");
	}

}

