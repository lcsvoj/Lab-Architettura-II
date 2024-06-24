	.data
str: .asciiz "prova occorrenze"

# versioni alternative: 
# 1 .ascii, ma dobbiamo prestare attenzione quando utilizziamo questa stringa con le syscall
# 2 .byte, ma dovremmo utilizzare il numero ASCII che rappresenta il carattere  
chr: .asciiz "e"  

msg: .asciiz "Numero di occorrenze in '"
msg2: .asciiz "' del carattere '"
msg3: .asciiz "': "
nl:   .asciiz "\n"

	.text
	.globl main

main:
	
	la $a0 str
	la $t0 chr
	# soluzione .asciiz prendo solo il primo byte (la stringa contiene il carattere nullo)
	lb $a1 0($t0)
	jal occorrenze
	move $t0 $v0

	# stampa del risultato
	li $v0 4
	la $a0 msg
	syscall
	# stringa in cui cercare
	li $v0 4
	la $a0 str
	syscall
	
	li $v0 4
	la $a0 msg2
	syscall
	# il carattere da contare
	li $v0 4
	la $a0 chr
	syscall
	li $v0 4
	la $a0 msg3
	syscall
	
	li $v0 1
	move $a0 $t0
	syscall
	li $v0 4
	la $a0 nl
	syscall
	
	# exit()
	li $v0 10
	syscall
	
