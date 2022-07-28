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
    lui x5, 0x99
    addi x5, x5, 0x777
    lui x6, 0x88
    addi x6, x6, 0x777
    lui x7, 0x77
    addi x7, x7, 0x777
    lui x8, 0x66
    addi x8, x8, 0x666
    lui x9, 0x11
    addi x9, x9, 0x111
    lui x10, 0x22
    addi x10, x10, 0x222
    lui x11, 0x33
    addi x11, x11, 0x333
    lui x12, 0x44
    addi x12, x12, 0x444

    # encrypt register
    # csrw 0x1, rs
    # encrypt input of rs & rs+1 & rs+2 & rs+3 and write result to rs - rs+3
    csrw 0x1, x1
    csrw 0x1, x5
    csrw 0x1, x9

    # 10 nops (needed since encrypt is non blocking)
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0

    # decrypt register
    # csrw 0x2, rs
    # decrypt input of x1 & x2 & x3 & x4 and write result to x1 - x4
    csrw 0x2, x1
    csrw 0x2, x5
    csrw 0x2, x9

    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0

    # store encrypted
    # csrs imm, rs
    # encrypt the rs1 - rs4 and write encrypted to memory (address in rs2)
    #csrs 0rs1, rs2

    # encrypt 0x1 - 0x3 and write it to 0x2000 in memory
    lui x13, 0x2
    csrs 0x01, x13

    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0
    addi x0, x0, 0

    lw x15, 0(x13)
    lw x16, 4(x13)
    lw x17, 8(x13)
    lw x18, 12(x13)
    # load decrypted
    # csrc imm, rs
    # load from rs2 the next 128 bits encrypt those and write it back to rs1 - rs3
    # csrc 0rs1, rs2
    j main
    



