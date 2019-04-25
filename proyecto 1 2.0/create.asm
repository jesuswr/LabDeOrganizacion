.text
	
create: 

	sw $ra, 0($sp)
	sw $s0, -4($sp)  
	addi $sp, $sp, -8
	
	
	addi $a0, $zero, 412 # Se emplearan 12 + 50*8 = 412 bytes
						# 12 para las 3 eitquetas: first, last, size
						# 8 bytes para cada nodo: 4 bytes de elemento + 4 bytes de apuntador a siguiente
						# Se establecere como maximo (por ahora) 50 nodos
	jal init
	
	addi $s0, $zero, -1 
	
	addi $a0, $zero, 12		# pido memoria para first, last y size
	
	jal malloc 
	
	sw $s0, 0($v0) 			# inicializo first en -1
	sw $s0, 4($v0) 			# inicializo last en -1
	sw $zero, 12($v0) 		# incializo size en 0 
	
	#sw $s0, first		# inicializo first en -1 == no hay elementos en la lista
	#sw $s0, last		# Lo mismo sucede con last	
	#sw $zero, size 		# inicializo size en 0 


	lw $s0, 4($sp)
	lw $ra, 8($sp) 
	
	addi $sp, $sp, 8
	
	jr $ra	

	# al finalizar la ejecucion, la direccion del bloque de memoria de la cabecera esta en $v0s


	

