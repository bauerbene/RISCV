        .text 
        .globl  _start
_start:
        li x3, 0x1000
        li x4, 0x1000
	addi x4, x4, 0x4
        li x5, 0x1000
	addi x5, x5, 0x8
	li x6, 0x1000
	addi x6, x6, 0xc

loop:
	addi x8, zero, 0x100
	addi x9, zero, 0x200
	addi x10, zero, 0x300
	addi x11, zero, 0x400
	
# ROM Accesses
	lh  x16, 0x82(x0) # 0x1234
	lw  x17, 0x80(x0) # 0x12345678
	lh  x18, 0x84(x0) # 0xffffbbcc
 	lhu x19, 0x86(x0) # 0xffaa	
	lb  x20, 0x86(x0) # 0xffffffaa 
	lbu x21, 0x87(x0) # 0xff
	sw  x21, 0x80(x0) # This mustn't change the RAM or ROM!
 
# RAM Accesses
			# address  data
	sw x8, 0(x3) 	# 0x1000   0x100
	sw x9, 0(x4) 	# 0x1004   0x200
	sw x10, 0(x5) 	# 0x1008   0x300
	sw x11, 0(x6) 	# 0x100c   0x400

	lw x12, 0(x3) 	# 0x1000   0x100
	lw x13, 0(x4) 	# 0x1004   0x200
	lw x14, 0(x5) 	# 0x1008   0x300
	lw x15, 0(x6)  	# 0x100c   0x400

	sw x15, 0(x3) 	# 0x1000   0x400
	lw x22, 0(x3) 	# 0x1000   0x400	
	sw x14, 0xc(x3)	# 0x100c   0x300
	sw x13, -4(x5) 	# 0x1004   0x200
	lw x23, 8(x4)	# 0x100c   0x300

        j       loop
	
# Address 0x80
	.word 0x12345678
	.word 0xffaabbcc	

