.text

insert: 

 
# hay que verificar: 
# 	que lista_ptr = $a0, sea valido?? sip
# 	que element_ptr = $a1 sea valido		asumi que no
# 	que la lista no este llena?? 			asumi que no

 	
 
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
	bne $t0, -1, exception				# Determining if the pointer addres does point a valid list
	
	addi $a0, $zero, 8 
	jal malloc 							# Here we allocate space for the node
	
	beq $v0, -1, exception2				# Determining if there is enough space
 
	sw $a1, 0($v0) 			# almaceno element_ptr en la primera palabra dada
	sw $zero, 4($v0) 		# almaceno 0 en next
 
	sw $v0, 4($s0) 			# actualizo last
 
	lw $s1, 8($s0)		 	# cargo size a s1
	addi $s1, $s1, 1 		# size = size + 1
	sw $s1, 8($s0) 			# incremento size
 
 	
	beq $s1, 1, setExtremes
   
	bgt $s1, 1, updateNext
 
	updateNext:
 
		lw $s2, 0($s0)
	 	addi $s3, $zero, 1 	# contador, i = 1
	 	addi $s1, $s1, -1 	# tamano previo
 	
	 	WhileNext: 
 	
	 		beq $s3, $s1, exitNext
 		
	 		lw $s2, 4($s2) 	# de esto no estoy tan seguro, quiero tomar el atributo next de cada nodo (que es una direccion), y
 							# cargarlo en cada caso, pero al mismo registro
	        addi $s3, $s3, 1
	        
       		li $v0, 0
       		
	        j WhileNext
        
	    exitNext: 
    	
	    	lw $s4, 4($s0)	##### REEMPLAZAR lw $s0, 4($s0) 	
	    	sw $s4, 4($s2) 	# Almaceno la direccion del ultimo nodo en el next del penultimo.
	    	
	    	j exitInsert
	    	
    	
	  setExtremes:
    
	    sw $v0, 0($s0)			# actualizo first
	    
	    j exitInsert
	 
	exception: 
		li $v0, -1 			# The given address does not contain a list
    	j exitInsert 
    	
    exception2: 
    	li $v0, -2
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
	 




