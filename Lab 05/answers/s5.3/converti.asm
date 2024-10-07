# Scrivere una procedura converti che converta in maiuscolo una stringa in input. Si faccia uso di una seconda procedura 
# converti_singolo_carattere che converta solo una lettera minuscola alla volta.
# Non si fanno assunzione sul quali caratteri possa contenere la stringa in input.
# Suggerimento: usare SB e LB (StoreByte e LoadByte) per gestire dati non allineati.
# ----------------------------------------------------------------------------------------------------------------------
	.data
str_prima:	.asciiz "\nPrima: "	
str_dopo:	.asciiz "\nDopo: "
str_test: 	.asciiz "Lucas Vilela"
		
	.text
	.globl main
main:
	li $v0 4
	la $a0 str_prima
	syscall
	
	li $v0 4
	la $a0 str_test
	syscall

	la $a0 str_test
	jal converti
	
	li $v0 4
	la $a0 str_dopo
	syscall
	
	li $v0 4
	la $a0 str_test
	syscall

exit:
	li $v0 10
	syscall

# procedura converti ---------------------------------------------------------------------------------------------------
#	input: 
#		$a0: indirizzo di una stringa (str)
#	output:	none

converti:
	subi $sp $sp 4			
	sw $ra 0($sp)			# push $ra nello stack
	
	move $t0 $a0			# $t0 <- indirizzo di str[0]
loop:
	lb $t1 0($t0)			# $t1 <- carattere input di str[i]
	beq $t1 $zero end_converti	# finisce la procedura se arrivato il fine della stringa (NUL == 0)
	
	move $a0 $t1			# $a0 <- carattere input di str[i]
	jal converti_singolo_carattere	# $v0 <- carattere output
	sb $v0 0($t0)			# str[i] <- carattere output
	
	addi $t0 $t0 1			# atualizza indirizzo dell'elemento della stringa da str[i] a str[i+1]
	j loop				# procede alla prossima iterazione del ciclo
	
end_converti:
	lw $ra 0($sp)			# pop $ra dallo stack
	addi $sp $sp 4
	
	jr $ra
	
# procedura converti_singolo_carattere ---------------------------------------------------------------------------------------------------
#	input: 
#		$a0: carattere input
#	output:
#		$v0: carattere output

converti_singolo_carattere:
	# se non è una lettera minuscola, non deve essere cambiato
	move $v0 $a0		# imposta l'output default
	blt $a0 97 return	# prova se $a0 < 'a'
	bgt $a0 122 return	# prova se $a0 > 'z'
	
	subi $v0 $a0 32		# se è una lettera minuscola, converti in maiuscola (in ASCII vuol dire sottraire 32)
	
return:
	jr $ra