---BUILDING---
To build the kernel first allow build.sh to run as an executable
chmod +x build.sh

Then just run the script
./build.sh

---DEPENDENCIES---
GCC
NASM
XORRISO
GRUB

---INFO---
This is the i386 version meant to run on 32bit CPUs, this version does not support UEFI booting. It's only BIOS for now. To run it on hardware with UEFI enable legacy mode in the BIOS settings.
