        .text
        .globl  _start
_start:

    addi x2, x0, 1
    sb x2, 0(x0)
    lb x3, 0(x0)