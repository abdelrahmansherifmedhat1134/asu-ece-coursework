



main: addi $a0, $zero, 3   #pass parameter to procedure sum
             jal sum                        #call procedure sum
             addi $s0, $v0, 0       #store return value in $s0
stop: j stop

sum:
    addi $sp,$sp,-8
    sw $a0,0($sp)
    sw $ra,4($sp)
    addi $a0,$a0,-1
    jal sum
    lw $a0,0($sp)
    lw $ra,4($sp)
    addi $sp,$sp,8
    add $v0,$v0,$a0  
return: jr $ra    
final: addi $v0,$zero,1
       j return	