	.data
	.align 2
array:	.space 16	# Un array list che possa contenere un numero massimo di 4 elementi	
head:	.word 0		# Una variabile HEAD che indica la prima posizione libera in testa alla lista
	
	.text
	.globl main
main:
	la $s0 array		# $s0 <- address of array[0]
	la $s1 head		# $s1 <- address of head
	sw $s0 0($s1)		# array[0] is the initial head
	
	# inserisco 3 elementi
	la $a0 head
	li $a1 22
	jal insert
	
exit:
	li $v0 10
	syscall

# procedura insert: inserisci un elemento in testa alla lista --------------------------------------------------------------
#	input:
#		$a0: address of head (index of first available spot in the array)
#		$a1: element to be inserted
#	output:
#		none
insert:	
	lw $t0 0($a0)
	sw $a1 0($t0)
	addi $t0 $t0 4
	sw $t0 0($a0)

# procedura delete: cancella un elemento arbitrario della lista e ricompatta l’array ---------------------------------------
#	input:
#		$a0: array
#		$a1: head (index of first available spot in the array, highlighting the last element available to deletion)
#	output:
#		none
delete:
	j exit
