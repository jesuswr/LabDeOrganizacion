.text

insert: 
 # PRE:$a0 ptr lista, $a1 ptr elem
 
 # POST: 
 
# hay que verificar: 
# 	que lista_ptr = $a0, sea valido?? 		asumi que no .... tal vez deberia
# 	que element_ptr = $a1 sea valido?? 		asumi que no 
# 	que la lista no este llena?? 			asumi que si



 	# guardo en el stack los $s_i
	sw $s0, 0($sp) 
	sw $s1, -4($sp) 
	sw $s2, -8($sp) 
	sw $s3, -12($sp) 
	sw $s4, -16($sp)
 	sw $ra -20($sp)

 	addi $sp, $sp, -24

	move $s0, $a0			# no se que hacer con esto, supongo que puedo usarlo para verificar que es una lista
					# JA: resulta que como no se pueden utilizar etiquetas por problemas con el espacio de nombres
					# pues si hay varias listas los first, last y size previamente creados no funcionarian :D
					
					######## PILAS ... movi $a0, a $s0
	addi $a0, $zero, 8 
	jal malloc 				# consigo espacio para el nodo
 
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
       		
	        j WhileNext
        
	    exitNext: 
    	
	    	lw $s4, 4($s0)	##### REEMPLAZAR lw $s0, 4($s0) 	
	    	sw $s4, 4($s2) 	# Almaceno la direccion del ultimo nodo en el next del penultimo.
	    	
	    	j exitInsert
	    	
    	
	  setExtremes:
    
	    sw $v0, 0($s0)			# actualizo first
	    
	    j exitInsert
    
	exitInsert: 
	
		lw $ra, 4($sp)
	 	lw $s4, 8($sp) 
	 	lw $s3, 12($sp) 
		lw $s2, 16($sp) 
		lw $s1, 20($sp) 
		lw $s0, 24($sp)
 
		addi $sp, $sp, 24
		
		li $v0, 0

	 	jr $ra 
	 
# falta considerar
# 	que la lista este llena
# 	que la lista este vacia ... last = first .. si, habra estado vacia si su size termina por ser 1, esto lo maneja setExtremes
# 	que la lista tenga un solo elemento ... como size incrementa esto se maneja por updateNext



