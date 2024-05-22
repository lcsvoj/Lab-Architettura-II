# Si implementi il codice Assembly che effettui la moltiplicazione e la divisione
# tra i numeri 100 e 45, utilizzando le istruzioni dell’ISA e le pseudoistruzioni
	
	.text
	.globl main

main:
	li $s0 100	# s0 <- 100
	li $s1 45	# s1 <- 45
	
	# moltiplicazione con istruzione MIPS
	mult $s0 $s1	# [Hi, Lo] <- s0*s1
	mflo $s2	# s2 <- Lo (risultato)
	# moltiplicazione con pseudo-istruzione
	mul $s2 $s0 $s1	
	
	# divisione con istruzioni MIPS
	div $s0 $s1	# Hi <- s0%s1 , Lo <- s0/s1
	mflo $s2	# s2 <- quoziente
	mfhi $s3 	# s3 <- resto
	# divisione con pseudo-istruzioni
	div $s3 $s0 $s1	# s3 <- s0/s1 , Hi <- s0%s1