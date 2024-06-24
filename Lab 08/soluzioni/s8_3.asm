	.data
	x: .space 9
	.text
	.globl main
main:

	# Chiamata a procedure per la conversione.
	li $a0 10
	la $a1 x
	jal converti_binario

	# Stampa stringa binaria.
	la $a0 x
	li $v0 4
	syscall

	li $v0 10
	syscall
	

converti_binario:
	
	# Inizializzo delle costanti (contatore di 8 bit e il numero 2 per la divisione)
	li $t0 8
	li $t1 2
	
	# Per comodità sposto l'indirizzo della stringa all'ultimo byte contenente 0 o 1.
	addi $a1 $a1 7
ciclo:	
	# Condizione del ciclo
	beq $t0 $zero fine_ciclo
	
	# Divido il numero per 2
	div $a0 $t1
	
	# Sposto il risultato in $a0 e il resto lo salvo nella stringa
	mflo $a0
	
	# Prelevo il resto e lo salvo in $t3
	mfhi $t3
	
	# Converto il resto da formato numero a valore ASCII
	addi $t3 $t3 48
	
	# Salvo il carattere nella stringa passata ($a1)
	sb $t3 0($a1)
	
	addi $t0 $t0 -1
	addi $a1 $a1 -1
	j ciclo
	
fine_ciclo:
	# Imposto il terminatore di stringa	
	sb $t0 9($a1)

	jr $ra