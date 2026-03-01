// const UART0_BASE: usize = 0x3F201000; <- raspi3b UART base address

const UART0_BASE: usize = 0x0900_0000;

const UART_DR: *mut u32 = (UART0_BASE + 0x00) as *mut u32;
const UART_FR: *const u32 = (UART0_BASE + 0x18) as *const u32;

const TXFF: u32 = 1 << 5;

fn uart_putc(c: u8) {
    unsafe {
        while UART_FR.read_volatile() & TXFF != 0 {}

        UART_DR.write_volatile(c as u32);
    }
}

pub fn uart_puts(s: &str) {
    for b in s.bytes() {
        uart_putc(b);
    }
}
 
pub fn uart_put_ptr(ptr: *const u8) {
    uart_putc(b'\n');
    uart_puts("0x");
    
    let val = ptr as usize;
    let mut started = false;

    for shift in (0..16).rev() {
        let digit = ((val >> (shift * 4)) & 0xF) as u8;
        if digit != 0 || started || shift == 0 {
            started = true;
            uart_putc(if digit < 10 { b'0' + digit } else { b'a' + (digit - 10) });
        }
    }
}


