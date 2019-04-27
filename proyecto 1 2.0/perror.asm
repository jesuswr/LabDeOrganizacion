.data
	error1: 	.asciiz  "No hay suficiente espacio disponible para reservar la cantidad pedida.\n"
	error2:		.asciiz  "La direccion dada no es el principio de una direccion de memoria dada por malloc.\n"
	error3: 	.asciiz  "La dirección dada al insert no es la de una lista válida\n"
	error4: 	.asciiz  "El nodo no puede ser insertado porque no hay suficiente espacio\n"
	error5: 	.asciiz  "La dirección dada para eliminar no referencia a una lista\n"
	error6: 	.asciiz  "La posición dada no referencia a un nodo\n"

.text
	
perror:
	# This function receives a negative number that represents an error and it prints 
	# the meaning of that code.
	
	sw $s0, 0($sp) 
	sw $ra, -4($sp) 
	addi $sp, $sp, -8
	
	move $s0, $v0	
	
	beq 	$s0,  0, exitPerror
	beq 	$s0, -1, print1
	beq 	$s0, -2, print2
	beq 	$s0, -3, print3
	beq 	$s0, -4, print4
	beq 	$s0, -5, print5
	beq 	$s0, -6, print6
		
	J exitPerror			# This line exits perror if none of the previous conditions were matched
			
	print1:
		la 	$a0, error1
		li	$v0, 4
		syscall
		
		j 	exitPerror
		
	print2:
		la 	$a0, error2
		li	$v0, 4
		syscall
		
		j 	exitPerror
		
	print3:
		la 	$a0, error3
		li	$v0, 4
		syscall
		
		j 	exitPerror


	print4:
		la 	$a0, error4
		li	$v0, 4
		syscall
		
		j 	exitPerror#
		
	print5:
		la 	$a0, error5
		li	$v0, 4
		syscall
		
		j 	exitPerror
		
	print6:
		la 	$a0, error6
		li	$v0, 4
		syscall
		
		j 	exitPerror
				
	exitPerror:
		move $v0, $s0			# Adjusting the exit status of the function called before perror
		
		lw $ra, 4($sp) 
		lw $s0, 8($sp) 
		addi $sp, $sp, 8
		
		jr 	$ra

	