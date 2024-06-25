	.data
ask_a:	.asciiz "a = "
ask_b:	.asciiz "b = "
output:	.asciiz "a*b =  "
	
	.text
	.globl main
main:
	li $v0 4		# ask for int a
	la $a0 ask_a
	syscall
	
	li $v0 5		# save a value into register
	syscall
	move $s0 $v0		# $s0 <- a
	
	li $v0 4		# ask for int b
	la $a0 ask_b
	syscall
	
	li $v0 5		# save b value into register
	syscall
	move $s1 $v0		# $s1 <- b
	
	move $a0 $s0
	move $a1 $s1
	jal prodotto_s
	move $s2 $v0		# $s2 <- a*b
	
	li $v0 4		# prepare to print output
	la $a0 output
	syscall
	
	li $v0 1		# print the result
	move $a0 $s2
	syscall

exit:
	li $v0 10
	syscall

# Procedura prodotto_s -----------------------------------------------------------------------------------------------------
#	input:
#		$a0: int a
#		$a1: int b
#	output: 
#		$v0: il prodotto a*b
#	oss. la procedura prodotto_s non utilizzi istruzioni di moltiplicazione ( mult et simila),
#	     ma calcoli il prodotto effettuando chiamate multiple alla procedura somma
# 	     Esempio: Il prodotto 3x2 è svolto come 3+3 oppure 2+2+2
prodotto_s:
	li $v0 0		# $v0 <- 0 (flush $v0)
	beq $a0 $zero end	# if a or b is zero, the result is zero
	beq $a1 $zero end
	
	subi $sp $sp 4		# push the value of $ra into the stack
	sw $ra 0($sp)
	
	move $t1 $a1		# $t1 <- b
	li $t2 0		# $t2 <- ( i := 0 )
	
loop:
	move $a1 $v0		# $a1 <- $v0
	jal sum			# $v0 <- (a + $v0)
	addi $t2 $t2 1		# i++
	blt $t2 $t1 loop	# if i <= b then go to next iteration, otherwise exit the loop
	
end:	
	lw $ra 0($sp)		# pop the value of $ra from the stack
	addi $sp $sp 4
	jr $ra		
	
# Procedura somma ----------------------------------------------------------------------------------------------------------
# 	input: 
#		$a0: int a 
#		$a1: int b
# 	output: 
#		$v0: la somma a+b
sum:
	add $v0 $a0 $a1
	jr $ra