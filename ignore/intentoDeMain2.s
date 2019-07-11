.data
	programSizes: 	.word 0			# Arreglo que tendra el tamano de cada programa.
	syscall10: 	.word 0x2402000a	# Codigo del li $v0 10, para cambiar por break 0x10
	addCode:	.word 32		# Codigo del add
	break10:	.word 0x0000040d	# Codigo del break 0x10
	break20:	.word 0x0000080d	# Codigo del break 0x20



.text

	###################### ESTA PARTE ES PARA CONSEGUIR EL NUMERO DE INSTRUCCIONES DE CADA PROGRAMA ###########################
	#################################### Y PARA CAMBIAR LOS SYSCALL 10 POR BREAK 0X10 #########################################
	
	la	$s0, PROGS			# s0 == direccion de memoria del arreglo que tiene las direcciones de los programas
	lw	$s1, NUM_PROGS			# s1 == numero de programas
	
	mul 	$a0, $s1, 4
	li 	$v0, 9
	syscall
	
	sw	$v0, programSizes		# programSizes == direccion de un arreglo que tendra los tamanos de los programas
	
	lw	$s2, syscall10			# s2 == codigo de syscall 10
	lw 	$s5, programSizes		# s5 == direccion del arreglo de tamanos de programas
	lw 	$s6, break10
	
	whileToGetSizes:
		beqz 	$s1, exitSizesWhile	# if s1 == 0 exit
		
		lw	$s3, ($s0)		# $s3 == inicio del programa i
		
		addi	$s4, $s3, 0		# $s4 == $s3
		
		whileToCount:
			addi 	$s4, $s4, 4				
			lw 	$s7, ($s4)				# $s7 == codigo de instruccion en $s4
			
			beq	$s7, 0x2402000a, foundExitCode		# if $s7 == li $v0 10, exit
			
			j	whileToCount				# sino hacer otro loop
			
		foundExitCode:
			sw	$s6, ($s4)	# cambiar la instruccion li $v0 10 por break 0x10
			
			addi	$s4, $s4, 4
			addi 	$t1, $zero, 0
			sw	$t1, ($s4)
			
			sub	$t0, $s4, $s3	# este sera el tamano del programa
			#srl 	$t0, $t0, 2	# este sera el numero de instrucciones en el programa
			sw	$t0, ($s5) 	
			
			
	
		addi 	$s0, $s0, 4
		addi 	$s5, $s5, 4
		addi	$s1, $s1, -1
		
		j whileToGetSizes
	
	exitSizesWhile:
	
	###########################################################################################################################
	###########################################################################################################################
	
	######################## ESTA PARTE ES PARA MOVER LAS INSTRUCCIONES SI SE ENCUENTRA UN ADD ################################
	
	lw	$s0, NUM_PROGS
	lw 	$s1, programSizes
	addi 	$s2, $zero, 0
	la	$s3, PROGS
	
	whileToCountAdds:
		beq	$s0, $s2, exitWhileCountAdd
		
		lw	$s4, ($s1)				# $s4 == tamano del programa
		
		lw	$s5, ($s3)				# $s5 == direccion en la que empieza el programa
		
		addi 	$a0, $s4, 0
		li	$v0, 9
		syscall
		
		addi	$s6, $v0, 0				# $s6 == direccion de memoria en la que se guarda el espacio pedido
		addi 	$t2, $s6, 0
		addi 	$s7, $zero, 0				# $s7 == es el contador de adds
		
		whileToSearchAdds:
			beqz 	$s4, exitSearchAdds		# si sales del tamano del arreglo, exit
			
			lw	$t0, ($s5)			# $t0 == codigo de la operacion en $s5
			and  	$t1, $t0, 32				# AQUI HAY QUE REVISAR SI ES UN ADD
			
			beq 	$t1, 32, checkAdd		# SI ES UN ADD, ANADIR 1 AL CONTADOR
			j 	dontAddToCount
			
			checkAdd:
				srl 	$t0, $t0, 6
				andi 	$t1, $t0, 31
				beqz 	$t1, checkAdd2
			
				j 	dontAddToCount
				
			checkAdd2:
				srl	$t0, $t0, 20
				beqz	$t0, addToCount
				
				j 	dontAddToCount
				
			addToCount:
				sw 	$s7, ($s6)
				addi 	$s7, $s7, 1
				j 	nextProgram
			dontAddToCount:
			
			sw 	$s7, ($s6)			# GUARDAR EN EL ARREGLO EL CONTADOR
		
			nextProgram:		
				addi 	$s6, $s6, 4
				addi	$s5, $s5, 4
				addi 	$s4, $s4, -4
				j	whileToSearchAdds
		exitSearchAdds:		


		addi	$s3, $s3, 4			# NOS MOVEMOS AL SIGUIENTE PROGRAMA
		addi	$s1, $s1, 4
		addi	$s2, $s2, 1
		j	whileToCountAdds
	exitWhileCountAdd:









	
.include "myprogs.s"