	.data
ask_input: 	.asciiz "Inserisci un intero: "

	.text
	.globl main
	
main:
	# print the string aking for the input
	li $v0 4
	la $a0 ask_input
	syscall
	
	# get the integer input (n)
	li $v0 5
	syscall
	move $a0 $v0		# a0 <- n
	
	# test if n is odd (n % 2 != 0)
	li $s1 2
	div $a0 $s1
	mfhi $s2		# s2 <- remainder
	bne $s2 $0 end		# if remainder != 0, it's odd, go to end
	addi $a0 $a0 1		# if not odd, let's prepare a0 for end to print correctly (n + 2)
	
end:

	# print (a0 + 1)
	addi $a0 $a0 1
	li $v0 1
	syscall
		
	# exit
	li $v0 10
	syscall