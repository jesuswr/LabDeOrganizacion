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
	
	b p1

	li $v0, 10
        syscall
	

p2:	
	li $v0 4
	la $a0 m2
	syscall
	
	b p2

        add $t1, $t1, $t1
	
	li $v0, 10
	syscall
	nop

p3:	
	li $v0 4
	la $a0 m3
	syscall

	b p3

	li $v0, 10
	syscall
	
	.include "myexceptions.s"
