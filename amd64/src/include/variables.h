// functions
extern void update_cursor();
extern void clear();
extern void delay();
extern void end_line();
extern void print();
extern void itoa();
extern void execute_command();
extern char getchar();
extern void gets();
extern void setup_idt();

// time/date functions
extern void print_date();
extern void print_time();

// cpuinfo functions
extern void cpuid();
extern void print_cpuinfo();

// filesystems;
extern void ls_iso9660();
