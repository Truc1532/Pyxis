#[no_mangle]
pub extern "C" fn memset(dest: *mut u8, val: i32, count: usize) -> *mut u8 {
    let mut i = 0;

    unsafe { 
        while i < count {
            *dest.add(i) = val as u8;
            i += 1;
        }
    }

    dest
} 

#[no_mangle]
pub extern "C" fn memcpy(dest: *mut u8, src: *const u8, count: usize) -> *mut u8 {
    let mut i = 0;

    unsafe {
        while i < count {
            *dest.add(i) = *src.add(i);
            i += 1;
        }
    }

    dest
}
