	.data
	
A: 	.word 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56
h: 	.word 100

# # # # # # # # # # #

	.text
	.globl main
	
main:
	# get the adresses of the variables
	la $s1, h	# s1 <- indirizzo di h
	la $s2, A	# s2 <- indirizzo di A
	
	# get the value of h
	lw $t0, 0($s1)	# t0 <- contenuto di h
	
	# get the value of A[8]
	lw $t1, 32($s2)
	
	# calculate the value for A[12]
	add $t2, $t0, $t1	# t2 <- h + A[8]
	# get the address of A[12]
	sw  $t2, 48($s2)