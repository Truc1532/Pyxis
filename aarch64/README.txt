--DEPENDENCIES--
QEMU
GCC cross compiler (aarch64-linux-gnu-gcc)
RUSTC
RUSTUP
LD cross linker (aarch64-linux-gnu-ld)

--BUILDING--
If not already done run:
rustup target add aarch64-unknown-none

Then make a build dir:
mkdir build
And run the build script:
./build.sh

--NOTES--
This kernel is only meant to be ran on the -M virt option of QEMU and will not run on real hardware (including raspberry pi). Currently working on it and might work on actual hardware in the future. 
