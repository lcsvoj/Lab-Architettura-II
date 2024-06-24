	.data
	str_prima: .asciiz "Prima: "
	str_dopo: .asciiz "Dopo: "
	str_test: .asciiz "AaaZz"
	.text
	.globl main
main:
	# Stampo "Prima: ".
	la $a0 str_prima
	li $v0 4
	syscall

	# Stampo la stringa.
	la $a0 str_test
	li $v0 4
	syscall	
	
	# Stampo un "a capo".
	li $a0 10
	li $v0 11
	syscall
	
	la $a0 str_test
	jal converti
	
	# Stampo "Dopo: ".	
	la $a0 str_dopo
	li $v0 4
	syscall

	# Stampo la stringa convertita da minuscolo a maiuscolo.
	la $a0 str_test
	li $v0 4
	syscall	
	
	# Stampo un "a capo".
	li $a0 10
	li $v0 11
	syscall	
	
	# Sys call exit.
	li $v0 10
	syscall

#-----------------------------------------------------
converti:
	# $a0: indirizzo di memoria della stringa.
	
	# Preambolo: salvo $fp, $sp e $s0.
	move $t0 $fp
	addi $fp $sp -4 # Aggiorno il $fp per usarlo come riferimento.
	sw $t0 0($fp) # Salvo il vecchio $fp.
	sw $sp -4($fp)
	sw $s0 -8($fp)
	sw $ra -12($fp) # Salvo il return address visto che la funzione non è foglia.
	addi $sp $fp -12
	
	
	# Siccome $a0 verrà usato come input per la chiamata annidata e viene usato anche dal ciclo è 
	# necessario che $a0 rimanga inviariato prima e dopo la chiamata.
	# Per fare questo copio $a0 in $s0. Non è possibile usare un registro $t perchè non è garantito che 
	# la chiamata annidata non ne alteri il contenuto.

ciclo_converti:
	# Condizione del ciclo: verificiamo che il carattere sia il terminatore di stringa.
	lb $t0 0($a0)
	beq $t0 $zero fine_converti
	
	# Copio il valore di $a0 in $s0.
	move $s0 $a0
	
	# Chiamata annidata.
	move $a0 $t0
	jal converti_singolo_carattere
	
	# Ripristino il valore di $a0.
	move $a0 $s0
	
	# Modifico il carattere nella stringa.
	sb $v0 0($a0)
	
	# Muovo l'indirizzo al carattere successivo aggiungendo 1 solo byte e non 4.
	addi $a0 $a0 1 
	j ciclo_converti
	
fine_converti:

	# Epilogo.	
	lw $t0 0($fp) # Salvo il vecchio $fp.	
	lw $sp -4($fp)
	lw $s0 -8($fp)
	lw $ra -12($fp) # Salvo il return address visto che la funzione non è foglia.
	move $fp $t0 # Ripristino $fp.
	
	jr $ra
	
#-----------------------------------------------------
converti_singolo_carattere:
	# $a0: carattere in input.
	# $v0: carattere in output reso maiuscolo.
	
	# Preimposto l'output.
	move $v0 $a0
	
	# Se il carattere ascii è inferiore a 97 o maggiore a 122 allora non è un carattere da modificare.
	blt $a0 97 no_conversione
	bgt $a0 122 no_conversione
	
	# Converto il carattere.
	sub $v0 $v0 32
	
no_conversione:	
	jr $ra