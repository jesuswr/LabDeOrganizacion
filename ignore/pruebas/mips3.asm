.text

addi $s0, $s0, 4194304
addi $s0, $s0, 100
lw  $a0, ($s0)
li $v0, 1
syscall
