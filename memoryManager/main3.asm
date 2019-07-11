.data
	saltoDeLinea: .asciiz "\n"


.text
# INIT 20
li 	$a0, 20
jal 	init

addi	$a0, $v0, 0
li	$v0, 1
syscall

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# MALLOC 16
li 	$a0, 16
jal 	malloc

addi	$a0, $v0, 0
li	$v0, 1
syscall

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# FREE DE 16
li	$a0, 268697600
jal 	free

addi	$a0, $v0, 0
li	$v0, 1
syscall

la	$a0, saltoDeLinea
li	$v0, 4
syscall

# MALLOC 20
li 	$a0, 20
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
