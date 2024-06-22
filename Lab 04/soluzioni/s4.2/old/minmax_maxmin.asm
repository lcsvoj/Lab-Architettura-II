# INPUT 
# $a0: base address matrice
# $a1: dimensione matrice (righe)
# $a2: dimensione matrice (colonne)
# $a3: se 1 maxmin, se 0 minmax
# OUTPUT
# $v0: massimo tra i minimi su ogni riga se $a3=1, minimo tra i massimi su ogni riga se $a3=0

	.data
arr:	.space 256
	
	.text
	.globl maxmin_minmax
maxmin_minmax:

	addi $sp, $sp, -28
	# salvo $ra perche procedura non foglia
	sw $ra, 0($sp)
	# caller saved
	sw $s0, 4($sp)	
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	
	# parametri in registri saved
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	la $s3, arr		# dentro arr metterò i minimi di riga
	# copia extra di $a1 (numero di righe)
	move $s4, $a1
	move $s5, $a3

loopr:
	beq $s1, $zero, exit_loopr	# itero per ogni riga
	move $a0, $s0
	move $a1, $s2		# il num. di el. per righa è il num. di colonne
	li $a2, 1		# passo fissato a 1
	
	beq $s5, 1, L1
	jal max
	j L2
	
L1:
	jal min	
L2:	
	sw $v0, 0($s3)
	addi $s3, $s3, 4	
	
	mul $t0, $s2, 4		# t0=offset tra righe (num colonne X 4)
	add $s0, $s0, $t0	# in s0 base addr. della prossima riga
	add $s1, $s1, -1
	j loopr
	
exit_loopr:
	# calcolo il massimo su arr che ora contiene i minimi di riga
	la $a0, arr
	move $a1, $s4
	li $a2, 1
	beq $s5, 1, Q1
	jal min
	j end
Q1:
	jal max
		
end:
	lw $ra, 0($sp)
	lw $s0, 4($sp)	
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addi $sp, $sp, 28
	jr $ra
