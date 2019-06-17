#Programa:	 myprogs.s
#Autor:	 profs del taller de organizaciòn del computador
#Fecha:	 Junio 2019

# Obs: Esto es un ejemplo de como podría ser un programa principal a
#	usarse en el proyecto.
# Para la corrida de los proyectos el grupo profesoral generara
# varios archivos con características similares
# Asegurese de crear varios casos de prueba para verificar sus
# implementaciones
		
	.data
	.globl PROGS
	.globl NUM_PROGS
	.globl QUANTUM

NUM_PROGS:	.word 3
PROGS:		.word p1, p2, p3
QUANTUM: 	.word 5   # En segundos (aproximadamente)
	
m1:	.asciiz "p1\n"
m2:	.asciiz "p2\n" 
m3:	.asciiz "p3\n"
	
	.text

p1:
	li $v0 4
	la $a0 m1
	syscall
	
	addi $s1, $zero, 2
	add $s0, $zero, $s1
	
	beq $s1, 2, p1
	
	addi $s0, $s0, 2
	addi $t0, $zero, 0 	

	li $v0, 10
    	syscall
    	nop
    	nop
    	nop
	

p2:	
	add $3,$3,$3
	li $v0 4
	la $a0 m2
	syscall
	
	b p2

        add $t1, $t1, $t1
        add $t2, $t2, $t2
	
	li $v0, 10
	syscall
	nop
	nop
	nop

p3:	
	li $v0 4
	la $a0 m3
	syscall

	b p3
	
	add $t1, $t1, $t1
        add $t2, $t2, $t2

	li $v0, 10
	syscall
	nop
	nop

	
		
	############################### CASOS DE PRUEBA BEQ #############################################
	
	############################## CASO 1: 
	#X:
	#add $s3, $zero, $s1
	#add $s4, $s0, $s1

	#beq $s1, 2, X
	##
	
	############################## CASO 3: 
	#add $s0, $zero, $s1
	#X: 

	#beq $s1, 2, X
	##
	
	############################## CASO 3.2:
	#add $s0, $zero, $s1
	#X: 
	#addi $s1, $s1, 0
	#addi $s0, $s0, 2
	
	#beq $s1, 2, X
	
	############################## CASO 4:
	#add $s0, $zero, $s1
	
	#beq $s1, 2, X
	#addi $s3, $s0, 0
	#X: 
	#addi $s0, $zero, 2
	##
	#####################################################################################
	
			
	.include "myexceptions.s"
