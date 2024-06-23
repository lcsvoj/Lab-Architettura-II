	.data
error:	.asciiz "codice operazione invalido"
op_1:	.asciiz "primo operando = "
op_2: 	.asciiz "secondo operando = "
opcode:	.asciiz "(opcodes: sum = 1, dif = 2, mul = 3, div = 4 )\noperazione da eseguire: "
result:	.asciiz "result = "
remain:	.asciiz "\nremainder = "

	.text
	.globl main
	
main:
	li $v0 4	# ask for operation code
	la $a0 opcode
	syscall
	
	li $v0 5
	syscall
	move $s0 $v0	# s0 <- opcode
	
	li $v0 4	# ask for first operand
	la $a0 op_1
	syscall
	
	li $v0 5
	syscall
	move $s1 $v0	# s1 <- first operand
	
	li $v0 4	# ask for second operand
	la $a0 op_2
	syscall
	
	li $v0 5
	syscall
	move $s2 $v0	# s2 <- second operand
	
	# set the arguments and call the procedure
	move $a0 $s1	# a0 <- first operand
	move $a1 $s2	# a1 <- second operand
	move $a2 $s0	# a2 <- first operand	
	jal elaboratore
	
	# get the result
	move $s3 $v0	# s3 <- result
	
	# print the result
	li $v0 4
	la $a0 result
	syscall
	
	li $v0 1
	la $a0 0($s3)
	syscall
	
	# if it wasn't a division, end program
	bne $s0 4 exit
	
	# if it was a division, print also the remainder
	li $v0 4
	la $a0 remain
	syscall
	
	li $v0 1
	la $a0 0($v1)
	syscall
	
exit:
	li $v0 10
	syscall

elaboratore:
	# procedura che esegue la somma, differenza, moltiplicazione e divisione tra due numeri interi.
	# Input: i due operandi e un terzo parametro per la selezione dell’operazione.
	# Output: risultato (nel caso della divisione restituisce anche il resto).
	
	move $t0 $a0	# primo operando in t0
	move $t1 $a1	# secondo operando in t1
	move $t2 $a2	# tipo operazione in t2
	
	# operazione 1 = Sum 
	subi $t2 $t2 1
	beq $t2 $zero Sum

	# operazione 2 = Dif
	subi $t2 $t2 1
	beq $t2 $zero Dif
	
	# operazione 3 = Mul 
	subi $t2 $t2 1
	beq $t2 $zero Mul

	# operazione 4 = Div
	subi $t2 $t2 1
	beq $t2 $zero Div
	
	# other values: print error and exit
	li $v0 4
	la $a0 error
	syscall
	j exit
	
Sum:
	add $v0 $t0 $t1	
	jr $ra

Dif:
	sub $v0 $t0 $t1
	jr $ra
	
Mul:
	mul $v0 $t0 $t1
	jr $ra
	
Div:
	div $t0 $t1
	mflo $v0	# v0 <- quotient
	mfhi $v1	# v1 <- remainder
	jr $ra
