# SPIM S20 MIPS simulator.
# The default exception handler for spim.
#
# Copyright (C) 1990-2004 James Larus, larus@cs.wisc.edu.
# ALL RIGHTS RESERVED.
#
# SPIM is distributed under the following conditions:
#
# You may make copies of SPIM for your own use and modify those copies.
#
# All copies of SPIM must retain my name and copyright notice.
#
# You may not sell SPIM or distributed SPIM in conjunction with a commerical
# product or service without the expressed written consent of James Larus.
#
# THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE.
#

# $Header: $


# Define the exception handling code.  This must go first!

	.kdata
__m1_:	.asciiz "  Exception "
__m2_:	.asciiz " occurred and ignored\n"
__e0_:	.asciiz "  [Interrupt] "
__e1_:	.asciiz	"  [TLB]"
__e2_:	.asciiz	"  [TLB]"
__e3_:	.asciiz	"  [TLB]"
__e4_:	.asciiz	"  [Address error in inst/data fetch] "
__e5_:	.asciiz	"  [Address error in store] "
__e6_:	.asciiz	"  [Bad instruction address] "
__e7_:	.asciiz	"  [Bad data address] "
__e8_:	.asciiz	"  [Error in syscall] "
__e9_:	.asciiz	"  [Breakpoint] "
__e10_:	.asciiz	"  [Reserved instruction] "
__e11_:	.asciiz	""
__e12_:	.asciiz	"  [Arithmetic overflow] "
__e13_:	.asciiz	"  [Trap] "
__e14_:	.asciiz	""
__e15_:	.asciiz	"  [Floating point] "
__e16_:	.asciiz	""
__e17_:	.asciiz	""
__e18_:	.asciiz	"  [Coproc 2]"
__e19_:	.asciiz	""
__e20_:	.asciiz	""
__e21_:	.asciiz	""
__e22_:	.asciiz	"  [MDMX]"
__e23_:	.asciiz	"  [Watch]"
__e24_:	.asciiz	"  [Machine check]"
__e25_:	.asciiz	""
__e26_:	.asciiz	""
__e27_:	.asciiz	""
__e28_:	.asciiz	""
__e29_:	.asciiz	""
__e30_:	.asciiz	"  [Cache]"
__e31_:	.asciiz	""
__excp:	.word __e0_, __e1_, __e2_, __e3_, __e4_, __e5_, __e6_, __e7_, __e8_, __e9_
	.word __e10_, __e11_, __e12_, __e13_, __e14_, __e15_, __e16_, __e17_, __e18_,
	.word __e19_, __e20_, __e21_, __e22_, __e23_, __e24_, __e25_, __e26_, __e27_,
	.word __e28_, __e29_, __e30_, __e31_
s1:	.word 0
s2:	.word 0

# This is the exception handler code that the processor runs when
# an exception occurs. It only prints some information about the
# exception, but can server as a model of how to write a handler.
#
# Because we are running in the kernel, we can use $k0/$k1 without
# saving their old values.

# This is the exception vector address for MIPS-1 (R2000):
#	.ktext 0x80000080
# This is the exception vector address for MIPS32:
	.ktext 0x80000180
# Select the appropriate one for the mode in which MIPS is compiled.

	move $k1 $at		# Save $at
	
	sw $v0 s1		# Not re-entrant and we can't trust $sp
	sw $a0 s2		# But we need to use these registers

	mfc0	$k1, $14
	lw	$k1, ($k1)
	
	beq	$k1, 0x80d, break20Int
	beq	$k1, 0x40d, break10Int

	mfc0 $k0 $13		# Cause register
	srl $a0 $k0 2		# Extract ExcCode Field
	andi $a0 $a0 0x1f

	# Print information about exception.
	#
	li $v0 4		# syscall 4 (print_str)
	la $a0 __m1_
	syscall

	li $v0 1		# syscall 1 (print_int)
	srl $a0 $k0 2		# Extract ExcCode Field
	andi $a0 $a0 0x1f
	syscall

	li $v0 4		# syscall 4 (print_str)
	andi $a0 $k0 0x3c
	lw $a0 __excp($a0)
	nop
	syscall

	bne $k0 0x18 ok_pc	# Bad PC exception requires special checks
	nop

	mfc0 $a0 $14		# EPC
	andi $a0 $a0 0x3	# Is EPC word-aligned?
	beq $a0 0 ok_pc
	nop

	li $v0 10		# Exit on really bad PC
	syscall

ok_pc:
	li $v0 4		# syscall 4 (print_str)
	la $a0 __m2_
	syscall

	srl $a0 $k0 2		# Extract ExcCode Field
	andi $a0 $a0 0x1f
	bne $a0 0 ret		# 0 means exception was an interrupt
	nop
	
	j 	ret

