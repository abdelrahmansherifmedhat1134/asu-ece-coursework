        addi $s0, $zero, 0   
label1:    slti $t0, $s0, 10
              beq  $t0, $zero, STOP
              addi $s1, $zero, 0            
label2:    slti  $t1, $s1, 10
              beq   $t1, $zero, label3
                 # preview  $s0 and $s1 on two 7-segments for 1 second #
              addi $s1, $s1, 1    #put breakpoint here
              j    label2
label3:   addi $s0, $s0, 1
              j    label1  
STOP:     j STOP             # infinite loop

syscall