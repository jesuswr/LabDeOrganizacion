.text

insert: 
	## This function receives the address of a list, and the address of the element to be inserted
	## It returns 0 if everything went well, a negative number otherwise 	 
	
	sw $s0, 0($sp) 
	sw $s1, -4($sp) 
	sw $s2, -8($sp) 
 	sw $ra -12($sp)
 	sw $t0, -16($sp)

 	addi $sp, $sp, -20

	move $s0, $a0
					
					
	lw $t0, 12($s0) 
	bne $t0, -1, insertException				# Determining if the pointer addres does point a valid list
	
	addi $a0, $zero, 8 
	jal malloc 									# Here we allocate space for the node
	
	beq $v0, -1, insertException2				# Determining if there is enough space
 
	sw $a1, 0($v0) 			# Saving the "element" in the first given address
	sw $zero, 4($v0) 		# Setting the node's "next" to 0

	lw $s1, 8($s0)		 	
	addi $s1, $s1, 1 		
	sw $s1, 8($s0) 			# Increasing size
			
	beq $s1, 1, setExtremes
 
	lw $s2, 4($s0)			 
	sw $v0, 4($s2)			# Setting last's next as the new node's address
	 
	sw $v0, 4($s0) 			# Updating "last"
 
 	li $v0, 0 
	j exitInsert   	    	
    	
    	
	  setExtremes:
    
	    sw $v0, 0($s0)				# updating "first"
	    sw $v0, 4($s0) 			# Updating "last"
		li $v0, 0	    
	    j exitInsert
	 
	insertException: 
		li $v0, -3 					# The given address does not contain a list
    	j exitInsert 
    	
    insertException2: 
    	li $v0, -4					# There is not enough space
    	j exitInsert
    	
	exitInsert: 
		
		lw $t0, 4($sp)
		lw $ra, 8($sp)
		lw $s2, 12($sp) 
		lw $s1, 16($sp) 
		lw $s0, 20($sp)
 
		addi $sp, $sp, 20

	 	jr $ra 
	 




