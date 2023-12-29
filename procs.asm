.data
	newLine: .asciiz "\n"

.text


	# initialise value inside $s0
	addi $s0, $0, 10
	
	# print double value
	jal printDouble
	
	# print new ln
	la $a0, newLine
	li $v0, 4
	syscall
	
	# print initial value
	jal printNumber
	
	# End prog
	li $v0, 10
	syscall
	
	# ($s0:int) -> None
	printDouble:
		# we have a value inside $s0 that will be modified
		# so we must add to stack.
		# also we have nested proc printNumber so we also 
		# need to save $ra
		
		# first make space - only have a single 4 byte val
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $ra, 4($sp) # printNumber will overwrite $ra, so we won't be able to return to main otherwise
		
		# now get the value, double it
		sll $s0, $s0, 1
		
		jal printNumber

		lw $s0, 0($sp) # reset $s0
		lw $ra, 4($sp) # reset to main's $ra
		addi $sp, $sp, 4 # reset stack
		
		jr $ra
	
	printNumber:
		# print the val inside $s0
		move $a0, $s0
		li $v0, 1
		syscall
		
		jr $ra
