.option norvc
.section .reset.boot, "ax",@progbits
.global _start
.global abort

_start:
    lui     sp, %hi(_stack)
    addi    sp, sp, %lo(_stack)
    /* Now jump to the rust world; __start_rust.  */
    j       __start_rust

.section .elfdata
.incbin "../misc/bin/nop"

.option norvc
.section .kernel_reserved_dram_aligned, "ax",@progbits
.global kernel_pgdir_ptr
kernel_pgdir_ptr:
    .skip 4096
.global temporary_pgdir_ptr
temporary_pgdir_ptr:
    .skip 4096

# (reserved region. used for page copies between two different memory spaces)
.global tmp_reserved_page
tmp_reserved_page:
    .skip 4096

# the following data is not aligned
.option norvc
.section .programs, "ax",@progbits
.global nop_start
nop_start:
    .incbin "../misc/bin/nop"
.global nop_end
nop_end:
.global loop_start
loop_start:
    .incbin "../misc/bin/loop"
.global loop_end
loop_end:
.global sh_start
sh_start:
    .incbin "../misc/bin/sh"
.global sh_end
sh_end:
.global syscaller_start
syscaller_start:
    .incbin "../misc/bin/syscaller"
.global syscaller_end
syscaller_end:
.global hello_start
hello_start:
    .incbin "../misc/bin/hello"
.global hello_end
hello_end:
.global tic_start
tic_start:
    .incbin "../misc/bin/tic"
.global tic_end
tic_end:
.global catch_ball_start
catch_ball_start:
    .incbin "../misc/bin/catch_ball"
.global catch_ball_end
catch_ball_end:
