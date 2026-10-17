.data
label1: .word 0xffffffff
arr:.byte 0x12

.text




main: #start of code
	#addi $t0,$zero,5
	#addi $t1,$zero,4
	
	#add $s0,$t0,$t1
	
	la $s0, label1
	#lw $s1,label1
	#li $s2,0x1212
	#li $s3,0xcccccccc
	#lui $s4,0x
	
	addi $t1,$zero,0x1234
	sw $t1,8($s0)
	lui $t3,0x1234
	ori $t3,$t3,0x1234
	
	
	
	syscall #ends exeqution

