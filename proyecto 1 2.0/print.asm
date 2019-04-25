
.text

print:
	addi	$s1, $zero, 0	
	lw 	$s5, freeList
	lw 	$s0, freeListSize
	

	whileToPrint:
			beq 	$s0, $s1, exit
		
			lb	$a0, ($s5)
			li 	$v0 , 1
			syscall
			
			addi 	$s5, $s5, 1
			addi 	$s1, $s1, 1
			
			j whileToPrint
		
	exit:
			jr $ra
				
