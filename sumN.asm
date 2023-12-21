.data
	prompt: .asciiz "Enter the number: "
	end_str: .asciiz "Sum = "
.text

	# Print prompt
	la $a0, prompt
	li $v0, 4
	syscall
	
	# Read int
	li $v0, 5
	syscall
	
	# Save input int inside $a0
	move $a0, $v0
	
	for_start:
		add $t0, $t0, $a0 # add sum, save into $t0
		subi $a0, $a0, 1 # decrement int
		beqz $a0, end
		j for_start
	end:
	
	la $a0, end_str
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
		