# Interrupt-specific code goes here!
# Don't skip instruction at EPC since it has not executed.

	break20Int:
		lw	$k0, currentProgram
		sll	$k0, $k0, 2
		
		lw	$k1, addCounter
		add	$k1, $k1, $k0
		
		lw	$k0, ($k1)
		addi	$k0, $k0, 1
		sw	$k0, ($k1)
		
		j 	ret
		
	break10Int:
		lw $k0, currentProgram 			# i = currentProgram
		mul $k0, $k0, 4			
		addi $k1, $zero, 1				
		sw $k1, finishedPrograms($k0)	# finishedProgram[i] = 1
		
		addi $k0, $zero, 0 				# arg = 0 
		
		j goAhead
		


########################### Preparense para los problemas ########################### 

.macro load_auxiliar_registers(%type) 
	sw $k0, additionalSpace
	lw $k0, someRegistersArray
	
	lw $t0, 0($k0) 
	lw $t1, 4($k0) 
	lw $t2, 8($k0) 
	lw $t3, 12($k0) 
	lw $t4, 16($k0) 
	lw $t5, 20($k0) 
	lw $t6, 24($k0)
	lw $t7, 28($k0)
	lw $s0, 32($k0)
	lw $s1, 36($k0) 
	lw $s2, 40($k0) 
	lw $s3, 44($k0)
	lw $s4, 48($k0) 
	lw $s5, 52($k0) 
	lw $s6, 56($k0) 
	lw $s7, 60($k0)
	
	lw $k0, additionalSpace	
.end_macro

.macro store_auxiliar_registers

	sw $k0, additionalSpace
	lw $k0, someRegistersArray
	
	sw $t0, 0($k0) 
	sw $t1, 4($k0) 
	sw $t2, 8($k0) 
	sw $t3, 12($k0) 
	sw $t4, 16($k0) 
	sw $t5, 20($k0) 
	sw $t6, 24($k0)
	sw $t7, 28($k0)
	sw $s0, 32($k0)
	sw $s1, 36($k0) 
	sw $s2, 40($k0) 
	sw $s3, 44($k0)
	sw $s4, 48($k0) 
	sw $s5, 52($k0) 
	sw $s6, 56($k0) 
	sw $s7, 60($k0)
	
	lw $k0, additionalSpace
.end_macro

############################ **GoAheadRoutine**(arg, i)
##Esta funcion recibe 2 argumentos, pero como no nos estamos rigiendo por las convenciones
##usaremos i = $k0 y arg = $k1

goAhead:
	
	store_auxiliar_registers		#Almaceno los valores de algunos registros en memoria para poder usar los registros
	addi $s0, $zero, 0 							#closeCounter = 0 
	addi $t0, $k0, 0				#Decidi no complicarme y usar solo registros distintos a k
	addi $t1, $k1, 0
	
	whileActivePrograms: 						# while (closeCounter != NUM_PROGS ) 
		beq $s0, NUM_PROG, exitWhileActiveProgams	

		lw $s1, finishedProgram($t0) 		
		bne $s1 ,0, continueSearch				# if ( finishedProgram[i] == 0 ) : se hallo un programa activo
		
		load_auxiliar_registers		# Primero, cargo los viejos valores de los registros
		
		bne $t1, 1, ignoreStore					# if ( arg == 1 ) : almacena los registros en registerValues[currentProgram]

		store_registers
		
		ignoreStore: 
			
			retrieve_registers		#Aqui no importa que use $k0 o $k1 en store o retrieve porque
									#Luego de esto paso al main??
			lw $t0, programReturn($t0) 
			mtc0 $t0, $14
			eret					#Se supone que esto regresa a la ejecucion del programa
			
		continueSearch: 
		
			addi $t0, $t0, 4					# i += 1
			addi $s0, $s0, 1					# closeCounter += 1 
		
			j whileActivePrograms		
	exitWhileActivePrograms:


############################ **MacroToRetrieveRegisters**

