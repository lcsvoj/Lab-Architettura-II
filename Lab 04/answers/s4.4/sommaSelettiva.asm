	.data
		.align 2
array:		.space 200
insert_N:	.asciiz "Inserisci la dimensione dell'array (from 1 to 50): "
error_N_max:	.asciiz "Dimensione invalida (massimo: 50)\n"
error_N_min:	.asciiz "Dimensione invalida (minimo: 1)\n"
insert_int1:	.asciiz "Inserisci un valore per array["
insert_int2:	.asciiz "]: "
insert_k:	.asciiz "\nInserisci il parametro (k = [0: somma elementi dispari, 1: somma elementi pari]): "
error_k:	.asciiz "Parametro invalido (scegli tra 0 o 1)\n"
result:		.asciiz "Somma = "

	.text
	.globl main
main:
	la $s1 array		# s1 <- address of array
	
ask_N:	
	li $v0 4		# ask for the size of the array (N)
	la $a0 insert_N
	syscall
	
	li $v0 5
	syscall
	move $s0 $v0		# $s0 <- N
	
	bgt $s0 50 err_N_max	# if 1 <= N <= 50 , proceed; otherwise print an error message and ask again
	blt $s0 1 err_N_min
	j populate_array
	
err_N_max:
	li $v0 4
	la $a0 error_N_max
	syscall
	j ask_N

err_N_min:
	li $v0 4
	la $a0 error_N_min
	syscall
	j ask_N

populate_array:			# being $t0 := i, while (i < N) { ask for array[i] }, then ask for parameter
	bge $t0 $s0 ask_k	# if i >= N, break the loop
	
	# ask for array[i] value
	li $v0 4
	la $a0 insert_int1
	syscall
	
	li $v0 1
	move $a0 $t0
	syscall
	
	li $v0 4
	la $a0 insert_int2
	syscall
	
	# v0 <- array[i] value
	li $v0 5
	syscall
	
	# calculate the address of array[i]
	mul $t1 $t0 4		# t1 <- 4*i (offset)
	add $t1 $t1 $s1		# address of array[i]
	
	# store the input value for array[i]
	sw $v0 0($t1)		# offset(array[0]) <- $v0
	
	addi $t0 $t0 1		# i++
	j populate_array

ask_k:
	li $v0 4		# ask for k
	la $a0 insert_k
	syscall
	
	li $v0 5
	syscall
	move $s2 $v0		# s2 <- k
	
	# if k == 1 or k == 0, proceed; otherwise print an error message and ask again
	beq $s2 0 call_P
	beq $s2 1 call_P
	li $v0 4
	la $a0 error_k
	syscall
	j ask_k
	
call_P:
	move $a0 $s1
	move $a1 $s0
	move $a2 $s2
	
	jal P
	move $s3 $v0

print_result:
	li $v0 4
	la $a0 result
	syscall
	
	li $v0 1
	move $a0 $s3
	syscall
	
exit:
	li $v0 10
	syscall

# procedura P -----------------------------------------------------------------------------------------------------------
	# input:
	# 	$a0: address of array[0]
	#	$a1: N (size of the array)
	#	$a2: k (function parameter)
	# output: 
	#	$v0:
	#	  if k == 0: sum of values in odd indexes 
	#	  if k == 1: sum of values in even indexes
P:
	move $v0 $zero		# clean $v0
	beq $a2 0 k_is_0
	beq $a2 1 k_is_1
	
k_is_0:
	# loop through the values in the array, array[i]
	li $t0 1		# starting from i == 1
	j check_loop_odd

k_is_1:
	# loop through the values in the array, array[i]
	li $t0 0		# starting from i == 0
	j check_loop_even

check_loop_odd:
	bge $t0 $a1 break_loop	# break the loop if i >= N

loop_odd:
	# calculate the address of array[i]
	mul $t1 $t0 4		# t1 <- 4*i
	add $t1 $t1 $a0		# t1 <- 4*i + address of array[0]
	
	lw $t2 0($t1)		# t2 <- value of array[i]
	
	add $v0 $v0 $t2		# sum += value of array[i]
	
	addi $t0 $t0 2		# update the index for the next odd position
	j check_loop_odd
	
check_loop_even:
	bge $t0 $a1 break_loop	# break the loop if i >= N
	
loop_even:
	# calculate the address of array[i]
	mul $t1 $t0 4		# t1 <- 4*i
	add $t1 $t1 $a0		# t1 <- 4*i + address of array[0]
	
	lw $t2 0($t1)		# t2 <- value of array[i]
	
	add $v0 $v0 $t2		# sum += value of array[i]
	
	addi $t0 $t0 2		# update the index for the next even position
	j check_loop_even
	
break_loop:
	jr $ra
