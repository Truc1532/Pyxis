#![no_main] 
#![no_std]

use core::arch::asm;
use core::panic::PanicInfo;

mod uart;
mod bump;
mod mem;

extern "C" {
	static __heap_start: u8;
    static __heap_end: u8;
}


#[no_mangle]
pub extern "C" fn kernel_main(el: u64) -> ! {
    uart::uput_ptr(el as *const u8);

	unsafe {
        uart::uputs("HEAP_START: ");
        uart::uput_ptr(&__heap_start);
        uart::uputs("HEAP_END: ");
        uart::uput_ptr(&__heap_end);
    }

    let mut allocator = bump::BumpAllocator {
        heap_start: unsafe { &__heap_start as *const _ as usize },
        heap_end: unsafe { &__heap_end as *const _ as usize },
        next: unsafe { &__heap_start as *const _ as usize },
        
    };

    let ptr = allocator.alloc(100, 8); 
    let ptr2 = allocator.alloc(3, 8);

    uart::uput_ptr(ptr);
    uart::uput_ptr(ptr2);

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
