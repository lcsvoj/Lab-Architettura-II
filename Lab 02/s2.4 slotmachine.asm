	.data
msg1:	.asciiz "Quanti $ vuoi scommetere? "
msg2:	.asciiz "Saldo: $ "

	.text
	.globl main
main:	
	# ask for NUM
	li $v0 51	# InputDialogInt syscall code
	la $a0 msg1
	syscall
	move $s0 $a0	# s0 <- NUM
	
	# generate pseudorandom R in [-NUM,NUM]
	li $v0 42	# rand_int_range syscall code
	li $a0 0	# a0 <- seed
	
	# to use as range [-num, num] we may extract a prandom frofm 0 to
	# 2*num+1 and then subtract num from it
	mul $t0 $s0 2
	add $t0 $t0 1	# t0 <- 2*num+1
	
	move $a1 $t0	# a1 <- 2*num+1
	syscall		# a0 <- R
	sub $a0 $a0 $s0	# a0 <- R-num
	
	# compute RESULT = NUM + R
	add $s2 $s0 $a0	# s2 <- RESULT
	
	# print RESULT
	li $v0 56	# MessageDialogInt syscall code
	la $a0 msg2
	move $a1 $s2
	syscall
	
	# exit program
	li $v0 10	# exit syscall code
	syscall
	