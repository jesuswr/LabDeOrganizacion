.text

insert: 
	## This function receives the address of a list, and the address of the element to be inserted
	## It returns 0 if everything went well, a negative number otherwise 	 
	
	sw $s0, 0($sp) 
	sw $s1, -4($sp) 
	sw $s2, -8($sp) 
	sw $s3, -12($sp) 
	sw $s4, -16($sp)
 	sw $ra -20($sp)
 	sw $t0, -24($sp)

 	addi $sp, $sp, -28

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
#	bgt $s1, 1, updateNext
 
#	updateNext:
 
#		lw $s2, 0($s0)
#	 	addi $s3, $zero, 1 	
#	 	addi $s1, $s1, -1 	
 	
#	 	WhileNext: 
 	
#	 		beq $s3, $s1, exitNext
 		
#	 		lw $s2, 4($s2) 	
#	        addi $s3, $s3, 1
	        
#       		li $v0, 0
       		
#	        j WhileNext
        
#	    exitNext: 
    	
#	    	lw $s4, 4($s0)
#	    	sw $s4, 4($s2) 			# Setting "prev.next = deleted.next "
	    	
#	    	j exitInsert
	    	
    	
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
	 	lw $s4, 12($sp) 
	 	lw $s3, 16($sp) 
		lw $s2, 20($sp) 
		lw $s1, 24($sp) 
		lw $s0, 28($sp)
 
		addi $sp, $sp, 28

	 	jr $ra 
	 




