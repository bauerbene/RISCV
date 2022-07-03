        .text
        .globl  _start
_start:
       li x3, 0x200000
       li x4, 0x200000
       add x4, x4, 4
       li x5, 0x200000
       add x5, x5, 8
       li x6, 0x200000
       add x6, x6, 0xc

	addi x8, zero, 0x100
	addi x9, zero, 0x200
	addi x10, zero, 0x300
	addi x11, zero, 0x400

	
loop:

	sw x9, 0(x3) #0x100
	sw x10, 0(x4) #0x200
	sw x11, 0(x5) #0x300
	sw x12, 0(x6) #0x400

	lw x12, 0(x3) #0x100
	lw x11, 0(x4) #0x200
	lw x10, 0(x5) #0x300
	lw x9, 0(x6)  #0x400

	sw x9, 0(x3) #0x400
	lw x9, 0(x5) #0x300	
	sw x9, 0(x6) #0x300
	lw x9, 0(x4) #0x200
	sw x9, 0(x5) #0x200

        j       loop
