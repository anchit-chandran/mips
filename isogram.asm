.data
	inputString: .asciiz "lumberjack"
	seenLetters: .space 100 # to add seen letters
	resultMsgTrue: .asciiz " is an isogram"
	resultMsgFalse: .asciiz " isn't an isogram"
	
.text
	la $a0, inputString
	jal isIsogram
	
	end:
	li $v0, 10
	syscall
	
	
	isIsogram:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		move $t0, $a0 # move input string into $t0
		la $s0, seenLetters # save seenLetters baseAddress
		# loop through inputString
		loop:
			lb $t1, 0($t0) # load letter
			beqz $t1, endLoop # end loop in null terminator
			
			# loop through seen letters
			seenLoop:
				lb $t3, 0($s0)
				beqz $t3, endSeenLoop
				
				# if letter == current seenLetter, then set $v0 to 1, exit
				beq $t1, $t3, foundSameLetter
				
				addi $t2, $t2, 1 # increment seenLetter to next 
				j seenLoop
			endSeenLoop:
			
			# got to end of loop without seeing letter -> append to seenLetters
			# first loop through seenLetters until find empty space @ null terminator
			# set up temp seenLetters pointer which can be incremented
			la $t3, 0($s0)
			findEmpty:
				lb $t4, 0($t3)
				beqz $t4, emptyFound # if empty, end iteration
				j findEmpty
			emptyFound:
				sb $t1, 0($t3) # store letter inside seenLetters array 
			
			
			addi $t0, $t0, 1 # increment to next letter
			j loop
		
		endLoop:
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	foundSameLetter:
		li $v0, 1 # set $v0 to 1
		j endLoop