	.data
ask_sum:	.asciiz "Sum = "
ask_n: 		.asciiz "N = "
break_str:	.asciiz "break "

	.text
	.globl main
main:
	# ask and save the inputs
	li $v0 4
	la $a0 ask_sum
	syscall
	
	li $v0 5
	syscall
	move $s0 $v0		# s0 <- V
	
	li $v0 4
	la $a0 ask_n
	syscall
	
	li $v0 5
	syscall
	move $s1 $v0		# s1 <- N
	
	# save the sum in a different variable
	add $t0 $0 $s0		# t0 <- Sum
	
	# initialize a counter
	addi $t1 $0 1		# t1 <- ( i = 1)
	
loop:
	# check the counter limit (i < N)
	slt $t2 $t1 $s1		# ( t2 <- 1 ) if ( i < N )
	beq $t2 $0 end		# exits if the counter hits N
	
	# passed the counter check, enter the loop
	# check the internal condition ( (i*i) % V == 0 )
	mul $t3 $t1 $t1		# t3 <- (i*i)
	div $t3 $s0		# hi <- (i*i) % V
	mfhi $t4 		# t4 <- remainder
	
	beq $t4 $0 break_loop	# if remainder == 0 , break the loop

	add $t0 $t0 $t3		# update the Sum: s2 <- Sum += i*i
	addi $t1 $t1 1		# update the counter: s3 <- i++
	beq $0 $0 loop		# restart the loop

break_loop:
	li $v0 4
	la $a0 break_str
	syscall

end:
	# print the Sum	
	li $v0 1
	move $a0 $t0
	syscall
	
exit:
	li $v0 10
	syscall
