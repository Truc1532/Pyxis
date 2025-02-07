BUILD_DIR="build"
SRC_DIR="src"
LINKER_DIR="linker"

if [ -d "$BUILD_DIR" ]; then
	rm -rf build/*
else
	mkdir build
fi

# compiling
echo "Compiling..."
nasm -f elf64 -o "$BUILD_DIR/boot.o" "$SRC_DIR/assembly/boot.asm"
nasm -f elf64 -o "$BUILD_DIR/boot64.o" "$SRC_DIR/assembly/boot64.asm"
nasm -f elf64 -o "$BUILD_DIR/header.o" "$SRC_DIR/assembly/header.asm"
gcc -m64 -o "$BUILD_DIR/main.o" -c -ffreestanding "$SRC_DIR/main.c"
gcc -m64 -o "$BUILD_DIR/text.o" -c -ffreestanding "$SRC_DIR/text.c"
gcc -m64 -o "$BUILD_DIR/time.o" -c -ffreestanding "$SRC_DIR/time.c"


# linking
echo "Linking..."
gcc -m64 -r "$BUILD_DIR/time.o" "$BUILD_DIR/text.o" "$BUILD_DIR/main.o" -o "$BUILD_DIR/kernel.o"
ld -T "$SRC_DIR/$LINKER_DIR/linker.ld" -m elf_x86_64 -o "$BUILD_DIR/pyxis.bin" "$BUILD_DIR/kernel.o" "$BUILD_DIR/boot.o" "$BUILD_DIR/boot64.o" "$BUILD_DIR/header.o"

# creating the iso
mkdir -p isodir/boot/grub/
cp "$BUILD_DIR/pyxis.bin" isodir/boot/
cp grub.cfg isodir/boot/grub/

grub-mkrescue -o pyxis.iso isodir/

