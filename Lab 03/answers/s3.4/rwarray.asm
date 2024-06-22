	.data
input_a:.asciiz "int a = "
input_b:.asciiz "int b = "
input_c:.asciiz "int c = "
default:.asciiz "\ncomando non riconosciuto\n"
	.align 2
array:	.word 0 1 2 3 4 5 6 7 8 9 10 11 12
A:	.space 4
B:	.space 4
C:	.space 4

	.text
	.globl main
main:
	# set the addresses for the variables array, a, b and c
	la $s0 array
	la $s1 A
	la $s2 B
	la $s3 C
	
	li $v0 4		# ask for input a
	la $a0 input_a		
	syscall
	
	li $v0 5		# store value of a
	syscall
	sw $v0 0($s1)		
	
	li $v0 4		# ask for input b
	la $a0 input_b		
	syscall
	
	li $v0 5		# store value of b
	syscall
	sw $v0 0($s2)		
	
	li $v0 4		# ask for input c
	la $a0 input_c		
	syscall
	
	li $v0 5		# store value of c
	syscall
	sw $v0 0($s3)		
	
	# calculate the addresses of array[a] and array[b] and save their values in registers
	lw $t2 0($s1)	# t2 <- a
	lw $t3 0($s2)	# t3 <- b
	
	mul $t5 $t2 4	# t5 <- 4*a (offset for array[a])
	mul $t6 $t3 4	# t6 <- 4*b (offset for array[b])
	
	add $t7 $s0 $t5	# t7 <- address of array[a]
	add $t8 $s0 $t6	# t8 <- address of array[b]
	
	lw $t4 0($t7)	# t4 <- value of array[a]
	lw $t2 0($t8)	# t2 <- value of array[b]
	
switch:
	lw $t0 0($s3)		# t0 <- c
	beq $t0 $0 switch_1	# if c == 0, go to switch_1
	
	addi $t1 $0 1		# t1 <- 1
	beq $t0 $t1 switch_2	# if c == 1, go to switch_2
	
	subi $t1 $0 1		# t1 <- -1
	beq $t0 $t1 switch_3	# if c == -1, go to switch_3
	
	# if the switch conditions are not yet fulfilled, print default
	li $v0 4
	la $a0 default
	syscall
	
	j exit
	
switch_1: # scambi l’a-esimo elemento dell’array con il b-esimo	
	sw $t4 0($t8)	# t8 <- t4
	sw $t2 0($t7)	# t7 <- t2
	j exit

switch_2: # sovrascriva il b-esimo elemento dell’array con il valore dell’a-esimo elemento
	sw $t4 0($t8)	# array[b] <- array[a]
	j exit

switch_3: # sovrascriva l’a-esimo elemento dell’array con il valore del b-esimo elemento
	sw $t2 0($t7)
	j exit
		
exit:
	li $v0 10
	syscall
