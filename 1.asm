.data
	welcome: .asciiz "This program implements the equation E = Z*5/3 + 7\n\n"
	int_prompt: .asciiz "Enter an integer Z: "
	e_result: .asciiz "\nE = "
	left_side: .asciiz "\nLeft side"
	right_side: .asciiz "\nRight side"
	
	floats: .float 5.0, 3.0, 0.0
.text
	# Print welcome
	la $a0, welcome
	li $v0, 4
	syscall

	# Get Z input
	la $a0, int_prompt
	syscall
	
	li $v0, 5 
	syscall
	move $s0, $v0 # save input Z int inside $v0

	
	# First do 5/3
	la $t0, floats
	lwc1 $f0, 0($t0) # load 5.0
	lwc1 $f1, 4($t0) # load 3.0
	div.s $f2, $f0, $f1 # 5 / 3 -> store in $f2
	
	# Do Z * 5/3 -> store result in $f2
	mtc1 $s0, $f0 # move int into coprocessor
	cvt.s.w $f0, $f0
	mul.s $f2, $f0, $f2
	
	# Add 7
	li $t0, 7
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0
	add.s $f12, $f2, $f0
	
	# convert into int
	cvt.w.s $f12, $f12
	
	# move into reg
	mfc1 $s0, $f12
	
	# Prints "E = "
	la $a0, e_result
	li $v0, 4
	syscall
	
	# Print result, stored in $f12
	move $a0, $s0
	li $v0, 1
	syscall 
	
	# Branch if < 7 and print
	jal load_gt_or_lt # -> store string inside $a0
	li $v0, 4
	syscall


	li $v0, 10
	syscall

load_gt_or_lt:
	blt $s0, 7, less_than
	la $a0, left_side
	jr $ra
	less_than:
		la $a0, right_side
		jr $ra