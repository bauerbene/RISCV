	.text
	.global main

main:
	add x2, x0, 0x2
    sw x2, 0x100(x0)
    lw x3, 0x100(x0)
    