SRC_DIR="src"
BUILD_DIR="build"

echo "Compiling..."
nasm -f elf64 -o "$BUILD_DIR/boot.o" "$SRC_DIR/assembly/boot.asm"
nasm -f elf64 -o "$BUILD_DIR/boot64.o" "$SRC_DIR/assembly/boot64.asm"
nasm -f elf64 -o "$BUILD_DIR/header.o" "$SRC_DIR/assembly/header.asm"
# nasm -f elf64 -o idt.o src/assembly/idt.asm
x86_64-linux-gnu-gcc -o "$BUILD_DIR/main.o" -c "$SRC_DIR/main.c" -nostdlib -nostartfiles -nodefaultlibs
x86_64-linux-gnu-gcc -o "$BUILD_DIR/commands.o" -c "$SRC_DIR/commands.c" -nostdlib -nostartfiles -nodefaultlibs
x86_64-linux-gnu-gcc -o "$BUILD_DIR/time.o" -c "$SRC_DIR/time.c" -nostdlib -nostartfiles -nodefaultlibs
x86_64-linux-gnu-gcc -o "$BUILD_DIR/cpuinfo.o" -c "$SRC_DIR/cpuinfo.c" -nostdlib -nostartfiles -nodefaultlibs
x86_64-linux-gnu-gcc -o "$BUILD_DIR/strings.o" -c "$SRC_DIR/strings.c" -nostdlib -nostartfiles -nodefaultlibs

echo "Linking..."
x86_64-linux-gnu-gcc -r "$BUILD_DIR/time.o" "$BUILD_DIR/strings.o" "$BUILD_DIR/cpuinfo.o" "$BUILD_DIR/commands.o" "$BUILD_DIR/main.o" -o "$BUILD_DIR/kernel.o" -nostdlib -nostartfiles -nodefaultlibs
x86_64-linux-gnu-ld -T "$SRC_DIR/linker/linker.ld" -o "$BUILD_DIR/kernel.efi" "$BUILD_DIR/boot.o" "$BUILD_DIR/boot64.o" "$BUILD_DIR/header.o" "$BUILD_DIR/kernel.o"


mkdir -p isodir/boot/grub/
cp "$BUILD_DIR/kernel.efi" isodir/boot/
cp grub.cfg isodir/boot/grub/

grub-mkrescue -o pyxis.iso isodir/

qemu-system-x86_64 -cdrom pyxis.iso
