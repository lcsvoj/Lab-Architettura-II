	.text
	.globl occorrenze
	
#INPUT
# $a0: indirizzo base stringa da analizzare
# $a1: carattere da contare
#OUTPUT
# $v0: numero di occorrenze del carattere
occorrenze:
	# PREAMBOLO
	move $t0 $fp
	addiu $fp $sp -4
	sw $t0 0($fp)
	sw $sp -4($fp)
	sw $ra -8($fp)
	sw $s0 -12($fp)
	sw $s1 -16($fp)
	addiu $sp $fp -16
	
	# CODICE
	lb $s0 0($a0)
	move $s1 $a1  # $s1 il carattere da cercare
	bne $s0 $zero occ
	li $v0 0   # se sono a fine stringa il numero di occorrenze e' zero!
	j end
occ:
	# occorenze(*STR, c) = occorrenze( *(STR+1), c) + ( STR[0] == c? 1 else 0)

	# chiamate ricorsiva
	# $a0 = $a0 +1  # sposto il l'indirizzo base al byte successivo
	addi $a0 $a0 1
	move $a1 $s1
	jal occorrenze
	# in $v0 ho il risulato ricorsivo 
	# if $s0 == $s1 : se il carattere iniziale della stringa e' uguale aggiungo 1
	bne $s0 $s1 end
	addi $v0 $v0 1
	
end:	
	# EPILOGO
	lw $t0 0($fp)
	lw $sp -4($fp)
	lw $ra -8($fp)
	lw $s0 -12($fp)
	lw $s1 -16($fp)
	move $fp $t0
	
	jr $ra