.data
	.align 2 # ensure word-aligned bitmap array
	bitmap: .space 262144 # allocate 256x256 bytes (pixels) to draw
	red: .word 0x00FF0000 # red hex val
	black: .word 0x00000000 # black color

.text	

	# start pixel middle
	# 32x32 grid
		li $a0, 16 # x=16
		li $a1, 16 # y=16
		lw $a3, red # color=red
		jal drawPixel
	
	mainLoop:
		# get user input
		lw $s0, 0xffff0004
		beq $s0, 0x31, end # if user presses q -> end
		
		# convert input to LRUD 0123
		beq $s0, 0x61, pressLeft   # a
		beq $s0, 0x64, pressRight # d
		beq $s0, 0x77, pressUp # w 
		beq $s0, 0x73, pressDown # s

		updatePixel:
		jal delay

		j mainLoop
	
	end:
	li $v0, 10
	syscall
	
		pressLeft:
			jal movePixelLeft
			j updatePixel
		pressRight:
			jal movePixelRight
			j updatePixel
		pressUp:
			jal movePixelUp
			j updatePixel
		pressDown:
			jal movePixelDown
			j updatePixel
	
	# def delay()
	delay:
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $t0, 4($sp)
		
		li $t0, 500
		delayLoop:
			beqz $t0, endDelayLoop
			addi $t0, $t0, -1 # decrement 
			j delayLoop
		endDelayLoop:
		lw $t0, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 8
		jr $ra
		
	# pixel always starts at (16,16)
	# def movePixelLeft()->None:
	movePixelLeft:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# first check if has space to move left i.e. if $a0 < 0: don't move
		ble $a0, 0, outboundLeft
		
		# color current pixel location black
		lw $a3, black
		jal drawPixel
		
		# draw red pixel @ (x-1, y)
		addi $a0, $a0, -1
		lw $a3, red
		jal drawPixel
		
		outboundLeft:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	# def movePixelRight()->None:
	movePixelRight:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# first check if has space to move right i.e. if $a0 >= 31: don't move
		bge $a0, 31, outboundRight
		
		# color current pixel location black
		lw $a3, black
		jal drawPixel
		
		# draw red pixel @ (x+1, y)
		addi $a0, $a0, 1
		lw $a3, red
		jal drawPixel
		
		outboundRight:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	# def movePixelDown()->None:
	movePixelDown:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# first check if has space to move down i.e. if $a0 > 31: don't move
		bge $a1, 31, outboundDown
		
		# color current pixel location black
		lw $a3, black
		jal drawPixel
		
		# draw red pixel @ (x, y+1)
		addi $a1, $a1, 1
		lw $a3, red
		jal drawPixel
		
		outboundDown:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	# def movePixelUp()->None:
	movePixelUp:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# first check if has space to move up i.e. if $a1 <= 0: don't move
		blez $a1, outboundUp
		
		# color current pixel location black
		lw $a3, black
		jal drawPixel
		
		# draw red pixel @ (x, y-1)
		addi $a1, $a1, -1
		lw $a3, red
		jal drawPixel
		
		outboundUp:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		

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
	
	
