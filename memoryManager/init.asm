.data
	freeList:		.word 	0	# Memory address where the freeList begins.
	freeListSize: 		.word 	0	# Size of the freeList.
	memoryBlockStart: 	.word 	0	# Memory address where the memory block starts.
	memoryBlockSize: 	.word 	0	# Size of the memory block.
	.globl freeList, freeListSize, memoryBlockStart, memoryBlockSize
	
.text


init:
	# This function receives an int (x) that represents an amount of bytes to be managed by the other functions.
	# It returns 0 if the operation was successful.
	

	sw 	$a0, memoryBlockSize		# Here we save the size of the memory block.
	
	li 	$v0, 9				# Here we get the addres of the memory block.
	syscall
	
	sw 	$v0, memoryBlockStart 		# Here we save the addres of the memory block.
	
						# Now we'll save the values of the registers that we'll use in the stack.
	sw 	$s0, 0($sp)
	sw 	$s1, -4($sp)
	sw 	$s2, -8($sp)
	sw 	$s3, -12($sp)
	
	addi 	$sp, $sp, -16			# sp = sp - 16
	
	lw 	$s0, memoryBlockSize
	addi 	$s0, $s0, 3
	div	$s0, $s0, 4			# s0 = ( s0 + 3 ) // 4  || This will be the size of our free list.
	
	sw 	$s0, freeListSize		# Here we save the size of the free list.
	
	addi 	$a0, $s0, 0
	li 	$v0, 9
	syscall					# Here we ask for the space for our free list.
	
	sw	$v0, freeList
	
	addi 	$s1, $zero, 0			# i = s1 = 0
	addi	$s2, $zero, 0			# This is the byte we will asign to the free list.
	addi	$s3, $v0, 0			# Here we load the memory location of the freeList.
		
	initWhile:					# while index != freeListSize
		
		beq 	$s0, $s1, initExit	# if i == freeListSize exit
		
		sb	$s2, ($s3)		# (index) = 0
		
		addi	$s3, $s3, 1		# index++
		addi 	$s1, $s1, 1		# i++
		
		j initWhile
		
	initExit:
		li 	$v0, 0
		
						# Now we'll restore the registers that we saved in the stack.
		lw	$s3, 4($sp)
		lw 	$s2, 8($sp)
		lw 	$s1, 12($sp)
		lw 	$s0, 16($sp)
		
		addi 	$sp, $sp, 16		# Here we restore the stack pointer value.		
		
		jr 	$ra			# Return to the caller.
	
	
	
	
	
	
	
	
