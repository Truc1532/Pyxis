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

For the run.sh script, it asks which exception level (EL) to boot in. This is used for debugging, and if only trying out the kernel select EL1. 
At boot it says which EL it is in via hex:

0x4 - EL1
0x8 - EL2
0xC - EL3

When booting in EL3 nothing gets printed to the screen. That's caused because EL3 considers the UART driver as unsafe so it refuses to run it. 
