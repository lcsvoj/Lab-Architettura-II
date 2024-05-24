	.data
v:	.byte 2,0,0,0,4,0,0,0	# crea un vettore con 8 bytes (2 words): v = [2, 4]
array:	.byte 2,0,0,0,3,0,0,0,5,0,0,0,7,0,0,0,11,0,0,0,13,0,0,0,17,0,0,0,19,0,0,0	# crea un array con 32 bytes (8 words)
											# array = [2, 3, 5, 7, 11, 13, 17, 19]
	.text
	.globl main
main:
	la $s1 array	# s1 <- indirizzo di array[0]
	la $s2 v	# s2 <- indirizzo di v[0]

	lw $t0 0($s2)	# t0 <- v[0] = 2
	addi $t0 $t0 -1	# t0 <- 1
	mul $t0 $t0 4	# t0 <- 4
	add $t1 $s1 $t0 # t1 <- indirizzo di 4(array[0]) = array[1]
	lw $t2 0($t1)	# t2 <- array[1] = 3
	addi $t2 $t2 1	# t2 <- 4

	lw $t0 4($s2)	# t0 <- v[1] = 4
	addi $t0 $t0 -1	# t0 <- 3
	mul $t0 $t0 4	# t0 <- 12
	add $t3 $s1 $t0	# t3 <- 12(array[0]) = array[3]
	lw $t4 0($t3)	# t4 <- array[3] = 7
	addi $t4 $t4 -1	# t4 <- 6

	sw $t2 0($t3)	# array[3] <- 4
	sw $t4 0($t1)	# array[1] <- 6

	# exit program
	li $v0 10
	syscall
