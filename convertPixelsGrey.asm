<<<<<<< HEAD
# 0x00 01 ff 22 has color components: red = 1 (or 0x01), green = 255 (or 0xff), blue = 34 or (0x22)

.data
	pixelRGB:   .word   0x00010000, 0x010101, 0x6, 0x3333, 0x030c, 0x700853, 0x294999, -1
	red: .word 0
	green: .word 0
	blue: .word 0 
	grey: .word 0
	mask: .word 0x00ff
	
	initPrompt: .asciiz "Converting pixels to greyscale.\n"
	newLine: .asciiz "\n\n"
	
.text	

la $s0, pixelRGB

loop:
	# Access element from pixelRGB array
	lw $a0, 0($s0)
	
	# If END value -1, terminate
	beq $a0, -1, end
	
	# get blue amount by applying mask that keeps last 2 hexadecimal bits, store in int blue;
	la $a1, blue
	jal extractLast2Pixels
	
	# get green amount by applying mask that keeps last 2 hexadecimal bits, store in int green;
	srl $a0, $a0, 8 # remove 2 blue hexadecimal bits from end
	la $a1, green
	jal extractLast2Pixels
	
	# get red amount by applying mask that keeps last 2 hexadecimal bits, store in int red;
	srl $a0, $a0, 8 # remove 2 blue hexadecimal bits from end
	la $a1, red
	jal extractLast2Pixels
	
	# Convert saved pixels to grey, store in int grey;
	jal rgbToGrey
	
	# Output grey
	lw $a0, grey
	li $v0, 34
	syscall
	
	# Move to next element
	addi $s0, $s0, 4
	
	# Print newline
	la $a0, newLine
	li $v0, 4
	syscall
	
	j loop
	
	end:
	li $v0, 10
	syscall

# int rgbToGrey()->None
rgbToGrey:
	# sum rgb values
	lw $t0, red
	lw $t1, green
	lw $t2, blue
	li $t3, 0 # initialise grey var to 0
	add $t3, $t0, $t1 # red + green
	add $t3, $t3, $t2 # rg + blue
	
	# divide by 3
	div $t3, $t3, 3
	
	# Store grey amount in var
	sw $t3, grey
	
	jr $ra

# def extractLast2Pixels($a0: pixel value, $a1: save address of last 2 hexabits) -> None
extractLast2Pixels:
	lw $t0, mask 
	and $t0, $a0, $t0 # keeps only last 2 hexabits
	sw $t0, 0($a1) # store at defined memory adderss
=======
# 0x00 01 ff 22 has color components: red = 1 (or 0x01), green = 255 (or 0xff), blue = 34 or (0x22)

.data
	pixelRGB:   .word   0x00010000, 0x010101, 0x6, 0x3333, 0x030c, 0x700853, 0x294999, -1
	red: .word 0
	green: .word 0
	blue: .word 0 
	grey: .word 0
	mask: .word 0x00ff
	
	initPrompt: .asciiz "Converting pixels to greyscale.\n"
	newLine: .asciiz "\n\n"
	
.text	

la $s0, pixelRGB

loop:
	# Access element from pixelRGB array
	lw $a0, 0($s0)
	
	# If END value -1, terminate
	beq $a0, -1, end
	
	# get blue amount by applying mask that keeps last 2 hexadecimal bits, store in int blue;
	la $a1, blue
	jal extractLast2Pixels
	
	# get green amount by applying mask that keeps last 2 hexadecimal bits, store in int green;
	srl $a0, $a0, 8 # remove 2 blue hexadecimal bits from end
	la $a1, green
	jal extractLast2Pixels
	
	# get red amount by applying mask that keeps last 2 hexadecimal bits, store in int red;
	srl $a0, $a0, 8 # remove 2 blue hexadecimal bits from end
	la $a1, red
	jal extractLast2Pixels
	
	# Convert saved pixels to grey, store in int grey;
	jal rgbToGrey
	
	# Output grey
	lw $a0, grey
	li $v0, 34
	syscall
	
	# Move to next element
	addi $s0, $s0, 4
	
	# Print newline
	la $a0, newLine
	li $v0, 4
	syscall
	
	j loop
	
	end:
	li $v0, 10
	syscall

# int rgbToGrey()->None
rgbToGrey:
	# sum rgb values
	lw $t0, red
	lw $t1, green
	lw $t2, blue
	li $t3, 0 # initialise grey var to 0
	add $t3, $t0, $t1 # red + green
	add $t3, $t3, $t2 # rg + blue
	
	# divide by 3
	div $t3, $t3, 3
	
	# Store grey amount in var
	sw $t3, grey
	
	jr $ra

# def extractLast2Pixels($a0: pixel value, $a1: save address of last 2 hexabits) -> None
extractLast2Pixels:
	lw $t0, mask 
	and $t0, $a0, $t0 # keeps only last 2 hexabits
	sw $t0, 0($a1) # store at defined memory adderss
>>>>>>> 9095b893ffa09dcf2d3608cea81aeb317439ec46
	jr $ra