	.data
s1:	.asciiz "Three equal"
s2:	.asciiz "Three different"
s3:	.asciiz "No jump"

	.text
	.globl main
main:
	sub $sp, $sp, 4
	sw $ra, 0($sp)

	li $a0, 3
	li $a1, 1
	li $a2, 2
	la $a3, A1

	sub $sp, $sp, 4
	la $t0, A2
	sw $t0, 0($sp)

	jal branch3equal
	j A3

# INPUT:
# $a0 $a1 $a2 tre interi
# $a3 primo indirizzo di salto
# sullo stack: secondo indirizzo di salto

	.text
	.globl branch3equal

branch3equal:
	# carico il quinto parametro (pop dallo stack)
	lw $t5 0($sp)
	add $sp $sp 4
	
	bne $a0 $a1 neq1
	# intero_0==intero_1
	beq $a1 $a2 jump1
	j nojump

neq1:
	# intero_0!=intero_1
	bne $a1 $a2 neq2
	j nojump

neq2:
	# intero_1!=intero_2
	bne $a0 $a2 jump2
	j nojump
jump1:
	jr $a3
jump2:
	# tutti diversi
	jr $t5
nojump:
	jr $ra

A1:
	li $v0, 4
	la $a0, s1
	syscall
	j end
A2:
	li $v0, 4
	la $a0, s2
	syscall
	j end
A3:
	li $v0, 4
	la $a0, s3
	syscall
end:
	li $v0 10
	syscall
