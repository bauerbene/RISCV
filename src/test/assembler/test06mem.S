        .text
        .globl  _start
_start:
        ori     x1, x0, 0x100
        ori     x2, x0, 0x200
        ori     x3, x0, -1
        ori     x4, x0, 0x018

loop:

#                                address 	data
        sw      x1, 0x200(x0)	# 0x200		0x100
        sw      x2, 0x204(x0)   # 0x204      	0x200
        sw      x3, 0x108(x1)   # 0x208      	0xffffffff
        sw      x4, 0x00c(x2)   # 0x20c      	0x18


        lw      x5, 0x200(x0)	# 0x200 	0x100
        lw      x6, 0x204(x0)	# 0x204		0x200
        lw      x7, 0x108(x1)	# 0x208		0xffffffff
        lw      x8, 0x00c(x2)	# 0x20c		0x18

        mv      x9, x8
        mv      x10, x8
        mv      x11, x8
        mv      x12, x8

        sw      x5, 0x1f8(x8)	# 0x210		0x100
        sw      x6, 0x214(x0)	# 0x214		0x200
        sw      x7, 0x118(x1)	# 0x218		0xffffffff
        sw      x8, 0x01c(x2)	# 0x21c		0x18

        ori     x13, x0, 0x12
        ori     x14, x0, 0x34
        ori     x15, x0, 0x56
        ori     x16, x0, 0x78

        sb      x13, 0x223(x0)	# 0x223	 	0x12
        sb      x14, 0x222(x0)	# 0x222		0x34
        sb      x15, 0x121(x1)	# 0x221		0x56
        sb      x16, 0x020(x2)	# 0x220		0x78

        lw      x17, 0x220(x0)  # 0x220		0x12345678
        mv      x18, x17
        mv      x18, x17

        lui     x19, 0x98765
        addi    x19, x19, 0x432
        sw      x19, 0x224(x0)      # 0x224	0x98765432
        lui     x20, 0xfedcb
        addi    x20, x20, 0x298
        sw      x20, 0x228(x0)      # 0x228	0xfedcb298

        sh      x19, 0x22c(x0)
        sh      x20, 0x22e(x0)
        lw      x21, 0x22c(x0)      # 0x22c	0xb2985432

        lb      x22, 0x225(x0)      # 0x225	0x00000054
        lb      x22, 0x227(x0)      # 0x227	0xffffff98
        lbu     x22, 0x226(x0)      # 0x226 	0x00000076
        lbu     x22, 0x22a(x0)      # 0x22a	0x000000dc

        lh      x22, 0x224(x0)      # 0x224	0x00005432
        lh      x22, 0x228(x0)      # 0x228	0xffffb298
        lhu     x22, 0x224(x0)      # 0x224	0x00005432
        lhu     x22, 0x22a(x0)      # 0x22a	0x0000fedc

        j       loop
