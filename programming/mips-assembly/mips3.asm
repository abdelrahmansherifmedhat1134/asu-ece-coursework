.data
array:  .word 3, 7, 2, 9, 4,15,-3,-6,34,-2,12,15,6,1,13,15,14,-33,-50,8
.text
main:
la   $s0, array   # Store the array base address in register $s0
add $s1,$zero,$zero

addi $s3,$zero,1

label: slti $t1,$s3,20

         beq $t1,$zero,Exit

         add $t2,$s3,$s3

         add $t2,$t2,$t2

         add $t2,$t2,$s0
         lw $t3,0($t2)
         add $s1,$s1,$t3
         addi $s3,$s3,1
         j label

Exit:  
         slt $t1,$s1,$zero
         beq $t1,$zero,End
         add $s1,$zero,$zero

End:
add $t2,$s3,$s3
add $t2,$t2,$t2
add $t2,$t2,$s0
sw $s1,0($t2)
syscall