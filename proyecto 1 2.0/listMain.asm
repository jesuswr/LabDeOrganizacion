
.text

	
	jal create

	move $s0, $v0	 # almaceno temporalmente la direccion de la lista

#	addi $a0, $zero, 4
#	jal malloc 
	
#	move $a1, $v0
#	move $a0, $s0
#	jal insert	


	addi $t1, $zero, 1
	
	while: 
	
		beq $t1, 2, exit 	
		
		addi $a0, $zero, 4 		# pido espacio para un ELEMENTO
	
		jal malloc 
	
		move $a1, $v0		# paso la direccion del ELEMENTO
		move $a0, $s0		# paso la direccion de la lista
	
		jal insert
		
		addi $t1, $t1, 1
		
		j while
	
	exit: 
	
		##

	
### CASOS BORDE
# Elimino el primero
#	li $a1, 1
#	move $a0, $s0
#	jal delete
	
# Elimino el ultimo
#	li $a1, 7
#	move $a0, $s0
#	jal delete
	
# Elimino el unico elemento
#	li $a1, 1
#	move $a0, $s0
#	jal delete

# Elimino a un elemento que no esta en la lista		
#	li $a1, 4
#	move $a0, $s0
#	jal delete
	
	
	li $v0, 10
	syscall 	





.include "create.asm" 
.include "init.asm"
.include "malloc.asm"
.include "insert.asm"
.include "free.asm"
.include "delete.asm"