.macro retrieve_registers
			lw	$k0, currentProgram
			mul $k0, $k0, 4
			lw 	$k1, registerValues($k0)
			lw $k1, 0($k1)
			
			lw $at, 0($k1)
			lw $v0, 4($k1)
			lw $v1, 8($k1)
			lw $a0, 12($k1)
			lw $a1, 16($k1)
			lw $a2, 20($k1)
			lw $a3, 24($k1)
			lw $t0, 28($k1)
			lw $t1, 32($k1)
			lw $t2, 36($k1)
			lw $t3, 40($k1)
			lw $t4, 44($k1)
			lw $t5, 48($k1)
			lw $t6, 52($k1)
			lw $t7, 56($k1)
			lw $s0, 60($k1)
			lw $s1, 64($k1)
			lw $s2, 68($k1)
			lw $s3, 72($k1)
			lw $s4, 76($k1)
			lw $s5, 80($k1)
			lw $s6, 84($k1) 
			lw $s7, 88($k1) 
			lw $t8, 92($k1)
			lw $t9, 96($k1)
			
.end_macro

############################ **MacroToStoreRegisters** 

.macro store_registers
			lw	$k0, currentProgram
			mul $k0, $k0, 4
			lw 	$k1, registerValues($k0)
			lw $k1, 0($k1) 
			
			sw $at, 0($k1)
			sw $v0, 4($k1)
			sw $v1, 8($k1)
			sw $a0, 12($k1)
			sw $a1, 16($k1)
			sw $a2, 20($k1)
			sw $a3, 24($k1)
			sw $t0, 28($k1)
			sw $t1, 32($k1)
			sw $t2, 36($k1)
			sw $t3, 40($k1)
			sw $t4, 44($k1)
			sw $t5, 48($k1)
			sw $t6, 52($k1)
			sw $t7, 56($k1)
			sw $s0, 60($k1)
			sw $s1, 64($k1)
			sw $s2, 68($k1)
			sw $s3, 72($k1)
			sw $s4, 76($k1)
			sw $s5, 80($k1)
			sw $s6, 84($k1) 
			sw $s7, 88($k1) 
			sw $t8, 92($k1)
			sw $t9, 96($k1)			


.end_macro

############################ **Interrupcion de teclado** 





















########################### Y mas vale que teman ########################### 			


ret:
# Return from (non-interrupt) exception. Skip offending instruction
# at EPC to avoid infinite loop.
#
	mfc0 $k0 $14		# Bump EPC register
	addiu $k0 $k0 4		# Skip faulting instruction
				# (Need to handle delayed branch case here)
	mtc0 $k0 $14


# Restore registers and reset processor state
#
	lw $v0 s1		# Restore other registers
	lw $a0 s2

	move $at $k1		# Restore $at

	mtc0 $0 $13		# Clear Cause register

	mfc0 $k0 $12		# Set Status register
	ori  $k0 0x1		# Interrupts enabled
	mtc0 $k0 $12

# Return from exception on MIPS32:
	eret 

# Return sequence for MIPS-I (R2000):
#	rfe			# Return from exception handler
				# Should be in jr's delay slot
#	jr $k0
#	 nop



# Standard startup code.  Invoke the routine "main" with arguments:
#	main(argc, argv, envp)
#
	.text
	.globl __start
#	.globl main
__start:
	lw $a0 0($sp)		# argc
	addiu $a1 $sp 4		# argv
	addiu $a2 $a1 4		# envp
	sll $v0 $a0 2
	addu $a2 $a2 $v0
	jal main
	nop

	li $v0 10
	syscall			# syscall 10 (exit)

	.globl __eoth
__eoth:


	################################################################
	##
	## El siguiente bloque debe ser usado para la inicialización
	## de las estructuras de datos que Ud. considere necesarias
	## 
	## Las etiquetas QUANTUM, PROGS, NUM_PROGS no deben bajo 
	## ABSOLUTAMENTE NINGUNA RAZON ser definidas en este archivo
	##
	################################################################
	
	.data
		movesArray: 		.word 	0	# Arreglo que contiene direcciones a los arreglos de movimientos.
		finishedProgram:	.word 	0	# Arreglo de 0 y 1 que nos dira si un programa ya termino o no.
		registerValues:		.word	0	# Arreglo que apunta a arreglos donde estan guardados los registros.
		programReturn:		.word	0 	# Arreglo que contendra la direccion en la que quedo cada programa.
		currentProgram:		.word 	0	# Entero que representa en que programa estamos.
		addCounter:		.word 	0	# Arreglo que lleva cuenta de cuantos add lleva cada programa.
		someRegistersArray: .space 64 # Arreglo utilizado para usar mas registros que los $k_i en el .ktext
		additionalSpace: .space 8 #
		

	################################################################
	##
	## El siguiente bloque debe ser usado para la inicialización
	## del planificador que Ud. considere necesarias, 
        ## instrumentación de los programas
        ## activación de interrupciones
	## inicialización de las estructuras
	## el mecanismo que comience la ejecución del primer programa
	################################################################

	.text
	.globl main
