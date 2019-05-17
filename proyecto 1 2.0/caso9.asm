.data
	elemento: .asciiz "Inserte: "
	insertados: .asciiz "elementos creados exitosamente\n"
	creada: .asciiz "lista creada exitosamente\n"
	espacio: .asciiz "\n"
	caso: .asciiz "Creacion de dos listas:\n\t Insercion de 10 elementos en la primera y 6 en la segunda\n"
	input1: .asciiz "Inserte 10 elementos\n"
	input2: .asciiz "Inserte 6 elementos\n"
.text

	li $v0, 4
	la $a0, caso
	syscall

## CREACION DE LA LISTA 1 ################################################################################
	
	li $v0, 4
	la $a0, input1
	syscall
	
	addi $a0, $zero, 136
	jal init
	jal create

	move $s0, $v0	 		# apuntador a la lista 1 GLOBAL
		
	addi $s1, $zero, 10 		# numero de elementos a crear GLOBAL
	addi $a0, $zero, 40 		# se pide espacio para 10 elementos	
	
	jal malloc 			
	jal perror 			# Exeption handler
				
	move $s2, $v0			# Apuntador a los elementos GLOBALL
	move $t0, $v0			# se guarda el apuntador a elementos a usar en WHileElements
	
	addi $s3, $zero, 0
	
## INSERCION DE LOS ELEMENTOS lista 1##########################################################################
	whileElements: 
	
		beq $s3, $s1, exitWhileElements
		
		li $v0, 4
		la $a0, elemento
		syscall 
		
		li $v0, 5					# Solicitud de elementos por consola
		syscall 
		
		sw $v0, 0($t0)
		addi $t0, $t0, 4 		
		
		addi $s3, $s3, 1 	
		
		j whileElements
		
	exitWhileElements: 

		li $v0, 4
		la $a0, insertados
		syscall 
		
## INSERCION DE LOS NODOS lista 1 ##################################################################################
	

	addi $t1, $zero, 0
	
	whileCreate: 
	
		beq $t1, $s1, exitWhileCreate 			
		
		move $a0, $s0
		move $a1, $s2
		
		jal insert
		
		jal perror		# Exception Handler
		
		addi $t1, $t1, 1
		addi $s2, $s2, 4
		
		j whileCreate
	
	exitWhileCreate: 
	
		li $v0, 4
		la $a0, creada
		syscall
	
	
## CREACION DE LA LISTA 2 ################################################################################
	li $v0, 4
	la $a0, input2
	syscall
	
	addi $a0, $zero, 88
	jal init	
	jal create

	move $s7, $v0	 		# apuntador a la lista 2 GLOBAL


	addi $s6, $zero, 6		# numero de elementos a crear GLOBAL
	addi $a0, $zero, 24 		# se pide espacio para 6 elementos

	jal malloc 			
	jal perror 			# Exeption handler
				
	move $s5, $v0			# Apuntador a elementos GLOBAL
	move $t0, $v0			# se guarda el apuntador a elementos a usar en WHileElements
	
	addi $s3, $zero, 0
	

	

	
	
## INSERCION DE LOS ELEMENTOS lista 2##########################################################################
	whileElements2: 
	
		beq $s3, $s6, exitWhileElements2
		
		li $v0, 4
		la $a0, elemento
		syscall 
		
		li $v0, 5					# Solicitud de elementos por consola
		syscall 
		
		sw $v0, 0($t0)
		addi $t0, $t0, 4 		
		
		addi $s3, $s3, 1 	
		
		j whileElements2
		
	exitWhileElements2: 

		li $v0, 4
		la $a0, insertados
		syscall 
		
## INSERCION DE LOS NODOS lista 2 ##################################################################################
	

	addi $t1, $zero, 0
	
	whileCreate2: 
	
		beq $t1, $s6, exitWhileCreate2			
		
		move $a0, $s7
		move $a1, $s5
		
		jal insert
		
		jal perror		# Exception Handler
		
		addi $t1, $t1, 1
		addi $s5, $s5, 4
		
		j whileCreate2
	
	exitWhileCreate2: 
	
		li $v0, 4
		la $a0, creada
		syscall
	
	
## IMPRESION DE LAS LISTAS ##########################################################################

	move $a0, $s0
	jal print

	li $v0, 4
	la $a0, espacio
	syscall 

	move $a0, $s7
	jal print
			
	li $v0, 10
	syscall 
	
	
	
	
	


.include "create.asm"
.include "init.asm"
.include "malloc.asm"
.include "insert.asm"
.include "free.asm"
.include "delete.asm"
.include "print.asm"
.include "perror.asm"
