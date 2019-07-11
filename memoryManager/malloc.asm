.text

malloc:
	# This function receives an int (x) that represents the asked size in bytes, and it returns the memory addres where
	# the block of x bytes begins. If there's not enought space it returns -1.


						# First we'll save the values of the registers that we'll use in the stack.
	sw 	$s0, 0($sp)
	sw 	$s1, -4($sp)
	sw 	$s2, -8($sp)
	sw 	$s3, -12($sp)
	sw	$s4, -16($sp)
	
	addi 	$sp, $sp, -20			# sp = sp - 20
	
	addi	$s0, $a0, 3		
	div	$s0, $s0, 4			# s0 = (askedBytes + 3) // 4 || This is the size that we need in our freeList.
	
	lw 	$s1, freeList			# s1 = memory address where the freeList starts.
	
	lw	$s2, freeListSize
	add 	$s2, $s2, $s1			# This is the addresss where the freelist ends.
	
	addi	$s3, $zero, 0			# freeList available bytes counter.
	
	
	mallocWhile1:				# While s1 != s2:
	
		beq	$s1, $s2, exitMalcWhile	# if s1 == s2, there is not enough space and exit.
		
		lb	$s4, ($s1)		# Load the byte in the freeList to check if there's space available.
		addi	$s1, $s1, 1		# index++
		
		beq 	$s4, 0, addToCounter	# if s4 == 0, counter++
		addi	$s3, $zero, 0		# else counter = 0.
		
		j 	mallocWhile1
		
	addToCounter:
		
		addi	$s3, $s3, 1
		
		beq	$s3, $s0, spaceFounded	# if s3 == s0, we have enough space and we'll return it
		j 	mallocWhile1		# else return to the while loop.
		
	spaceFounded:
		
		sub	$s2, $s1, $s0		# s2 = s1 - s0 || This will be the beginning of the space in the freeLis.
		
		addi	$s4, $zero, 2
		sb	$s4, ($s2)		# Now we place a 2 in the beginning of the asked space in the freeList.
		
		addi 	$s4, $zero, 1		# byte to place in freeList ocupiedspace
		
		addi	$s3, $zero, 1		# i = 1
		addi 	$s1, $s2, 1		# s1 = s2 + 1 || From here we will keep storing 1 to specify the space as ocupied.
		
		whileToFillFL:					# while s3 != s0:
		
			beq 	$s3, $s0, exitWhileToFill	# if s3 == s0 the freeList is completely modified and we can exit,
			
			sb 	$s4, ($s1)			# (index) = 1
			addi	$s1, $s1, 1			# index++
			addi	$s3, $s3, 1			# i++
			
			j whileToFillFL
	
	exitWhileToFill:
		
		lw 	$s0, freeList				# In this section we calculate the memory addres
		sub	$s2, $s2, $s0				# in the memory block.
		mul	$s2, $s2, 4
		
		lw 	$v0, memoryBlockStart
		add	$v0, $v0, $s2
		
		j exitMalloc
		
	exitMalcWhile:
	
		li	$v0, -1			# ERROR CODE: not enough space.
		j 	exitMalloc
		
	exitMalloc:
		
						# Now we'll restore the registers that we saved in the stack.
		lw	$s4, 4($sp)
		lw 	$s3, 8($sp)
		lw 	$s2, 12($sp)
		lw 	$s1, 16($sp)
		lw 	$s0, 20($sp)
		
		addi 	$sp, $sp, 20		# Here we restore the stack pointer value.		
		
	
	
		jr	$ra			# Return to the caller.
		
		
	
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
