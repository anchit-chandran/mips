.data
	inputString: .asciiz "lumberjack"
	seenLetters: .space 100 # to add seen letters
	resultMsgTrue: .asciiz " is an isogram"
	resultMsgFalse: .asciiz " isn't an isogram"
	
.text
	la $a0, inputString
	jal isIsogram
	
	end:
	li $v0, 10
	syscall
	
	isIsogram:
	jr $ra
