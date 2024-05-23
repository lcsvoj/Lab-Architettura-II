# Implement A = B+C-(D+E)
.text
.globl main

main:
	li $s1, 1		# B = 1
	li $s2, 2		# C = 2
	li $s3, 3		# D = 3
	li $s4, 4		# E = 4
	
	add $s0, $s1, $s2	# A = B + C
	add $t0, $s3, $s4	# t0 = D + E
	sub $s0, $s0, $t0	# A = B+C-t0 = B+C-(D+E)
	