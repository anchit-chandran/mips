<<<<<<< HEAD
.data
	widthPrompt: .asciiz "Enter width (integer): "
	heightPrompt: .asciiz "Enter height (integer): "
	width: .word 1 # int width;
	height: .word 1 # int height;
	area: .word 1 # int area;
	
	answerMsg: .asciiz "Rectangle's area is "

.text
	# Input width, store 
	la $a0, widthPrompt
	li $v0, 4
	syscall
	li $v0, 5  
	syscall
	sw $v0, width
	
	# Input height, store 
	la $a0, heightPrompt
	li $v0, 4
	syscall
	li $v0, 5  
	syscall
	sw $v0, height
	
	# Calculate area, store
	lw $s0, width
	lw $s1, height
	mult $s0, $s1 # width x height
	mflo $s0 # move area into $s0
	sw $s0, area
	
	# print area
	la $a0, answerMsg
	li $v0, 4
	syscall
	
	lw $a0, area
	li $v0, 1
	syscall
	
	end:
	li $v0, 10
=======
.data
	widthPrompt: .asciiz "Enter width (integer): "
	heightPrompt: .asciiz "Enter height (integer): "
	width: .word 1 # int width;
	height: .word 1 # int height;
	area: .word 1 # int area;
	
	answerMsg: .asciiz "Rectangle's area is "

.text
	# Input width, store 
	la $a0, widthPrompt
	li $v0, 4
	syscall
	li $v0, 5  
	syscall
	sw $v0, width
	
	# Input height, store 
	la $a0, heightPrompt
	li $v0, 4
	syscall
	li $v0, 5  
	syscall
	sw $v0, height
	
	# Calculate area, store
	lw $s0, width
	lw $s1, height
	mult $s0, $s1 # width x height
	mflo $s0 # move area into $s0
	sw $s0, area
	
	# print area
	la $a0, answerMsg
	li $v0, 4
	syscall
	
	lw $a0, area
	li $v0, 1
	syscall
	
	end:
	li $v0, 10
>>>>>>> 9095b893ffa09dcf2d3608cea81aeb317439ec46
	syscall