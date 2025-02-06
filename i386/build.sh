BUILD_DIR="build"
SRC_DIR="src"

if [ -d "$BUILD_DIR" ]; then
	rm -rf build/*
else
	mkdir "$BUILD_DIR"
fi

# compiling
echo "Compiling..."
nasm -f elf32 -o "$BUILD_DIR/loader.o" "$SRC_DIR/assembly/loader.asm"
gcc -m32 -o "$BUILD_DIR/main.o" -c "$SRC_DIR/main.c"
gcc -m32 -o "build/time.o" -c "src/time.c"

# linking
echo "Linking..."
gcc -m32 -r "$BUILD_DIR/time.o" "$BUILD_DIR/main.o" -o "$BUILD_DIR/kernel.o"
ld -T src/linker/linker.ld -m elf_i386 -o "$BUILD_DIR/pyxis.bin" "$BUILD_DIR/kernel.o"

# creating the iso
mkdir -p isodir/boot/grub/
cp build/pyxis.bin isodir/boot/
cp grub.cfg isodir/boot/grub/

grub-mkrescue -o pyxis.iso isodir/

