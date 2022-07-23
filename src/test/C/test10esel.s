	.file	"test10esel.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
 #APP
	.section ".entry"
	.global _start
	_start:
	li sp, 0x8000
	jal main
	.global _exit
	_exit:
	j _exit
	
 #NO_APP
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16
	li	a5,2037219328
	addi	a5,a5,-1736
 #APP
# 23 "test10esel.c" 1
	csrw 0x788, a5
# 0 "" 2
 #NO_APP
	li	a5,0
	mv	a0,a5
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 9.3.0"
