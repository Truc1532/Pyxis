#include "include/variables.h"
#include "include/functions.h"
#include "include/io.h"

#define screenWidth 80
#define screenHeight 25

char *video_mem = (char *)0xB8000;
int cursor_x = 0;
int cursor_y = 0;

void update_cursor() {
	unsigned short position = cursor_y * screenWidth + cursor_x;

	outb(0x3D4, 0x0E);
	outb(0x3D5, (unsigned char)(position >> 8));

	outb(0x3D4, 0x0F);
	outb(0x3D5, (unsigned char)(position & 0xFF));
}

void clear() {
	for (int i = 0; i < screenWidth * screenHeight * 2; i += 2) {
		video_mem[i] = ' ';
		video_mem[i + 1] = 0x07;
	}
	cursor_x = 0;
	cursor_y = 0;
	update_cursor();
}

void end_line() {
	cursor_x = 0;
	cursor_y++;
	if (cursor_y >= screenHeight) {
		clear();
	}
	update_cursor();
}

void print(char *text) {
	while (*text) {
		if (*text == '\n') {
			end_line();
		} else if (*text == '\b') {
			if (cursor_x > 0) {
				cursor_x--;
			} else if (cursor_y > 0) {
				cursor_y--;
				cursor_x = screenWidth - 1;
			}
			int offset = (cursor_y * screenWidth + cursor_x) * 2;
			video_mem[offset] = ' ';
			video_mem[offset + 1] = 0x07;
		} else {
			int offset = (cursor_y * screenWidth + cursor_x) * 2;
			video_mem[offset] = *text;
			video_mem[offset + 1] = 0x07;
			cursor_x++;
		}

		if (cursor_x >= screenWidth) {
			end_line();
		}
		text++;
	}
	update_cursor();

}

void kernel_main() {
	clear();
	print("Welcome to Pyxis 0.1!\n");
	print("Time: ");
	print_time();
	print("\nDate: ");
	print_date();

}
