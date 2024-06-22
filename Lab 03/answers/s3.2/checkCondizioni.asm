	.data
ask_a:	.asciiz "a = "
ask_b:	.asciiz "b = "
ask_c:	.asciiz "c = "
error:	.asciiz "error\n"

	.text
	.globl main
main:
	# ask, get and save value for a
	la $a0 ask_a		# ask
	li $v0 4
	syscall
	
	li $v0 5		# get
	syscall
	move $s0 $v0		# save s0 <- a
	
	# ask, get and save value for b
	la $a0 ask_b		# ask
	li $v0 4
	syscall
	
	li $v0 5		# get
	syscall
	move $s1 $v0		# save s1 <- b
	
	# ask, get and save value for c
	la $a0 ask_c		# ask
	li $v0 4
	syscall
	
	li $v0 5		# get
	syscall
	move $s2 $v0		# save s2 <- c
	
	beq $s2 $0 print_error	# if c == 0, print_error
	blt $s0 $s1 print_error	# if a < b, print_error
	
	# else, print z = c(a+b)
	add $t0 $s0 $s1		# t0 <- a+b
	mul $a0 $s2 $t0		# a0 <- c(a+b)
	li $v0 1
	syscall
	
	beq $0 $0 exit

print_error:
	la $a0 error
	li $v0 4
	syscall
	beq $0 $0 exit
	
exit:
	li $v0 10
	syscall
	