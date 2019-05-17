.data
	elemento: .asciiz "Inserte: "
	insertados: .asciiz "elementos creados exitosamente\n"
	creada: .asciiz "lista creada exitosamente\n"
	espacio: .asciiz "\n"
	caso: .asciiz "Creacion de lista e insercion de 10 elementos\n"
	input: .asciiz "Inserte 10 elementos\n"
.text

	li $v0, 4
	la $a0, caso
	syscall

## CREACION DE LA LISTA ################################################################################
	
	li $v0, 4
	la $a0, input
	syscall
	
	addi $a0, $zero, 136
	jal init
	jal create

	move $s0, $v0	 		# apuntador a la lista 
		
	addi $s1, $zero, 10 		# numero de elementos a crear GLOBAL
	addi $a0, $zero, 40 		# se pide espacio para 10 elementos	
	
	jal malloc 			
	jal perror 			# Exeption handler
				
	move $s2, $v0			# Apuntador a los elementos GLOBALL
	move $t0, $v0			# se guarda el apuntador a elementos a usar en WHileElements
	
	addi $s3, $zero, 0
	
## INSERCION DE LOS ELEMENTOS ##########################################################################
	whileElements: 
	
		beq $s3, $s1, exitWhileElements
		
		li $v0, 4
		la $a0, elemento
		syscall 
		
		li $v0, 5		# Solicitud de elementos por consola
		syscall 
		
		sw $v0, 0($t0)
		addi $t0, $t0, 4 		
		
		addi $s3, $s3, 1 	
		
		j whileElements
		
	exitWhileElements: 

		li $v0, 4
		la $a0, insertados
		syscall 
		
## INSERCION DE LOS NODOS ##################################################################################
	

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
		
	move $a0, $s0
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
