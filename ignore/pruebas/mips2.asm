.data
	dir: .word 4194304
.text
.include "mips1.asm"

lw $a1, dir
lw $a0, ($a1)
li $v0, 1
syscall

addi $s0, $s0, 0x24040007
addi $a1, $a1, 52
sw   $s0, ($a1)
syscall

