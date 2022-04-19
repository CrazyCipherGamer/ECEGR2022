.data
	a: .word 0
	b: .word 0
	c: .word 0

.text

main:	la s0, a		#Load address for a. We just need to offset the address to get values of b and c
	
	addi t0, zero, 5	#i = 5
	addi t1, zero, 10	#j = 10
	
	addi sp, sp, -8		#Reserve space for both t0 and t1 on stack
	sw t0, 0(sp)		#Store t0 into stack
	sw t1, 4(sp)		#Store t1 into stack
	
	jal AddItUp		#Call to AddItUp(i)
	
	#t1 currently has the value of the output. Need to store into a
	sw t1, 0(s0)
	
	lw t0, 0(sp)	#load the original data back in
	lw t1, 4(sp)
	
	sw t1, 0(sp)	#Switch the value around to setup for next function call
	sw t0, 4(sp)
	
	jal AddItUp	#Calls AddItUp(j)
	
	#t1 now has the output which must be stored into b
	sw t1, 4(s0)
	
	lw t1, 0(sp)	#load data again
	lw t0, 4(sp)
	addi sp, sp, 8	#Clear stack
	
	lw t2, 0(s0)	#store a value into temp register that is not t0 or t1
	lw t3, 4(s0)	#store b value into temp register that is not t0 or t1
	
	add t2, t2, t3	#a + b
	
	sw t2, 8(s0)	#Stores final result into c
	
	li a7, 10	#Store value into a7 to let the system know to end
	ecall
		
	
	
AddItUp: addi t0, zero, 0	#Sets i = 0
	addi t1, zero, 0	#Sets x = 0
	lw t2, 0(sp)		#Gets the value for n
	
	slt t3, t0, t2		#Check if i < n
	bne t3, zero, for	#Brach into for loop
	j end			#Don't execute otherwise
	
for: 	add t4, t1, t0		#Does x + i
	addi t4, t4, 1		#Completes x + i + 1
	add t1, zero, t4		#Stores the previous value back into x
	addi t0, t0, 1		#i++
	
	slt t3, t0, t2		#Check if i < n
	bne t3, zero, for	#Loop again

end:	ret			#return x
	