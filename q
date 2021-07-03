#!/bin/sh
qemu-system-riscv32 -s -S -M virt -nographic -bios kernel/bin/osmium
