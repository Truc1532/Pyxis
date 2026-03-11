#!/bin/bash

ASM_DIR=src/arch
BUILD_DIR=build

AS=aarch64-linux-gnu-as

set -e

$AS $ASM_DIR/boot.S -o build/boot.o
$AS $ASM_DIR/vector_tb.S -o build/vectors.o

rustc src/main.rs --target aarch64-unknown-none -C opt-level=2 -C panic=abort --emit=obj -o $BUILD_DIR/main.o

aarch64-linux-gnu-ld -T linker.ld $BUILD_DIR/boot.o $BUILD_DIR/vectors.o $BUILD_DIR/main.o -o kernel.elf

#~/.rustup/toolchains/stable-aarch64-unknown-linux-gnu/lib/rustlib/aarch64-unknown-none/lib/libcore-*.rlib \
#~/.rustup/toolchains/stable-aarch64-unknown-linux-gnu/lib/rustlib/aarch64-unknown-none/lib/libcompiler_builtins-*.rlib \

./run.sh
