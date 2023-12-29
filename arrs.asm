.data
	string1: .asciiz "Anchit"
	string2: .asciiz "Bill"
	string3: .asciiz "Cind"
	
	namesArr: .word string1, string2, string3
.text
	la $a0, string1
	li $v0, 4
	syscall
	
	end:
		li $v0, 10
		syscall
	