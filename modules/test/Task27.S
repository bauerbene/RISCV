	.text
	.global main

main:
	addi x2, zero, 16
    sub x2, zero, x2
	sra x3, x2, 4
	srl x4, x2, 4
	
	addi x5, zero, 16
	sra x6, x5, 4
	srl x7, x5, 4
