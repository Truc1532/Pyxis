--DEPENDENCIES--
GCC cross compiler (x86_64-linux-gnu-gcc)
NASM
LD cross linker (x86_64-linux-gnu-ld)
QEMU (optional)
GRUB
XORRISO

--BUILDING--
First make a build dir:
mkdir build
And run the build script:
./build.sh

--NOTES--
Unlike the aarch64 kernel, this one can run on real hardware. But only via BIOS or BIOS emulation which most computers should have. Doesn't support UEFI yet. 
