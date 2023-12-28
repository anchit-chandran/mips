.data
	widthPrompt: .asciiz "Enter width (integer): "
	heightPrompt: .asciiz "Enter height (integer): "
	width: .word 1 # int width;
	height: .word 1 # int height;
	
	area: .word 1 # int area;
	perimeter: .word 1 # int perimeter;
	
	answerMsgArea: .asciiz "Rectangle's area is "
	answerMsgPerimeter: .asciiz "Rectangle's perimeter is "
	
	newLine: .asciiz "\n"

.text
	main:
	# Input width, store 
	la $a0, widthPrompt
	jal printMsg
	li $v0, 5  
	syscall
	
	# if 0, end program
	beqz $v0, end
	sw $v0, width
	
	# Input height, store 
	la $a0, heightPrompt
	jal printMsg
	li $v0, 5  
	syscall
	sw $v0, height
	
	
	lw $s0, width
	lw $s1, height
	
	# calculate area, store
	jal calcArea
	
	# Calculate perimeter, store
	jal calcPerimeter
	
	# Print area
	la $a0, answerMsgArea
	lw $a1, area
	jal printResultMsg
	
	# print perimeter
	la $a0, answerMsgPerimeter
	lw $a1, perimeter
	jal printResultMsg
	
	# Print new line
	la $a0, newLine
	jal printMsg
	
	j main
	
	end:
	li $v0, 10
	syscall

# def printResultMsg(memoryAddress msg($a0), int value($a1)) -> None
printResultMsg:
	# Create stack space for $ra
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	jal printMsg
	move $a0, $a1 # move int value to print next to msg into $a0
	li $v0, 1
	syscall
	
	# print new line
	la $a0, newLine
	jal printMsg
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# def printMsg(memoryAddress msg($a0))-> None
printMsg:
	# Create stack space for $a0
	addi $sp, $sp, -4
	sw $a0, 0($sp)

	li $v0, 4
	syscall
	
	# Reset stack
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	jr $ra

calcArea:
	lw $t0, width
	lw $t1, height
	
	# Calculate area
	mult $t0, $t1
	mflo $v0 # move into result register
	sw $v0, area # store area in memory
	
	jr $ra

# def calcPerimeter() -> None
calcPerimeter:
	sll $t1, $s0, 1 # width * 2
	sll $t2, $s1, 1 # height * 2
	add $s0, $t1, $t2
	sw $s0, perimeter 
	jr $ra
