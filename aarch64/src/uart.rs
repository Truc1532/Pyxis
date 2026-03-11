use core::fmt::{self, Write};

struct UartWriter;

// const UART0_BASE: usize = 0x3F201000; <- raspi3b UART base address

const UART0_BASE: usize = 0x0900_0000;

const UART_DR: *mut u32 = (UART0_BASE + 0x00) as *mut u32;
const UART_FR: *const u32 = (UART0_BASE + 0x18) as *const u32;

const TXFF: u32 = 1 << 5;

#[no_mangle]
pub extern "C" fn putc(c: u8) {
    unsafe {
        while UART_FR.read_volatile() & TXFF != 0 {}

        UART_DR.write_volatile(c as u32);
    }
}

pub fn puts(s: &str) {
    for b in s.bytes() {
        putc(b);
    }
}

pub fn put_u64(mut n: u64) {
    let mut buf = [0u8; 20];
    let mut i = 0;
    
    if n == 0 {
        putc(b'0');
        return;
    }

    while n > 0 {
        unsafe { *buf.get_unchecked_mut(i) = b'0' + (n % 10) as u8; }
        n /= 10;
        i += 1;
    }

    while i > 0 {
        i -= 1;
        unsafe { putc(*buf.get_unchecked_mut(i)); } 
    }
}

pub fn put_hex(n: u64) {
    puts("0x");

    for i in (0..16).rev() {
        let digit = ((n >> (i * 4)) & 0xf) as u8;

        putc(match digit {
            0..=9 => b'0' + digit,
            _ => b'a' + digit - 10,
        });
    }

    putc(b'\n');
}

pub fn put_ptr(ptr: *const u8) {
    put_hex(ptr as u64);
}

impl Write for UartWriter {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        for b in s.bytes() {
            putc(b);
        }
        Ok(())
    }
}

pub fn _print(args: fmt::Arguments) {
    let mut writer = UartWriter;
    let _ = writer.write_fmt(args);
}

#[macro_export]
macro_rules! print {
    ($($arg:tt)*) => ({
        $crate::uart::_print(format_args!($($arg)*));
    });
}

#[macro_export]
macro_rules! println {
    () => (print!("\n"));
    ($fmt:expr) => (print!(concat!($fmt, "\n")));
    ($fmt:expr, $($arg:tt)*) => 
        (print!(concat!($fmt, "\n"), $($arg)*));
}


// THE FUNCTION BELOW IS NOT TO BE USED/CALLED IN RUST CODE, IT'S MADE ONLY TO WORK IN ASSEMBLY !!!!
#[no_mangle]
pub extern "C" fn asm_uputs(ptr: *const u8) {
    unsafe {
        let mut p = ptr;
        while *p != 0 {
            putc(*p);
            p = p.add(1);
        }
    }
}

