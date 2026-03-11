#![no_main] 
#![no_std]

use core::arch::asm;
use core::panic::PanicInfo;

#[macro_use]
mod uart;

mod bump;
mod mem;

extern "C" {
	static __heap_start: u8;
    static __heap_end: u8;
}


#[no_mangle]
pub extern "C" fn kernel_main(el: u64) -> ! {
    uart::put_hex(el);

	unsafe {
        uart::puts("HEAP_START: ");
        uart::put_ptr(&__heap_start);
        uart::puts("HEAP_END: ");
        uart::put_ptr(&__heap_end);
    }

    let mut allocator = bump::BumpAllocator {
        heap_start: unsafe { &__heap_start as *const _ as usize },
        heap_end: unsafe { &__heap_end as *const _ as usize },
        next: unsafe { &__heap_start as *const _ as usize },
        
    };

    let ptr = allocator.alloc(100, 8); 
    let ptr2 = allocator.alloc(3, 8);

	uart::puts("FIRST ALLOC AT: ");
    uart::put_ptr(ptr);
	uart::puts("SECOND ALLOC AT: ");
    uart::put_ptr(ptr2);

	unsafe { 
        asm!("svc #0"); 
    } 
    
    loop {
        unsafe { 
            asm!("wfe"); 
        }
    }

}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {
        unsafe { 
            asm!("wfe"); 
        }
    }
}
