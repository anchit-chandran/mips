.data
	inp_prompt: .asciiz "Please enter a number: "
	newLine: .asciiz "\n"

.text
	# print prompt
	la $a0, inp_prompt
	li $v0, 4
	syscall
	
	# get user input, stored in $v0 
	li $v0, 5
	syscall
	move $s0, $v0 # move into s0
	
	# set iterator var = 0
	li $t0, 1
	
	for_start:
		beq $t0, 101, end # goto end if iterator i > 100
		
		# if $s0 % $t0 == 0 {print $t0}
		
		# $s0 % $t0
		div $t0, $s0
		mfhi $t1 # move remainder into $t1
		bnez $t1, for_end # if remainder != 0 {continue}
		
		# % == 0 -> print $t0\n
		move $a0, $t0
		li $v0, 1
		syscall
		la $a0, newLine
		li $v0,4
		syscall
		
		for_end:
		addi $t0, $t0, 1 # i ++
		j for_start
	
	end:
	# end
	li $v0, 10
	syscall
