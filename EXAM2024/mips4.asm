.data
	array: .word 3, 32, 7, 43, 2, 19, 18, 27, 36, 15
	lenArray: .word 10
.text
	la $a0, array # load arry pointer into arg 0
	jal max_array 
	
	move $a0, $v0 # move largest element from array into print_int arg0
	li $v0, 1 # print largest int element
	syscall


	end:
	li $v0, 10
	syscall
	
	# def max_array($a0: int[] array POINTER)-> $v0 int
	max_array:
		addi $sp, $sp, -4 # add to stack
		sw $ra, 0($sp)
		
		li $t7, 0 # current_highest el
		la $t1, array # load array pointer into $t1
		
		# for element in array
		lw $t0, lenArray # for iterator variable i
		
		
		forLoop:
			beqz $t0, afterLoop # if i == 0, exit
			lw $t2, 0($t1) # load el at current index into t2
		
			# if el > $t7 (current highest), then set $t7 to el
			blt $t2, $t7, notHigher # if current el not > current highest, skip
			move $t7, $t2 # set to new el
		
			notHigher:
			addi $t0, $t0, -1 # decrement i
			addi $t1, $t1, 4 # move array pointer to next el
			j forLoop
		
		afterLoop:
		
		move $v0, $t7 # t7 contains highest el -> move to output reg
		
		lw $ra, 0($sp) 
		addi $sp, $sp, 4 # clean stack
		jr $ra