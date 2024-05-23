# Si scriva il codice Assembly che effettui: A[99] = 5 + B[i] + C

	.data
A:	.space 400	# 100 parole per A
B:	.space 400	# 100 parole per B
C:	.word 2
i:	.word 3

	.text
	.globl main
main:
	# indirizzi delle variabili
	la $s0 A
	la $s1 B
	la $s2 C
	la $s3 i
	
	# inizzializare B[i]
	li $t0, 4		# t0 <- 4 (costante per calcolo dell'offset)
	lw $t1, i		# t1 <- (i==3)
	mul $t2, $t0, $t1	# t2 <- (4*3==12, l'offset per B[i])
	li $t3, 10		# t3 <- 10
	add $t4, $s1, $t2	# t4 <- indirizzo di B[i]
	sw $t3, ($t4)		# B[i] <- t3
	
	# calcolo di (5 + B[i] + C)
	li $t1, 5		# t1 <- 5
	lw $t2, ($t4) 		# t2 <- valore di B[i]
	add $t1, $t1, $t2	# t1 <- (5 + B[i])
	lw $t2, ($s2)		# t2 <- valore di C
	add $t1, $t1, $t2	# t1 <- ((5 + B[i]) + C)
	
	# inizzializare A[99]
	li $t2, 99
	mul $t2, $t2, $t0	# t2 <- offset == 4*99 
	add $t2, $s0, $t2	# t2 <- indirizzo di A[99]
	sw $t1, ($t2)		# A[99] <- t1