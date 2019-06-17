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
	
	addi $s0, $zero, 1
	
	add $s1, $s0, $s0
	add $s3, $s1, $s1
	add $s4, $s3, $s3
	
	beq $s1, 2, p1

	li $v0, 10
    syscall
	

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
	
	.include "myexceptions.s"
