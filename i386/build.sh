# compiling
echo "Compiling..."
nasm -f elf32 -o build/loader.o src/assembly/loader.asm
gcc -m32 -o build/main.o -c src/main.c
gcc -m32 -o build/time.o -c src/time.c

# linking
echo "Linking..."
gcc -m32 -r build/time.o build/main.o -o build/kernel.o
ld -T src/linker/linker.ld -m elf_i386 -o build/pyxis.bin build/kernel.o

# creating the iso
mkdir -p isodir/boot/grub/
cp build/pyxis.bin isodir/boot/
cp grub.cfg isodir/boot/grub/

grub-mkrescue -o pyxis.iso isodir/

