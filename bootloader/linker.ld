OUTPUT_ARCH("riscv")

ENTRY(_start)

SECTIONS
{
    /*. = 0x80013880;*/
    . = 0x20000000;

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

    . = ALIGN( 0x1000 );
    .stack :
    {
        *(.stack stack.*)
    }
}
