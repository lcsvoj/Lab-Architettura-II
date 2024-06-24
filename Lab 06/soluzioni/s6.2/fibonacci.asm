	.data
	
	.text
	.globl main
main:
	li $a0 10
	jal fibonacci
	
	move $a0 $v0 
	li $v0 1
	syscall
	
	
	# Sys call exit.
	li $v0 10
	syscall

#-----------------------------------------------------
fibonacci:
	move $t0 $fp
	addi $fp $sp -4
	sw $t0 0($fp)
	sw $sp -4($fp)
	sw $ra -8($fp)
	sw $s0 -12($fp)
	sw $s1 -16($fp)
	addi $sp $fp -16
	
	beq $a0 0 caso_1
	beq $a0 1 caso_2
	
	# n>=2
	# return F(n-1) + F(n-2)
	
	# push a0
	addi $sp $sp -4
	sw $a0 0($sp)
	
	# F(n-1)
	addi $a0 $a0 -1
	jal fibonacci
	move $s0 $v0
	
	# Ricarico $a0
	lw $a0 0($sp)
	
	# F(n-2)
	addi $a0 $a0 -2
	jal fibonacci
	move $s1 $v0
	
	add $v0 $s0 $s1
	j fine_fibo
	
caso_2:
	li $v0 1
	j fine_fibo
caso_1:
	li $v0 0
	j fine_fibo
	
fine_fibo:
	lw $s1 -16($fp)
	lw $s0 -12($fp)
	lw $ra -8($fp)
	lw $sp -4($fp)
	lw $fp 0($fp)
	
	jr $ra
