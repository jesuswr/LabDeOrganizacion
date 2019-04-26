.data
	input: .asciiz "cuantos elementos desea crear?: "
	elemento: .asciiz "inserte: "
	insertados: .asciiz "elementos creados\n"
	creada: .asciiz "lista creada:\n"
	
	cb1: .asciiz "\tElimino al primero: \n" 
	cb2: .asciiz "\tElimino al ultimo: \n"
	cb3: .asciiz "\tElimino una posicion que no este en la lista: \n" 
	cb4: .asciiz "\tElimino usando una lista no valida: \n"
	confirmacion: .asciiz "\nFreelist\n"
	pregunta: .asciiz "Insertar (1) | Eliminar (2) | Print(3)| Salir (4) "
	posicion: .asciiz "Posicion a eliminar: "
.text

#######################################################
################## ARCHIVO DE PRUEBA ##################

### Se considera que los elementos se crean en el mismo espacio que el de la lista
### para los registro GLOBALES se usara $s_i


## CREACION DE LA LISTA ################################################################################
	jal create

	move $s0, $v0	 						# list_ptr == GLOBAL !!!


	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 5
	syscall 
	
	move $s1, $v0							# Nro de elementos a crear == GLOBAL !!! 
	
	addi $t1, $zero, 4
	
	mul $a0, $t1, $s1				# aqui se calculan los bytes a pdir	
	
	jal malloc 			
	
	move $s2, $v0							# Elements_ptr == GLOBALL !!
	move $t0, $v0					# aqui se guarda el Elements_ptr a usar en WHileElements
	
	addi $s3, $zero, 0
	
## INSERCION DE LOS ELEMENTOS ##########################################################################
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
		
## INSERCION DE LOS NODOS ##################################################################################
	

	addi $t1, $zero, 0
	
	whileCreate: 
	
		beq $t1, $s1, exitWhileCreate 			
		
		move $a0, $s0
		move $a1, $s2
		
		jal insert
		
		addi $t1, $t1, 1
		addi $s2, $s2, 4
		
		j whileCreate
	
	exitWhileCreate: 
	
		li $v0, 4
		la $a0, creada
		syscall
	
	move $a0, $s0
	
	
## IMPRESION DE LA LISTA ##########################################################################
	jal print
	

###################################### MAS PRUEBAS ################################################

### CASOS BORDE

############## Elimino al primero
	li $v0, 4
	la $a0, cb1
	syscall

	li $a1, 1
	move $a0, $s0
	jal delete

	move $a0, $s0
	jal print

############## Elimino al unico -- colocar tamano 1		
#	li $v0, 10
#	syscall 

			
############## Elimino al ultimo
	li $v0, 4
	la $a0, cb2
	syscall
	
	lw $a1, 8($s0), 
	move $a0, $s0
	jal delete
	
	move $a0, $s0
	jal print
	
############## Elimino a uno que no este en la lista
	li $v0, 4
	la $a0, cb3
	syscall

	lw $a1, 8($s0) 
	addi $a1, $a1, 1
	move $a0, $s0
	jal delete
	
	move $a0, $s0
	jal print
	

############### Elimino pasando una lista no valida
	li $v0, 4
	la $a0, cb4
	syscall

	addi $a1, $zero, 3
	move $a0, $s0
	jal delete
	
	move $a0, $s0
	jal print
	

## IMPRESION DE LA FREELIST ##########################################################################	
printFreeList: 

	la $t5, freeList
	lw $t4, freeListSize($zero)	
	
	
	addi $t0, $zero, 0 
	whilePrintFree: 
		beq $t4, $t0, exitWhilePrintFree
		
		li $v0,1 
		move $a0, $s0
		syscall 
		
		addi $t5, $t5, 1
		addi $t0, $t0, 1 
	exitWhilePrintFree: 
		 
		li $v0, 4
		la $a0, confirmacion
		syscall


## INSERT INTERACTIVO ##########################################################################		


insertInteractivo: 

	li $v0, 4
	la $a0, pregunta
	syscall 
	
	li $v0, 5
	syscall 
	
	move $t7, $v0

	beq $t7, 1, INSERTA
	beq $t7, 2, ELIMINA	
	beq $t7, 3, PRINT
	beq $t7, 4, exitInsertInteractivo

	
	INSERTA: 
		addi $a0, $zero, 4
		jal malloc
		
		move $t3, $v0
	
		li $v0, 4
		la $a0, elemento
		syscall 
		
		li $v0, 5
		syscall 

		sw $v0, ($t3)
		
		move $a0, $s0
		move $a1, $t3

		jal insert
		
		j insertInteractivo
			
	ELIMINA: 
		li $v0, 4
		la $a0, posicion
		syscall 
		
		li $v0, 5
		syscall 
		
		move $a0, $s0
		move $a1, $v0
		
		jal delete
		
		j insertInteractivo
		
	PRINT: 
		move $a0, $s0
		jal print
		
		j insertInteractivo
		
	
	
exitInsertInteractivo: 
	li $v0, 10
	syscall 
	
	
	
	
	


.include "create.asm" 
.include "init.asm"
.include "malloc.asm"
.include "insert.asm"
.include "free.asm"
.include "delete.asm"
.include "print.asm"

