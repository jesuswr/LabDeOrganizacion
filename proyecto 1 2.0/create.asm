.text
	
create: 
	## This function initialices the list
	## It returns the address of the list head

	sw $ra, 0($sp)
	sw $s0, -4($sp)  
	addi $sp, $sp, -8
	
	
	addi $s0, $zero, -1 
	
	addi $a0, $zero, 16		# Allocating memory for list attributes and identifier
	
	jal malloc 
	
	beq $v0, -1, exception
	
	sw $s0, 0($v0) 			# An empty list holds first = -1
	sw $s0, 4($v0) 			# An empty list holds last = -1
	sw $zero, 8($v0) 				
	sw $s0, 12($v0) 		# All lists in the 16th position of its pointer address, have an identifier
					# with the value of 0xffffffff that let us verify that they're actually lists
	j exitCreate

	exception: 
	
		li $v0, -7
		
	exitCreate:
		lw $s0, 4($sp)
		lw $ra, 8($sp) 
	
		addi $sp, $sp, 8	
	
		jr $ra	
	


	

