# eseguire A[c-1] = c*(B[A[c]] + c)/A[2*c-1]
	.data
A:	.word -1, -1, 1, 4
B:	.word -1, 6, -1, -1
c:	.word 2

	.text
	.globl main
main:
	# indirizzi delle variabili
	la $s0 A
	la $s1 B
	la $s2 c
	
	li $s3 4		# costante per calcolare l'offset
	lw $s4 c		# s4 <- valore di c
	
	# calcolare il dividendo di A[c-1]
	mul $t0 $s4 $s3		# t0 <- offset per A[c]
	add $t0 $s0 $t0		# t0 <- indirizzo di A[c]
	lw $t1 ($t0)	 	# t1 <- A[c]
	
	mul $t0 $t1 $s3		# t0 <- offset per B[A[c]]
	add $t0 $s1 $t0		# t0 <- indirizzo di B[A[c]]
	lw $t1 ($t0)		# t1 <- B[A[c]]
	
	add $t1 $t1 $s4		# t1 <- B[A[c]] + c
	mul $t1 $t1 $s4		# t1 <- c*(B[A[c]] + c)
	
	# calcolare il divisore di A[c-1]
	mul $t0 $s4 2		# t0 <- 2*c
	sub $t0 $t0 1		# t0 <- 2*c-1
	mul $t0 $t0 $s3		# t0 <- offset per A[2*c-1]
	add $t0 $s0 $t0		# t0 <- indirizzo per A[2*c-1]
	lw $t2 ($t0)		# t2 <- A[2*c-1]
	
	# salvare A[c-1] = c*(B[A[c]] + c)/A[2*c-1]
	sub $t0 $s4 1		# t0 <- c-1
	mul $t0 $t0 $s3		# t0 <- offset di A[c-1]
	add $t0 $s0 $t0		# t0 <- indirizzo di A[c-1]
	div $t3 $t1 $t2		# t3 <- valore di A[c-1]
	sw $t3 ($t0)		# A[c-1] <- t3
	