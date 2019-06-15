
# RECIBE LA DIRECCION EN LA QUE EMPIEZA EL PROGRAMA Y DEVUELVE LA DIRECCION DE UN ARREGLO QUE INDICA CUANTO SE TIENE
# QUE MOVER CADA INSTRUCCION.
getMoves:

	move 	$s0, $a0				# $s0 == direccion en la que empieza el programa
	
	getSizeWhile:
		lw 	$s1, ($s0)				# $s1 == codigo de instruccion en $s0
		
		beq	$s1, 0x2402000a, exitSizeWhile		# si $s1 == li $v0 10, llegamos al final del programa
		
		addi	$s0, $s0, 4
		j 	getSizeWhile
		
	exitSizeWhile:
		
	addi	$s1, $zero, 0x0000040d			# codigo de instruccion del break 0x10
		
	sw	$s1, ($s0)				# cambiamos el li vo 10 por break 0x10
	
	addi 	$s0, $s0, 4				# nos movemos a la siguiente instruccion
		
	addi	$s1, $zero, 0				# codigo de instruccion del nop
		
	sw	$s1, ($s0)				# cambiamos el syscall por un nop
		
	sub 	$s2, $s0, $a0				# este seria el numero de bytes que ocupa el programa
	
	addi	$s0, $a0, 0				# $s0 == direccion en la que inicia el programa
	
	addi	$a0, $s2, 0
	li	$v0, 9
	syscall						# aqui pedimos espacio para un arreglo del tamano del programa
	
	move	$s1, $v0				# $s1 guarda la direccion de memoria en la que esta el arreglo
	addi	$s2, $zero, 0
	
	whileCountAdd:
		lw	$s3, ($s0)			# $s3 == instruccion en $s0
		beq	$s3, 0, exitCountAdd		# si la instruccion  en $s3 es un nop, nos detenemos
		
		sw	$s2, ($s1)			# guardamos la cantidad de movimientos en el arreglo
		
		# Ahora revisaremos si la instruccion es un add, si lo es aumentaremos $s2
		and	$s4, $s3, 32
		
		beq	$s4, 32, checkForAdd		# primero revisamos si el 6to bit esta encendido y del 1 al 5 apagados
		j 	exit
		
		checkForAdd:
			srl 	$s3, $s3, 6		
			andi 	$s4, $s3, 31
			
			beqz 	$s4, checkForAdd2	# ahora revisamos si los bits 7-11 estan apagados
			j 	exit
		
		checkForAdd2:
			srl	$s3, $s3, 20
			beqz	$s3, addToCount		# y finalmente revisamos si los ultimos 5 bits estan apagados
			j 	exit
			
		addToCount:
		addi	$s2, $s2, 1			# si es un add, anadimos al contador
		
		exit:
		addi	$s1, $s1, 4
		addi	$s0, $s0, 4
		j	whileCountAdd
		
	exitCountAdd:
		
	jr	$ra
		
		
		
		