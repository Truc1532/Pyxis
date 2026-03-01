pub struct BumpAllocator {
    pub heap_start: usize,
    pub heap_end: usize,
    pub next: usize,
}

fn align_up(addr: usize, align: usize) -> usize {
    (addr + align - 1) & !(align - 1)
}

impl BumpAllocator {
    pub fn alloc(&mut self, size: usize, align: usize) -> *mut u8 {
        let aligned_next = align_up(self.next, align);       
        if aligned_next + size > self.heap_end {
            core::ptr::null_mut()
        } else {
            let ptr = aligned_next;
            self.next = aligned_next + size;
            ptr as *mut u8
        }
    }

    unsafe fn alloc_zeroed(&mut self, size: usize, align: usize) -> *mut u8 {
        let ptr = self.alloc(size, align);
        if !ptr.is_null() {
            core::ptr::write_bytes(ptr, 0, size);
        }

        ptr
    }

    fn reset(&mut self) {
        self.next = self.heap_start;
    }
}
