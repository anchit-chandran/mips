.data
	name_prompt: .asciiz "Enter your name: "
	birth_prompt: .asciiz "Enter your year of birth: "
	hello: .asciiz "Hello "
	eligible: .asciiz "You are eligible to vote."
	ineligible: .asciiz "You are not eligible to vote."
	
	name: .space 100
	dob: .space 4
	
	endSentence: .asciiz ". "

.text

	la $a0, name_prompt
	li $v0, 4
	syscall
	
	# store name input
	la $a0, name # will store input at memory label name
	li $a1, 99
	li $v0, 8
	syscall 
	
	# Get and store age
	la $a0, birth_prompt
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall 
	sw $v0, dob # store dob
	
	# Calc age
	lw $t0, dob # get dob into $t0
	li $t1, 2023 # store current year
	sub $t2, $t1, $t0 # store age in $t2
	
	# Print greeting "Hello NAME. "
	la $a0, hello
	li $v0, 4
	syscall
	la $a0, name
	syscall
	la $a0, endSentence
	syscall
	
	bge $t2, 17, is_eligible # goto eligible if > 17
	# ineligible
	la $a0, ineligible
	syscall
	j end
	
	is_eligible:
	la $a0, eligible
	syscall
	
	# End prog
end:
	li $v0, 10
	syscall
