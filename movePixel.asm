.data
	.align 2 # ensure word-aligned bitmap array
	bitmap: .space 262144 # allocate 256x256 bytes (pixels) to draw
	inputKey: .space 1

.text
	li $s7, 0x00000000 # color black (0x00RRGGBB)
	li $s1, 0x00FF0000 # color red (0x00RRGGBB)
	li $a0, 0 # x coord
	li $a1, 0 # y coord
	move $a3, $s1 # color
	li $s0, 0 # current pixel pos
	
	# Draw pixel going across 32x32 grid
	loop:
		bge $s0, 1024, end

		li $t0, 32
		div $s0, $t0
		mfhi $a0 # x = pos % 32
		mflo $a1 # y= pos // 32
		move $a3, $s1 # set color red
		jal drawPixel 
		
		jal delay
		
		# clean pixel
		move $a3, $s7 # change color to black
		jal drawPixel

		# increment pixel pos
		addi $s0, $s0, 1
	j loop
	
	# def delay(int $a0: amount)
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
	
	awaitInput:
		addi $sp, $sp -8
		sw $ra, 0($sp)
		sw $v0, 4($sp)
		
		la $a0, inputKey
		li $a1, 1
		li $v0, 8
		syscall # reads char into inputKey
		
		lb $s6, inputKey # input stored inside s6
		
		beqz $v0, end
		
		lw $v0, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 8
		jr $ra
	
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
	
	
