.data
	z: .word 0	#Declare z as integer in memory.
.text
.globl main

main:	
	la a0, z		#Load z's address into a0.
	
	addi t0, zero, 15	#Declare all the variables with A thru F represented by t0 thru t5
	addi t1, zero, 10
	addi t2, zero, 5
	addi t3, zero, 2
	addi t4, zero, 18
	addi t5, zero, -3
	
	sub t1, t0, t1		#Operation A - B stored in B
	mul t3, t2, t3		#Operation C * D stored in D
	sub t4, t4, t5		#Operation E - F stored in E
	div t5, t0, t2		#Operation A / C stored in F
	
	add t2, t1, t3		#Operation (A - B) + (C * D) stored in C
	sub t1, t4, t5		#Operation (E - F ) - (A / C) stored in B
	
	add t0, t1, t2		#Full operation stored in A.
	
	sw t0, 0(a0)		#Store value into z
	
	li a7, 10
	ecall