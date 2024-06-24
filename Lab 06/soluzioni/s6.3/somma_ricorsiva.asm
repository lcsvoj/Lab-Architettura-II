	.data
	A: .word 2 4 1 5
	.text
	.globl main
main:
	la $a0 A
	li $a1 4
	jal somma_ricorsiva
	
	move $a0 $v0 
	li $v0 1
	syscall
		
	# Sys call exit.
	li $v0 10
	syscall

#-----------------------------------------------------
somma_ricorsiva:
	move $t0 $fp
	addi $fp $sp -4
	sw $t0 0($fp)
	sw $sp -4($fp)
	sw $ra -8($fp)
	sw $s0 -12($fp)
	addi $sp $fp -12
	
	beq $a1 0 caso_base
	
	#return S(arr, dim-1) + arr[dim-1];
	addi $a1 $a1 -1	
	mul $t0 $a1 4
	add $t0 $a0 $t0
	lw $s0 0($t0)
		
	jal somma_ricorsiva
	
	add $v0 $v0 $s0
	
	j fine_somma
caso_base:
	li $v0 0
	
fine_somma:
	lw $s0 -12($fp)
	lw $ra -8($fp)
	lw $sp -4($fp)
	lw $fp 0($fp)
	
	jr $ra
