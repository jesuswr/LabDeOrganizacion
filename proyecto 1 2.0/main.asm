.data
	endLine: .asciiz "\n"
.text

	################################################################################ INIT
	li 	$v0, 5 			# Read the int of the asked space in bytes.
	syscall

	move	$a0, $v0		# Pass the asked space as an argument to init.

	jal init			# Call init function.
	################################################################################# INIT
	
	################################################################################# MALLOC
	li 	$v0, 5 			# Read the int of the asked space in bytes.
	syscall

	move	$a0, $v0		# Pass the asked space as an argument to init.
	
	
	jal malloc
	
	move	$a0, $v0
	li	$v0, 1
	syscall
	
	la	$a0, endLine
	li 	$v0, 4
	syscall

	jal print
	
	la	$a0, endLine
	li 	$v0, 4
	syscall


	li 	$v0, 5 			# Read the int of the asked space in bytes.
	syscall

	move	$a0, $v0		# Pass the asked space as an argument to init.
	
	jal malloc
	
	move	$a0, $v0
	li	$v0, 1
	syscall
	
	la	$a0, endLine
	li 	$v0, 4
	syscall

	jal print
	################################################################## MALLOC

	################################################################## FREE
	la	$a0, endLine
	li 	$v0, 4
	syscall
	
	li 	$v0, 5 			# Read the int of the address to free.
	syscall

	move	$a0, $v0
	
	jal 	free
	
	

	jal print
	
	################################################################## FREE	
	
	la	$a0, endLine
	li 	$v0, 4
	syscall

	li 	$v0, 5 			# Read the int of the asked space in bytes.
	syscall

	move	$a0, $v0		# Pass the asked space as an argument to init.
	
	jal malloc
	
	move	$a0, $v0
	li	$v0, 1
	syscall
	
	la	$a0, endLine
	li 	$v0, 4
	syscall

	jal print
	
	li $v0, 10 
	syscall


.include "init.asm"
.include "print.asm"
.include "malloc.asm"
.include "free.asm"