	.data
	
	.text
	.globl main
main:
	# Alloco i due array.
	li $v0 9
	li $a0 8
	syscall	
	move $s0 $v0

	li $v0 9
	li $a0 8
	syscall	
	move $s1 $v0
	
	# Preparo gli elementi
	li $t0 3
	sw $t0 0($s0)
	li $t0 -3
	sw $t0 4($s0)
	
	# Chiamata a procedure per la conversione.	
	move $a0 $s0
	move $a1 $s1
	li $a2 2
	jal copia_invertito

	li $v0 10
	syscall
	
copia_invertito:
	# INPUT: 
	# $a0 indirizzo primo array
	# $a1 indirizzo secondo array
	# $a2 numero di elementi
	
	# Faccio puntare $a1 all'ultimo elemento del secondo array
	move $t0 $a2
	addi $t0 $t0 -1
	mul $t0 $t0 4	
	add $a1 $a1 $t0
	
	
ciclo:
	beq $a2 $zero fine_ciclo
	
	# Load e store dell'elemento corrente
	lw $t1 0($a0)
	sw $t1 0($a1)

	# Sposto gli indirizzi e aggiorno il contatore
	addi $a0 $a0 4
	addi $a1 $a1 -4
	addi $a2 $a2 -1

	j ciclo
		
fine_ciclo:

	jr $ra