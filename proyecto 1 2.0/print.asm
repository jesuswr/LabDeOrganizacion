.data
	newline:.asciiz "\n"
	space: 	.asciiz " "
.text

print: 

	sw $s0, 0($sp) 
	sw $s1, -4($sp) 
	sw $t0, -8($sp) 
	sw $t1, -12($sp)
	sw $t2, -16($sp) 
	sw $ra, -20($sp) 
	addi $sp, $sp, -24
	
	move $s0, $a0
	
	lw $t2, 8($s0) 	
	beq $t2, 0, emptyList
			
# Function print: Implemented as a macro, this function calls the printInt macro, to print integers one by one
.macro print(%lista, %func)
	
	lw $t0, 0(%lista)
	
	lw $s0, 8(%lista)
	addi $s0, $s0, -1
	addi $s1, $zero, 0			
	whilePrint: 
	
		beq $s1, $s0, exitWhilePrint
		
#  		li $v0, 4
#		la $a0, pipe
#		syscall 
		
		lw $t1, 0($t0) 			
		lw $t1, 0($t1)
		%func($t1)
		
		li $v0, 4
		la $a0, space
		syscall 

		lw $t0, 4($t0) 	
		addi $s1, $s1, 1
		j whilePrint
		
	exitWhilePrint: 
#		li $v0, 4
#		la $a0, pipe
#		syscall 		
		
		lw $t1, 0($t0)
		lw $t1, 0($t1)
		%func($t1)
		
#		li $v0, 4
#		la $a0, pipe
#		syscall 		
	
		li $v0, 4
		la $a0, newline
		syscall
.end_macro
	
# Function printInt: Implemented as a macro, prints an integer
.macro printInt(%integer)
	li $v0, 1
	addi $a0, %integer, 0 
	syscall 	
.end_macro

	print($s0, printInt) 
	
	j exitPrint
	
	emptyList:			# This tag prints " " whenever the given list is empty
		li $v0, 4
		la $a0, space
		syscall
		
		j exitPrint	

	exitPrint: 
	
		lw $ra, 4($sp)
		lw $t2, 8($sp)
		lw $t1, 12($sp) 
		lw $t0, 16($sp) 
		lw $s1, 20($sp)
		lw $s0, 24($sp) 
		addi $sp, $sp, 24
	
		jr $ra

