.data

	z: .word 2
	i: .word 0

.text

main:	la a0, z	#Load z address into a0
	lw a1, i	#load i value into a1
	lw t0, 0(a0)	#load z value into t0
	
	li t1, 20	#Limit for for loop
	
for:	addi t0, t0, 1	#z++
	addi a1, a1, 2	#i = i + 2
	bgt a1, t1, end	#Breaks out of loop when i becomes greater than 20. Same as looping where i <= 20
	j for

end:	li t1, 100	#Limit for the while loop

while:	addi t0, t0, 1		#z++
	blt t0, t1, while	#Keeps looping as long as z is less than 100. Doesn't branch to beginning if the condition fails but it still does the addition.
	
	bgtz a1, start	#Branches into the loop if the condition is satisfied.
	j skip		#Otherwise, we skip it all
	
start:	addi t0, t0, -1	#z--
	addi a1, a1, -1 #i--
	bgtz a1, start	#if i > 0, then loop again.
		
skip:	sw t0, 0(a0)	#stores z back into memory
	sw a1, 4(a0)	#stores i back into memory to show that everything executed correctly
	li a7, 10
	ecall