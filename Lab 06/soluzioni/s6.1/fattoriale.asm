	.data
	
	.text
	.globl main
main:
	li $a0 5
	jal fattoriale
	
	
	move $a0 $v0 
	li $v0 1
	syscall
	
	
	# Sys call exit.
	li $v0 10
	syscall

#-----------------------------------------------------
fattoriale:
	move $t0 $fp
	addi $fp $sp -4	
	sw $$t0 0($fp)	
	sw $sp -4($fp)
	sw $ra -8($fp)
	addi $sp $fp -8

	# $a0 contiene il numero.
	beq $a0 0 fine_caso_base

	# Push a0
	addi $sp $sp -4
	sw $a0 0($sp)
	
	# Preparo $a0 per la chiamata successiva
	addi $a0 $a0 -1
	jal fattoriale
	
	# Pop a0
	lw $a0 0($sp)
	addi $sp $sp 4
		
	mult $a0 $v0
	mflo $v0
	j fine_fattoriale	

fine_caso_base:
	li $v0 1

fine_fattoriale:	
	# Ripristino
	lw $ra -8($fp)
	lw $sp -4($fp)	
	lw $fp 0($fp)
	
	jr $ra
	
	