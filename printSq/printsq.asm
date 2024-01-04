.data
	space: .asciiz " "
	star: .asciiz "*"
	newLine: .asciiz "\n"
	
	inputPrompt: .asciiz "Enter size of rectangle: "

.text	
	# Get user input for size of rectangle
	la $a0, inputPrompt
	li $v0, 4
	syscall
	
	li $v0, 5 # read int
	syscall
	move $s7, $v0 # move user input nStars into $s7
	
	# print top line
	move $a0, $s7
	jal printTopBottomLine
	
	jal printNewLine
	
	# print middle lines
	move $a0, $s7
	jal printMiddleLine
	
	# print bottom line
	move $a0, $s7
	jal printTopBottomLine
	
	end:
	li $v0, 10
	syscall
	
	# void printNewLine()
	printNewLine:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	# void printMiddleLine($a0: int nStars)
	printMiddleLine:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		addi $a0, $a0, -2 # loops all execute n-2 times
		move $t1, $a0 # move total n stars into $t0
		move $t2, $a0 # copy n stars into $t1 for outer loop iterator
		outerMiddleStarLoop:
			beqz $t2, endOuterMiddleStarLoop
		
			# print leftmost star
			la $a0, star
			li $v0, 4
			syscall
		
			# print n-2 spaces
			la $a0, space
			li $v0, 4
			move $t3, $t1 # copy nstars into $t2 for inner loop iterator
			spaceLoop:
				beqz $t3, endSpaceLoop # finished printing spaces -> break
			
				syscall # print space, already loaded
			
				addi $t3, $t3, -1 # decrement iterator
				j spaceLoop
	
			endSpaceLoop:
		
			# print rightmost star
			la $a0, star
			li $v0, 4
			syscall
			
			# print new line
			addi $sp, $sp, -16 # require $a0, $t-3, so save onto stack before calling newLine proc
			sw $a0, 0($sp)
			sw $t1, 4($sp)
			sw $t2, 8($sp)
			sw $t3, 12($sp)
			jal printNewLine
			lw $t3, 12($sp)
			lw $t2, 8($sp)
			lw $t1, 4($sp)
			lw $a0, 0($sp)
			addi $sp, $sp, 16 # clean stack
			
			
			addi $t2, $t2, -1
			j outerMiddleStarLoop
		
		endOuterMiddleStarLoop:
		
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	
	# void printTopBottomLine($a0: int nStars)
	printTopBottomLine:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		move $t0, $a0 # move n stars to print into $t0
		printStarLoop:
			beqz $t0, endPrintStarLoop # no more stars left to print -> break
			la $a0, star
			li $v0, 4
			syscall
			
			addi $t0, $t0, -1
			j printStarLoop
		
		endPrintStarLoop:
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
