#!/bin/bash

ASM_DIR=src/assembly
RS_DIR=src
BUILD_DIR=build

set -e

aarch64-linux-gnu-as $ASM_DIR/boot.S -o build/boot.o

rustc $RS_DIR/main.rs --target aarch64-unknown-none -C opt-level=2 -C panic=abort --emit=obj -o $BUILD_DIR/main.o

aarch64-linux-gnu-ld -T linker.ld $BUILD_DIR/boot.o $BUILD_DIR/main.o -o kernel.elf

qemu-system-aarch64 -m 128M -M virt -cpu cortex-a53 -nographic -serial mon:stdio -kernel kernel.elf
