.data
	A: .word 10
	B: .word 15
	C: .word 6
	Z: .word 0

.text

main:	lw a0, A
	lw a1, B
	lw a2, C
	la a3, Z
	
	li t6, 5		#Load immediate into t6 for later
	slt t0, a0, a1		#Check for A < B
	sgt t1, a2, t6		#Check for C > 5
	
	li t6, 7		#Load immediate into t6 for next condition
	and t2, t0, t1		#Ands the results of A < B and C > 5
	bne t2, zero, cond1	#Branch when A < B && C > 5 is true
	addi a2, a2, 1		#Adds 1 to C
	
	sgt t0, a0, a1		#Check for A > B
	bne t0, zero, cond2	#Branches when A > B is true OR
	beq a2, t6, cond2	#Branches when C + 1 == 7 is true
	
	li t6, 3		#Stores 3 into t6 to put into Z
	sw t6, 0(a3)		#Stores the value of t6 into Z
	j cont
	
cond1:	li t6, 1		#Stores 1 into t6 to put into Z
	sw t6, 0(a3)		#Stores the value of t6 into Z
	j cont

cond2:	li t6, 2		#Stores 2 into t6 to put into Z
	sw t6, 0(a3)		#Stores t6 into Z
	
cont:	li t0, 1		#Stores 1 into t0 to check for case
	beq t6, t0, case	#Checks if Z = 1 and branches
	
	li t0, 2		#Stores 2 into t0 to check for case
	beq t6, t0, case	#Checks if Z = 2 and branches
	
	li t0, 3		#Stores 3 into t0 to check for case
	beq t6, t0, case	#Checks if Z = 3 and branches
	
	sw zero, 0(a3)		#Stores 0 into Z if default case
	j break
	

case:	neg t0, t0
	sw t0, 0(a3)

break:	li a7, 10
	ecall
	  
	