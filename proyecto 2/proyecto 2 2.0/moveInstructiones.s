# ESTA FUNCION RECIBE LA DIRECCION EN LA QUE EMPIEZA EL PROGRAMA Y LA DIRECCION EN LA QUE EMPIEZA
# EL ARREGLO DE MOVIMIENTOS Y MUEVE LAS INSTRUCCIONES

moveInstructions:

	# primero guardamos las $s
	sw	$s0, ($sp)
	sw 	$s1, -4($sp)
	sw	$s2, -8($sp)
	sw 	$s3, -12($sp)
	sw	$s4, -16($sp)
	
	addi	$sp, $sp, -20

	addi	$s0, $a0, 0		# direccion en la que empieza el programa
	addi	$s1, $a1, 0		# direccion del arreglo de moviminetos
	
	whileToGetToEnd:
		lw	$s2, ($s0)
		beq	$s2, 0, exitGetToEnd
		
		addi	$s0, $s0, 4
		addi 	$s1, $s1, 4
		j 	whileToGetToEnd
	exitGetToEnd:
	
		addi	$s0, $s0, -4			# Esta seria la direccion de la ultima instruccion
		addi	$s1, $s1, -4			# Esta seria la direccion que contiene que tanto se debe mover la instruccion
	
	whileToMove:
		beq	$s0, $a0, exitMovement
		
		lw	$s3, ($s0)			# cargamos la instruccion en $s3
		lw	$s4, ($s1)			# cargamos que tanto hay que moverla en $s4
		add	$s4, $s4, $s0			# le sumamos a $s4 la ubicacion de la instruccion
		
		sw	$s3, ($s4)			# guardamos la instruccion en su nueva ubicacion
		
		
		addi	$s0, $s0, -4			# nos movemos a la siguiente instruccion
		addi	$s1, $s1, -4	
		j	whileToMove
	exitMovement:
	
	# Ahora recuperamos las $s del stack pointer
	
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw 	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	
	addi	$sp, $sp, 20
	
	
	jr	$ra