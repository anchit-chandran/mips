.data

	string1: .asciiz "GAGCCTACTAACGGGAT"
	string2: .asciiz "CATCGTAATGACGGCCT"
	
	resultMsg: "The Hamming distance is: "

.text
	# Get strings into input regs
	la $a0, string1
	la $a1, string2
	
	jal calcHammingDistance
	move $s0, $v0 # move int hammingDistance into saved reg
	
	# s0 contains int hammingDistance -> print out
	la $a0, resultMsg # print result msg
	li $v0, 4
	syscall
	
	move $a0, $s0
	li $v0, 1
	syscall
	
	end:
		li $v0, 10
		syscall
	
	calcHammingDistance:
		
		addi $sp, $sp, -4 # create space on stack
		sw $ra, 0($sp) # save current return address
		
		li $v0, 0 # initialise $v0 int hammingDistance = 0
		
		loop:
			# load each comparison letter
			lb $t1, 0($a0) # load letter from string 1
			lb $t2, 0($a1) # load letter from string 2
			
			# terminate if null char
			beqz $t1, endLoop # both will be same len so can just check one
			
			# if (t1 == t2) {$v0 += 1}
			beq $t1, $t2, equal # if equal, skip to next iteration
			addi $v0, $v0, 1 # letters not equal -> increment $v0
			
			equal:
			add $a0, $a0, 1 # increment string 1 letter to next letter (1 byte along)
			add $a1, $a1, 1 # increment string 2 letter
			j loop
		
		endLoop:
		
		lw $ra, 0($sp) # load back prev return address
		addi $sp, $sp, 4 # clean stack
		jr $ra