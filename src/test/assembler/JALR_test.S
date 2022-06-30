    .text
    .globl main

main:
    li  x4, 0x00000010
    li  x5, 0x00000020
    jalr x6, x4, 8
    