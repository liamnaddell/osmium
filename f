riscv32-unknown-elf-objcopy -O binary bootloader/bin/bootloader bootloader/bin/bootloader.bin

emu's uart addr:
static const uint32_t uart_rx_addr = 0x80000000;
static const uint32_t uart_tx_addr = 0x80000004; 


what happens to stdin?
should print setup!

bootloader thinks kernel starts at 0x50000
