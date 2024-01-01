.data
	.align 2 # ensure word-aligned bitmap array
	bitmap: .space 262144 # allocate 256x256 bytes (pixels) to draw

.text

	li $s1, 0x00FF0000 # color red (0x00RRGGBB)
	
	
	# 32x32 grid
	li $a0, 31 # x coord
	li $a1, 31 # y coord
	move $a3, $s1 # color
	jal drawPixel
	
	
	
	end:
	li $v0, 10
	syscall
	
	# def drawPixel(int x, int y, color)->None
	# x: a0, y: a1, color: a3
	drawPixel:
		addi $sp, $sp, -4 # first save ra on stack
		sw $ra, 0($sp)
		
		jal calcPixelCoord
		sw $a3, 0($v0) # draw pixel at address
		
		# Clean stack
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	# Assume 32x32 ints:: a0: int x, a1: int y -> v0: int positionToDrawPixel
	calcPixelCoord:
		addi $sp, $sp, -4 # first save ra on stack
		sw $ra, 0($sp)
	
		li $t1, 4 # pixel size
		la $t0, 0($gp) # base address for bitmap
	
		# memmoryAddr = baseAddr + x + y
		# x = (4*col)
		# y = (256*4*row of 8x8 blocks)
	
		# first calculate x:  -> store inside $t2
		mul $t2, $t1, $a0 # 4*x
	
		# calculate y: -> store inside $t3 
		li $t3, 128 # Offset for one 8x8 block down from the top
    		mul $t3, $t3, $a1 # Offset for the desired row
	
		# sum baseAddr to x+y
		add $t3, $t3, $t2 # x + y
		add $v0, $t0, $t3 # baseAdrr + (x+y)
		
		# sum baseAddr to x+y
   		add $v0, $t0, $t3 # baseAddr + (x+y)
	
		# Address to draw pixel stored in $v0
		
		# Clean stack
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	