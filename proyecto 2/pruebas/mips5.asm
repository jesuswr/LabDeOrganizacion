break 0x10
add	$2, $2, $2
add	$7, $7, $7
add	$22, $22, $22
add	$20, $20, $zero

lw	$t0, ($s3)
		addi	$s5, $s5, -4
		
		whileToMove:
			addi	$t0, $t0, -4
			beq 	$t0, $s5, exitWhileToMove
			addi 	$t0, $t0, 4
			sub	$t1, $s5, $t0
			
			add 	$t1, $t1, $t2
			
			
			lw	$t3, ($t1)
			
			bgt	$t3,-1, moveInstruction
			
			j 	exitWhileToMove
			
			moveInstruction:
				sll	$t3, $t3, 2
				add	$t4, $t3, $s5
				lw	$t5, ($s5)
				sw	$t5, ($t4)
				
				addi	$s5, $s5, -4
				
				andi	$t6, $t5, 32
				beq	$t6, 32, checkForAdd
				
				j whileToMove
				
				checkForAdd:
					srl	$t5, $t5, 6
					andi	$t6, $t5, 31
					
					beqz	$t6, checkForAdd2
					
					j whileToMove
				
				checkForAdd2:
					srl	$t5, $t5, 20
					beqz	$t5, addBreak20
					
					j 	whileToMove
				
				addBreak20:
					addi 	$s5, $s5, 8
					addi	$t7, $t7, 0x0000080d
					sw	$t7, ($s5)
					addi	$s5, $s5, -8
					j whileToMove
			
			
		
		
		exitWhileToMove: