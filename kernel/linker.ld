OUTPUT_ARCH("riscv")

ENTRY(_start)

MEMORY
{
    ram   (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS
{
    . = 0x80000000;

    .reset.boot :
    {
	*(.boot)
    }

    .text :
    {
        *(.text .text.*)
    }

    .rodata :
    {
        *(.rdata .rodata .rodata.*)
    }

    .data :
    {
        *(.data .data.*)
    }

    .bss :
    {
        *(.bss bss.*)
    }

    .programs :
    {
        *(.programs programs.*)
    }

    . = ALIGN( 0x1000 );
    .kernel_reserved_dram_aligned :
    {
        *(.kernel_aligned kernel_aligned.*)
    }
    PROVIDE(_kernel_end = .);

    PROVIDE(_memory_start = ORIGIN(ram));
    PROVIDE(_end_of_dram = ORIGIN(ram) + LENGTH(ram));
    PROVIDE(_stack = kernel_reserved_dram_aligned+0x80000);
    PROVIDE(_start_of_heap = _stack);
    PROVIDE(_size_of_heap = _end_of_dram-_stack);


}
