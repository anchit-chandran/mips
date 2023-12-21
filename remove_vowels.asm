.data
	vowels: .asciiz "aeiouAEIOU"
	input_string: .space 101
	return_address: .space 100
	input_prompt: .asciiz "Enter a string: "
.text

main:
	jal get_input # stores input in $a0
	move $s0, $a0 # keep input address safe inside $s0
	la $s1, return_address # load return addy inside $s1
	
	# Loop through input string
	for_input_letter:
		la $s2, vowels # store vowel pointer inside $s2
		
		lb $t0, 0($s0) # store letter inside $t0
		beq $t0, 0, for_input_end 
		
		# loop through vowels. if equal to any, end loop, go to next letter
		for_vowel:
			lb $t1, 0($s2) # load current vowel into $t1
			beq $t1, 0, for_vowel_end # end for loop if null terminator
			
			beq $t0, $t1, for_vowel_end # if letter is vowel, go to next iteration
			
			# else, add letter to return address
			sb $t0, 0($s1)
			addi $s1, $s1, 1 # increment return_add pointer
			
			addi $s2, $s2, 1 # increment vowel pointer
			j for_vowel
		
		for_vowel_end:
		
		
		addi $s0, $s0, 1 # increment input letter pointer
		j for_input_letter
	for_input_end:
	
	li $v0, 10
	syscall

get_input:
	la $a0, input_prompt
	li $v0, 4
	syscall
	
	la $a0, input_string
	li $a1, 100
	li $v0, 8
	syscall
	
	jr $ra