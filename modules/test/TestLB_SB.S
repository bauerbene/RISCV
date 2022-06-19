        .text
        .globl  _start
_start:

    addi x2, x0, 1
    sh x2, 0x200(x0)
    lh x3, 0x200(x0)
