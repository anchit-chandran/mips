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
	
	# Calculate perimeter, store
	lw $s0, width
	lw $s1, height

	sll $t1, $s0, 1 # width * 2
	sll $t2, $s1, 1 # height * 2
	
	# perimeter(height) + perimeter(width)
	add $s0, $t1, $t2
	
	sw $s0, area # store area
	
	# print area
	la $a0, answerMsg
	li $v0, 4
	syscall
	
	lw $a0, area
	li $v0, 1
	syscall
	
	end:
	li $v0, 10
	syscall