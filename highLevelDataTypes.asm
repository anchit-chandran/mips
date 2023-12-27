.data
	name: .asciiz "Anchit"
	.text
	.globl main
	
main: 
	la $t0, name
	li $v0, 10
	syscall