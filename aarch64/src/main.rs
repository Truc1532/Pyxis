#![no_main] 
#![no_std]

use core::arch::asm;
use core::panic::PanicInfo;

mod uart;
mod mem;

#[no_mangle]
pub extern "C" fn kernel_main() -> ! {
    uart::uart_puts("THIS CODE IS RUNNING IN RUST\r\n");

    extern "C" {
        static __heap_start: u8;
        static __heap_end: u8;
    }

    let mut allocator = mem::BumpAllocator {
        heap_start: unsafe { &__heap_start as *const _ as usize },
        heap_end: unsafe { &__heap_end as *const _ as usize },
        next: unsafe { &__heap_start as *const _ as usize },
        
    };

    let ptr = allocator.alloc(100, 8); 

    uart::uart_put_ptr(ptr);

    let ptr2 = allocator.alloc(3, 8);

    uart::uart_put_ptr(ptr2);

    let test = 0xdead_beef as *const u8;

    uart::uart_put_ptr(test);

    loop {
        unsafe {
            asm!("wfe");
        }
    }
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    uart::uart_puts("PANICKED!!!");
    loop {
        unsafe {
            asm!("wfe");
        }
    }
}
