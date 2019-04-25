.text

free:
	# This function receives a memory address in which begins a memory block that is in use.
	# Returns 0 if the operation was successful, -2 if the address is not being used.
	
	
						# First we'll save the values of the registers that we'll use in the stack.
	sw 	$s0, 0($sp)
	sw 	$s1, -4($sp)
	sw 	$s2, -8($sp)
	
	addi 	$sp, $sp, -12			# sp = sp - 12
	
	addi	$s0, $a0, 0			# s0 = address to be freed.
	
	lw	$s1, memoryBlockStart		# s1 = memoryBlockStart
	
	sub	$s0, $s0, $s1			# s0 = s0 - s1
	div	$s0, $s0, 4
	
	lw 	$s1, freeList			# s1 = freeList
	
	add	$s0, $s0, $s1			# This is the address where the block begins in our freeList.
	
	lb	$s1, ($s0)
	addi 	$s2, $zero, 2			# byte to compare.
	
	bne	$s1, $s2, errorNotUsedSpace	# If the space is not being used, there's an error in the input.
						# else, free the freeList space.
	
	addi	$s2, $zero, 0
	
	sb	$s2, ($s0)
	
	addi 	$s0, $s0, 1
	lb 	$s1, ($s0)
	
	whileToFree:				# while s1 != 1
		bne	$s1, 1, exitWhileToFree	# if s1 == 1 exit.
		
		sb 	$s2, ($s0)		# place 0 in freeList.
		addi	$s0, $s0, 1		# indexx++
		lb	$s1, ($s0)		# Load next byte in freeList to compare.
		
		j 	whileToFree
		
	exitWhileToFree:
	
		addi	$v0, $zero, 0
	
		j 	exitFree
	
	errorNotUsedSpace:
	
		addi	$v0, $zero, -2
	
		j 	exitFree
	
	exitFree:
	
						# Now we'll restore the registers that we saved in the stack.
		lw 	$s2, 4($sp)
		lw 	$s1, 8($sp)
		lw 	$s0, 12($sp)
		
		addi 	$sp, $sp, 12		# Here we restore the stack pointer value.		
		
		jr 	$ra			# Return to the caller.
	
	
	
	
	
	
	
	
	
	
	
