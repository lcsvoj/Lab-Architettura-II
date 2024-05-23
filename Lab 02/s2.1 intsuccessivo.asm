	.data
msg1:	.asciiz "Inserisci un intero: "
msg2:	.asciiz "Intero successivo: "

	.text
	.globl main
main:
	# ask for the input
	li $v0 4	# print_string code
	la $a0 msg1	# a0 <- address of the string
	syscall
	
	# read the input
	li $v0 5	# read_int code
	syscall
	add $s0 $v0 1	# a0 <- input+1
	
	# print the result
	li $v0 4 	# print_string code
	la $a0 msg2
	syscall
	
	li $v0 1	# print_int code
	la $a0 ($s0)
	syscall