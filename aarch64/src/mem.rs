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

#[no_mangle]
pub extern "C" fn memmove(dest: *mut u8, src: *const u8, count: usize) -> *mut u8 {
    unsafe {
        if (dest as usize) < (src as usize) {
            let mut i = 0;
            while i < count {
                *dest.add(i) = *src.add(i);
                i += 1;
            }
        } else {
            let mut i = count;
            while i != 0 { 
                i -= 1;
                *dest.add(i) = *src.add(i);
            }
        }
    }

    dest
}

#[no_mangle]
pub extern "C" fn memcmp(a: *const u8, b: *const u8, count: usize) -> i32 {
    unsafe {
        let mut i = 0;
        while i < count {
            let diff = *a.add(i) as i32 - *b.add(i) as i32;
            if diff != 0 {
                return diff;
            }
            i += 1;
        }
    }
    0
}
