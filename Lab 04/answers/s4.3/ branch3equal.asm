	.data
str_three:	.asciiz "Three equals"
str_zero:	.asciiz "Three different"
str_other:	.asciiz "No jump"

	.text
	.globl main
main:
	li $a0 1
	li $a1 1
	li $a2 1
	la $a3 addr1
	la $t0 addr2

	jal branch3equal

	li $v0 4
	la $a0 str_other
	syscall

exit:
	li $v0 10
	syscall
	
addr1:
	li $v0 4
	la $a0 str_zero
	syscall
	j exit

addr2:
	li $v0 4
	la $a0 str_three
	syscall
	j exit

# procedure branch3equal ---------------------------------------------------------------------------------------------------
	# Inputs: $a0 = int a, $a1 = int b, $a2 = int c
	#         $a3 = address addr1, $t0 = address addr2
	# Outputs: None
	# Funzionamento: 
		# Se i tre valori interi sono uguali viene fatto un salto al primo indirizzo del
		# segmento testo. Se i tre valori sono tutti diversi fra loro viene fatto un salto al
		# secondo indirizzo del segmento testo. In ogni altro caso, non viene effettuato
		# nessun salto e l’esecuzione procede da PC + 4
branch3equal:
	li $t1 0	# t1 <- (counter == 0)
	
ab:	# compare integers a and b
	bne $a0 $a1 ac		# skip the step of adding to the counter if not equal
	addi $t1 $t1 1		# add to the counter if equal
	
ac:	# compare integers a and c
	bne $a0 $a2 bc		# skip the step of adding to the counter if not equal
	addi $t1 $t1 1		# add to the counter if equal
	
bc:	# compare integers b and c
	bne $a1 $a2 check_count	# skip the step of adding to the counter if not equal
	addi $t1 $t1 1		# add to the counter if equal
	
check_count:	# check how many equalities have been found
	beq $t1 0 zero_equals	# if the 3 values are different, return to the address in $a3
	beq $t1 3 three_equals	# if the 3 values are the same, return to the address in $t0
	jr $ra			# in any other case, return to the normal flow
	
zero_equals:
	jr $a3
	
three_equals:
	jr $t0