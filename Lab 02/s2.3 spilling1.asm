	.data
msg:	.asciiz "Result: "
	
	.text
	.globl main
main:
	# compute the result of 1*3 + 2*3 + 3*3
	
	# compute parcial result 1*3
	li $s0 3
	li $t0 1	# t0 <- 1
	mult $t0 $s0	# lo <- 1*3
	mflo $t0	# t0 <- 3
	# push the parcial result into the stack
	addi $sp $sp -4
	sw $t0 ($sp)
	
	# compute parcial result 2*3
	li $s0 3
	li $t0 2	# t0 <- 2
	mult $t0 $s0	# lo <- 2*3
	mflo $t0	# t0 <- 6
	# push the parcial result into the stack
	addi $sp $sp -4
	sw $t0 ($sp)
	
	# compute parcial result 3*3
	li $s0 3
	li $t0 3	# t0 <- 3
	mult $t0 $s0	# lo <- 3*3
	mflo $t0	# t0 <- 9
	# push the parcial result into the stack
	addi $sp $sp -4
	sw $t0 ($sp)
	
	# now pop the 3 last stack words containing the
	# partial results and add them together
	lw $t0 ($sp)	# t0 <- 9
	addi $sp $sp 4	
	add $s0 $t0 0	# s0 <- popped value
	
	lw $t0 ($sp)	# t0 <- 6
	addi $sp $sp 4
	add $s0 $s0 $t0	# add the popped value to s0
	
	lw $t0 ($sp)	# t0 <- 3
	addi $sp $sp 4
	add $s0 $s0 $t0	# add the popped value to s0
	
	li $v0 4	# print_string code
	la $a0 msg	
	syscall
	
	li $v0 1	# print_int code
	la $a0 ($s0)
	syscall
	