main:
	
	lw 	$t0, NUM_PROGS
	move	$a0, $t0
	sll	$a0, $a0, 2
	li	$v0, 9
	syscall				# Here we ask for space for the array that contains the arrays of moves.
	
	sw	$v0, movesArray
	move	$t2, $v0
	
	
	la	$t3, PROGS
	
	whileToCallgetMoves:
		beqz	$t0, exitWhilegetMoves
		
		lw	$t1, ($t3)
		addi	$a0, $t1, 0
		jal	getMoves
		sw	$v0, ($t2)		# Here we save the address of the array in movesArray
		
		addi	$t2, $t2, 4
		addi	$t0, $t0, -1
		addi 	$t3, $t3, 4
		j whileToCallgetMoves


	exitWhilegetMoves:
	
	
	lw	$t0, NUM_PROGS
	la	$t1, PROGS
	lw	$t2, movesArray
	
	whileToCallMoveInstructions:
		beqz 	$t0, exitCallMoveInstructions
		
		lw	$a0, ($t1)
		lw	$a1, ($t2)
		
		jal	moveInstructions
		
		
		addi	$t1, $t1, 4
		addi	$t2, $t2, 4
		addi	$t0, $t0, -1
		j	whileToCallMoveInstructions
	exitCallMoveInstructions:
	
		
	lw 	$t0, PROGS
	lw 	$t1, movesArray
	lw 	$t2, NUM_PROGS
	addi 	$t3, $zero, 0
	
	WhileToUpdateBeqs: 
		beqz 	$t2, exitWhileToUpdateBeqs

		addi 	$a0, $t0, 0
		addi 	$a1, $t1, 0
		
		jal 	updateBeqs
		
		addi 	$t3, $t3, 4				# Contador *4
		lw 	$t0, PROGS($t3)				# recibo el siguiente programa
		lw 	$t1, movesArray($t3)			# recibo el siguiente arreglo de movimientos
		addi 	$t2, $t2, -1
		
		j 	WhileToUpdateBeqs
	
	exitWhileToUpdateBeqs: 


			
	# Aqui solicitaremos el espacio necesario para nuestro manejador de interrupciones
	
	lw	$t0, NUM_PROGS
	sll	$t0, $t0, 2
	addi	$a0, $t0, 0
	li	$v0, 9
	syscall					# Este sera el espacio para el arreglo de programas terminados
	
	move	$t1, $v0
	sw	$t1, finishedProgram
	
	lw	$t0, NUM_PROGS
	sll	$t0, $t0, 2
	addi	$a0, $t0, 0
	li	$v0, 9
	syscall					# Este sera el espacio para un arreglo que apunta a arreglos donde estaran los valores de los registros guardados
	
	move 	$t1, $v0
	sw	$t1, registerValues
	
	add	$t0, $t0, $t1
	
	whileToGetArrays:
		beq	$t0, $t1, exitGetArrays
		
		li	$a0, 100			# Este es el espacio necesario para guardar los 25 registros, del $at al $t9
		li	$v0, 9
		syscall
		
		sw	$v0, ($t1)
	
	
		addi	$t1, $t1, 4
		j 	whileToGetArrays
	exitGetArrays:
	
	lw	$t0, NUM_PROGS
	sll	$t0, $t0, 2
	addi	$a0, $t0, 0
	li	$v0, 9					# Este sera el arreglo que tendra donde quedo cada programa.
	syscall	
	
	move 	$t1, $v0
	sw	$t1, programReturn

	lw	$t3, NUM_PROGS	
	la	$t2, PROGS
	whileToPlaceRet:
		beqz	$t3, exitPlaceRet
		
		lw	$t4, ($t2)
		sw	$t4, ($t1)
		
		addi	$t3, $t3, -1
		addi	$t2, $t2, 4
		addi	$t1, $t1, 4
		j 	whileToPlaceRet
	exitPlaceRet:
	
	lw	$t0, NUM_PROGS
	sll	$t0, $t0, 2
	addi	$a0, $t0, 0
	li	$v0, 9					# Este sera el arreglo que tendra cuantos add lleva cada programa.
	syscall	
	
	move 	$t1, $v0
	sw	$t1, addCounter

	
### ESPACIO DE PRUEBA ###################	
	store_registers
	
	addi $v0, $zero, 5
	addi $v1, $zero, 7
	addi $a0, $zero, 8

	
	retrieve_registers
		
	lw $t1, PROGS 
	jr $t1

	
	

				
												
						
fin:
	li $v0 10
	syscall			# syscall 10 (exit)
	
funciones:
	.include "getMoves.s"
	.include "moveInstructiones.s"
	.include "updateBeqs.s"
