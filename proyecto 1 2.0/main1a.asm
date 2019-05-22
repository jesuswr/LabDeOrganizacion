li 	$a0, 5
jal 	malloc

addi	$a0, $v0, 0
li	$v0, 1
syscall

li  	$v0, 10
syscall

.include "create.asm"
.include "init.asm"
.include "malloc.asm"
.include "insert.asm"
.include "free.asm"
.include "delete.asm"
.include "print.asm"
.include "perror.asm"
