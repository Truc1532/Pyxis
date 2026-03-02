#!/bin/bash

ASM_DIR=src/arch
BUILD_DIR=build
AS=aarch64-linux-gnu-as
CC=aarch64-linux-gnu-gcc
LD=aarch64-linux-gnu-ld

set -e

$AS -o $BUILD_DIR/boot.o $ASM_DIR/boot.S
$AS -o $BUILD_DIR/vectors.o $ASM_DIR/vector_tb.S
$CC -o $BUILD_DIR/main.o -c src/main.c -ffreestanding -O2
$CC -o $BUILD_DIR/uart.o -c src/uart.c -ffreestanding -O2
$CC -o $BUILD_DIR/mem.o -c src/mem.c -ffreestanding -O2

$LD -T linker.ld -o kernel.elf $BUILD_DIR/boot.o $BUILD_DIR/vectors.o $BUILD_DIR/main.o $BUILD_DIR/uart.o $BUILD_DIR/mem.o

./run.sh
