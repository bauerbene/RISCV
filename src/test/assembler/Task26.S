	.text
	.global main

main:
	add x2, x0, 12
	add x11, x0, 11
	sub x2, x2, x11
	add x4, x0, 2021
	add x10, x0, 1996
	sub x6, x4, x10
	sll x7, x6, 1
	sll x6, x6, 2
	add x6, x6, x7
	sll x6, x6, 1
	add x6, x6, 5
	add x2, x2, x6
