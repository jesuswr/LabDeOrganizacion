.text
	
create: 

	sw $ra, 0($sp)
	sw $s0, -4($sp)  
	addi $sp, $sp, -8
	
	
	addi $a0, $zero, 1000			# Amount of memory to be asked for allocating purposes

	jal init
	
	addi $s0, $zero, -1 
	
	addi $a0, $zero, 16				# Allocating memory for list attributes and identifier
	
	jal malloc 
	
	sw $s0, 0($v0) 					# An empty list holds first = -1
	sw $s0, 4($v0) 					# An empty list holds last = -1
	sw $zero, 8($v0) 				
	sw $s0, 12($v0) 				# All lists in the 16th position of its pointer address, have an identifier
									# with the value of 0xffffffff that let us verify that they're actually lists


	lw $s0, 4($sp)
	lw $ra, 8($sp) 
	
	addi $sp, $sp, 8
	
	jr $ra	



	

