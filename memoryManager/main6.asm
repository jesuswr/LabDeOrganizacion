.data
	saltoDeLinea: .asciiz "\n"
	espacio: .asciiz "  "


.text
# INIT 500
li	$a0, 500
jal 	init

addi	$a0, $v0, 0
li	$v0, 1
syscall

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# MALLOC 400
li 	$a0, 400
jal 	malloc

addi	$s1, $v0, 0

addi	$a0, $v0, 0
li	$v0, 1
syscall

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# Generar 100 enteros
addi 	$s0, $s1, 400
li	$s2, 0

whileInt:
	beq	$s0, $s1, exitInt
	
	sw	$s2, ($s1)
	addi	$s1, $s1, 4
	addi	$s2, $s2, 1
	
	
	j whileInt
	
exitInt:

# Imprimir 100 enteros
addi	$s1, $s1, -400

whilePrint1:
	beq	$s0, $s1, exitPrint1
	
	lw	$a0, ($s1)
	li	$v0, 1
	syscall
	
	la	$a0, espacio
	li	$v0, 4
	syscall
	
	addi	$s1, $s1, 4

	j whilePrint1

exitPrint1:

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# MALLOC 120
li 	$a0, 120
jal 	malloc

addi	$s1, $v0, 0

addi	$a0, $v0, 0
li	$v0, 1
syscall

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# MALLOC 100
li 	$a0, 100
jal 	malloc

addi	$a0, $v0, 0
li	$v0, 1
syscall

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# FREE 100
li	$a0, 268698000
jal free

addi	$a0, $v0, 0
li	$v0, 1
syscall

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# MALLOC 50
li 	$a0, 50
jal 	malloc

addi	$a0, $v0, 0
li	$v0, 1
syscall

# EXIT
li  	$v0, 10
syscall


.include "create.asm"
.include "init.asm"
.include "malloc.asm"
.include "insert.asm"
.include "free.asm"
.include "delete.asm"
.include "print.asm"
.include "perror.asm"
