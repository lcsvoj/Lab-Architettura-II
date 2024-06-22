		.data 
JUMP_TABLE:	.word	case0, case1, case2
	.text
main:
				bltz	$t0, END_SWITCH
				li	$t1, 2
				bgt	$t0, $t1, END_SWITCH

				sll	$t0, $t0, 2
				la	$a0, JUMP_TABLE
				add	$a0, $a0, $t0
				lw	$t2, 0($a0)
				jr	$t2

case0:		add	$s0, $s0, 1
				b	END_SWITCH
case1:		add	$s0, $s0, 2
				b	END_SWITCH
case2:		add	$s0, $s0, 3
				b	END_SWITCH
END_SWITCH:
