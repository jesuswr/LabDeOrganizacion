.kdata
	KEYBOARD_ADDR: .word 0xffff0000
.ktext

	lui	$t0,0xffff	#ffff0000
waitloop:
	lw	$t1,0($t0)	#control
	andi	$t1,$t1,0x0001
	beq	$t1,$0,waitloop
	lw	$a0,4($t0)	#data
	
	lw $v0, 4
	syscall 
	
	