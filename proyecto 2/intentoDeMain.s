la $s0, p2
addi $s0, $s0, 20
lw $s1, ($s0)

addi $s0, $zero, 32

and $t2, $s0, $s1

beq $t2, 32, sustituye

j exit

sustituye:

la $s0, p2
addi $s0, $s0, 20
li $s4, 0x0000080d
sw $s4, ($s0)


exit:




.include "myprogs.s"