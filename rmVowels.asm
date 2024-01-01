<<<<<<< HEAD
.data
	vowels: .asciiz "aeiouAEIOU"
	inpWord: .asciiz "I'm a MSc student"
	outWord: .space 100
.text
	la $s7, outWord
	la $s0, inpWord # loads inpWord pointer
	
	forInpLetter:
		
		li $s6, 0 # bool isVowel = false;
		lb $t0, 0($s0) # load single char to print inside $a0
		
		# if null terminator, break
		beqz $t0, endForInpLetter
		
		# do work
		la $s1, vowels # loads vowels array pointer
		forVowel:
			lb $t1, 0($s1) # Load single vowel
			
			# if null terminator, break
			beqz $t1, endForVowel
			
			# do work
			beq $t0, $t1, setIsVowelTrue # if (inpLetter == vowel) {isVowel = True}
			
			# Go to next vowel
			addi $s1, $s1, 1
			j forVowel
		
		endForVowel:
		# if (isVowel == 0) {append letter}
		beqz $s6, appendLetter
		afterAppend:
		
		# increment inpWord array pointer to next letter
		addi $s0, $s0, 1
		
		j forInpLetter
		
	endForInpLetter:
		# Output letters stored at outWord
		la $a0, outWord
		li $v0, 4
		syscall
	end:
	li $v0, 10
	syscall
	
	
	setIsVowelTrue:
		li $s6, 1
		j endForVowel
	
	appendLetter:
		sb $t0, 0($s7)
		addi $s7, $s7, 1
=======
.data
	vowels: .asciiz "aeiouAEIOU"
	inpWord: .asciiz "I'm a MSc student"
	outWord: .space 100
.text
	la $s7, outWord
	la $s0, inpWord # loads inpWord pointer
	
	forInpLetter:
		
		li $s6, 0 # bool isVowel = false;
		lb $t0, 0($s0) # load single char to print inside $a0
		
		# if null terminator, break
		beqz $t0, endForInpLetter
		
		# do work
		la $s1, vowels # loads vowels array pointer
		forVowel:
			lb $t1, 0($s1) # Load single vowel
			
			# if null terminator, break
			beqz $t1, endForVowel
			
			# do work
			beq $t0, $t1, setIsVowelTrue # if (inpLetter == vowel) {isVowel = True}
			
			# Go to next vowel
			addi $s1, $s1, 1
			j forVowel
		
		endForVowel:
		# if (isVowel == 0) {append letter}
		beqz $s6, appendLetter
		afterAppend:
		
		# increment inpWord array pointer to next letter
		addi $s0, $s0, 1
		
		j forInpLetter
		
	endForInpLetter:
		# Output letters stored at outWord
		la $a0, outWord
		li $v0, 4
		syscall
	end:
	li $v0, 10
	syscall
	
	
	setIsVowelTrue:
		li $s6, 1
		j endForVowel
	
	appendLetter:
		sb $t0, 0($s7)
		addi $s7, $s7, 1
>>>>>>> 9095b893ffa09dcf2d3608cea81aeb317439ec46
		j afterAppend