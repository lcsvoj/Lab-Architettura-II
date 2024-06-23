	.data
A:	.word 34, 227, 224, 226, 14, 17, 112, 16
N:	.word 8
str_min:.asciiz "valore minimo: "
str_max:.asciiz "\nvalore massimo: "

	.text
	.globl main
main:
	# set the arguments and call the procedure
	la $a0 N
	la $a1 A
	
	# find the lowest value and save it in s0
	jal min
	move $s0 $v0
	
	# find the biggest value and save it in s1
	jal max
	move $s1 $v0
	
	# print the lowest value
	li $v0 4
	la $a0 str_min
	syscall
	
	li $v0 1
	move $a0 $s0
	syscall
	
	# print the biggest value
	li $v0 4
	la $a0 str_max
	syscall
	
	li $v0 1
	move $a0 $s1
	syscall
	
exit:
	li $v0 10
	syscall
	
# procedura min ----------------------------------------------------------------------------------------
	# Input: un intero N ($a0) e un array A di N interi ($a1)
	# Output: il valore minimo in A ($v0)
min:
	# move the inputs to temporary registers
	lw $t0 0($a0)	# t0 <- N
	move $t1 $a1	# t1 <- address of A[0]
	
	# v0 will keep track of the smallest element in the array
	# we start setting it as the first element
	lw $v0 0($a1)	# v0 <- A[0]
	
	# initialize a counter i = 1 to keep track of the element A[i] being compared to v0, being i < N
	li $t2 1	# t2 <- i
	# and now loop through the array's elements comparing them
loop_min:
	# if i == N , all elements have been checked and we can don't enter the loop
	beq $t2 $t0 end_min
	
	# the register t6 holds the comparison result, it must be reset on each iteration
	move $t6 $zero
	
	# address of A[i] := address of A[0] + 4*i
	mul $t3 $t2 4	# t3 <- 4*i
	add $t4 $t1 $t3	# t4 <- address of A[i]
	
	# check if the value in A[i] is smaller than the one in v0
	lw $t5 0($t4)	# t5 <- value in A[i]
	slt $t6 $t5 $v0
	beq $t6 $zero continue_min	# t6 == 0 means v0 >= A[i] , then continue to next element
	
	# otherwise, means A[i] < v0 , then update v0 before continuing to next iteration
update_min:
	move $v0 $t5
	
continue_min:
	addi $t2 $t2 1	# update the counter value as i += 1
	j loop_min
	
end_min:
	jr $ra	# return, the lowest value is in v0
	
	
# procedura max ----------------------------------------------------------------------------------------
	# Input: un intero N ($a0) e un array A di N interi ($a1)
	# Output: il valore minimo in A ($v0)
max:
	# move the inputs to temporary registers
	lw $t0 0($a0)	# t0 <- N
	move $t1 $a1	# t1 <- address of A[0]
	
	# v0 will keep track of the biggest element in the array
	# we start setting it as the first element
	lw $v0 0($a1)	# v0 <- A[0]
	
	# initialize a counter i = 1 to keep track of the element A[i] being compared to v0, being i < N
	li $t2 1	# t2 <- i
 	# and now loop through the array's elements comparing them
loop_max:
	# if i == N , all elements have been checked and we can don't enter the loop
	beq $t2 $t0 end_max
	
	# the register t6 holds the comparison result, it must be reset on each iteration
	move $t6 $zero
	
	# address of A[i] := address of A[0] + 4*i
	mul $t3 $t2 4	# t3 <- 4*i
	add $t4 $t1 $t3	# t4 <- address of A[i]
	
	# check if the value in A[i] is bigger than the one in v0
	lw $t5 0($t4)	# t5 <- value in A[i]
	slt $t6 $v0 $t5
	bne $t6 $zero update_max	# t6 == 0 means A[i] >= v0 , then update v0
	# otherwise, just proceed to next element	
	
continue_max:
	addi $t2 $t2 1	# update the counter value as i += 1
	j loop_max
	
update_max:
	move $v0 $t5
	j continue_max	# and continue to check the next element
	
end_max:
	jr $ra	# return, the biggest value is in v0
