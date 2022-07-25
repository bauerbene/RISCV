    .text
    .global main

main:
    lui x1, 0x12
    addi x1, x1, 0x345
    lui x2, 0x98
    addi x2, x2, 0x765
    lui x3, 0x22
    addi x3, x3, 0x222 
    lui x4, 0x11
    addi x4, x4, 0x111

    # encrypt register
    # csrw 0x1, rs
    # encrypt input of x1 & x2 & x3 & x4 and write result to x1, - x4
    csrw 0x1, x1

    # decrypt register
    # csrw 0x2, rs
    # decrypt input of x1 & x2 & x3 & x4 and write result to x1 - x4
    csrw 0x2, x1

    # encrypt memory
    # csrs imm, rs
    # encrypt the next 128 bit memory on position imm + rs 
    csrs 0x200, x1

    # decrypt memory
    # csrc imm, rs
    # decrypt the next 128 bit memory on position imm  +rs
    csrc 0x200, x1
    



