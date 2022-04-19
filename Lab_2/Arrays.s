.data
	A: .word 0, 0, 0, 0, 0
	B: .word 1, 2, 4, 8, 16
	
.text

main:	la a0, A
	la a1, B
	add a2, zero, zero	#i = 0
	addi t0, zero, 5	#limit for the for loop
	addi t1, zero, 0	#Stores offset
	
for:	add s0, t1, a0		#Stores effective address of element of array A
	add s1, t1, a1		#Stores effective address of element of array B
	
	lw t3, 0(s1)		#Loads element from the current address of array B
	
	addi t3, t3, -1		#Does operation B[i] - 1
	
	sw t3, 0(s0)		#Takes the previous value and sets it in memory
	
	addi a2, a2, 1		#i++
	bge a2, t0, end		#Branch if i >= 5, same as keep looping when i < 5
	addi t1, t1, 4		#Offset
	j for

end:	addi a2, a2, -1		#i--

start:	lw t2, 0(s0)		#Loads element from the current address of array A
	lw t3, 0(s1)		#Loads element from the current address of array B
	
	add t2, t2, t3		#A[i] + B[i] stored into t4
	slli t2, t2, 1		#Multiplies last result by 2 using bit shift left
	
	sw t2, 0(s0)		#Stores the right side into A[i]
	
	
	addi t1, t1, -4		#Reduce offset
	add s0, a0, t1		#New effective address for array A
	add s1, a1, t1		#New effective address for array B
	
	addi a2, a2, -1		#i--
	bgez a2, start		#Loops again if i >= 0
	
	li a7, 10
	ecall
	
	
	
