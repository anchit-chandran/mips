.data
	test: .word 0x200800000x200800000x20080000

.text
	la $a0, test
	la $v0, translated
	lw $t0, ($a0)
	sw $t0, ($v0) 

translated:
	nop