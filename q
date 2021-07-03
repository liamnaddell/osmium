#!/bin/sh
qemu-system-riscv32 -s -S -M virt -nographic -bios kernel/bin/osmium
#qemu-system-riscv32 -M virt -nographic -kernel kernel/bin/osmium -bios none
