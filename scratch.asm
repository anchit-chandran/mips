.data
	arr: .space 5
.text
	la $t0, arr # int[] arr;
	li $t2, 0 # int b;
	
	lw $t1, 24($t0) # a = arr[8];
	or $t1, $t1, $t2 # c = b | a
	sw $t1, 32($t0) # arr[9] = c;