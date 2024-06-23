	.data
A: 	.word 34,227,224,226,14,17,112,16 # matrice A
dimA: 	.word 8 # dimensione di A

	.text
	.globl main
main:
	la $t0, dimA

	la $a0, A	# base address
	lw $a1, 0($t0) # dimensione
	li $a2 1 # passo
	
	jal max
	# jal min
	
	# print int
	move $a0, $v0
	li $v0, 1
	syscall
	
	# exit
	li $v0, 10
	syscall
max:
	mul $t0, $a2, 4		#t0=offset tra el. (passo)
	move $t1, $a0		#t1=indirizzo prossimo el.
	lw $t2, 0($t1)		#t2=el. considerato
	j updatemax
loop:
	slt $t4, $zero, $a1
	beq $t4, 0, end
	lw $t2, 0($t1)
	slt $t3, $v0, $t2
	bne $t3, 1, continue
updatemax:
	move $v0, $t2	
continue:
	sub $a1, $a1, $a2
	add $t1, $t1, $t0
	j loop
end:
	jr $ra
