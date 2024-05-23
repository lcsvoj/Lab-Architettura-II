	.data
askinput:	.asciiz "Inserici un intero: "
printinput:	.asciiz "L'intero inserito è "
printnext:	.asciiz "Il suo successivo è "
newline:	.asciiz "\n"
		.align 2
A:		.space 8

	.text
	.globl main
main:
	# ask for innput
	li $v0 4 	# print_string code
	la $a0 askinput
	syscall
	
	# read input
	li $v0 5	# read_int code
	syscall
	move $s0 $v0	# s0 <- input
	
	# compute sucessor
	addi $s1 $s0 1	# s1 <- input+1
	
	# load them into array A
	la $s2 A
	sw $s0 ($s2)	# A[0] <- s0 (input)
	sw $s1 4($s2)	# A[1] <- s1 (input+1)
	
	# print result
	li $v0 4	# print_string code
	la $a0 printinput
	syscall
	
	li $v0 1	# print_int code
	lw $a0 ($s2)	# a0 <- input
	syscall
	
	li $v0 4	# print_string code
	la $a0 newline
	syscall
	
	li $v0 4	# print_string code
	la $a0 printnext
	syscall
	
	li $v0 1	# print_int code
	lw $a0 4($s2)	# a0 <- input+1
	syscall
	
	# exit program
	li $v0 10
	syscall