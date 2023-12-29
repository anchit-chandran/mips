.data
	star: .asciiz "*"
	newLine: .asciiz "\n"
	whiteSpace: .asciiz " "
	
	inputPrompt: .asciiz "Please enter height of tree: "
.text
	la $a0, inputPrompt
	li $v0, 4
	syscall
	
	# Get requested tree height, n, saved inside $s0
	li $v0, 5
	syscall
	move $s0, $v0 # userInputted n
	
	li $s1, 1 # initialise loop iterator i (=level)
	
	mainLoop:
		bgt $s1, $s0, endMainLoop # if (i > n) : break
		
		move $a0, $s1 #$a0 = level
		jal printSpaces
		
		move $a0, $s1
		jal printStars
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		add $s1, $s1, 1 # increment i
		j mainLoop
		
	endMainLoop:
		li $v0, 10
		syscall
	
	#$a0 = level
	# nStars to print: level*2 - 1
	printStars:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		move $t0, $a0 # move level into $t0
		sll $t0, $t0, 1 # level * 2
		addi $t0, $t0, -1 # (level*2) - 1
		
		starsLoop:
			beqz $t0, endStarsLoop
			
			# print star
			la $a0, star
			li $v0, 4
			syscall
			
			addi $t0, $t0, -1 # decrement iterator
			j starsLoop
		
		endStarsLoop:
		lw $ra, 0($sp)
		jr $ra
	
	# $a0 - level=1; $s0 - n
	# Print "\s" * (n - level)
	printSpaces:
		addi $sp, $sp, -4 # grow stack 2 words
		sw $ra 0($sp) # store ra
		
		move $t0, $a0 # move level into $t0: 1
		sub $t1, $s0, $t0 # calculate n(spaces) # calculate n(spaces) -> stored inside $t0: if 4 levels, = 3
		
		spacesLoop:
			beqz $t1, endSpacesLoop
			
			# Print whitespace
			la $a0, whiteSpace
			li $v0, 4
			syscall
			
			subi $t1, $t1, 1
			j spacesLoop
		
		endSpacesLoop:
		lw $ra, 0($sp)
		addi $sp, $sp, 4 # clean and return stack pointer
		jr $ra