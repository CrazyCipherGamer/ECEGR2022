#The idea for the Fibonacci return value being a0 is similar to how it was in the book for a factorial function
#and the idea of using the stack to hold the value of the sums is by watching Ben Eater's videos on stack and assembly.

.text

main:	li a0, 3
	jal Fibonacci
	
	add s0, zero, a0	#a = Fibonacci(3)
	
	li a0, 10
	jal Fibonacci
	
	add s1, zero, a0	#b = Fibonacci(10)
	
	li a0, 20
	jal Fibonacci
	
	add s2, zero, a0	#c = Fibonacci(20)
	
	
	li a7, 10
	ecall
	
	
Fibonacci:	#input parameter n is stored in a0
		blez a0, end	#Branch when a0 <= 0
		li t0, 1
		beq a0, t0, end	#Branch when a0 == 1	#a0 would just have the value we need to return so we just exit without any ops
		
		addi sp, sp, -8
		sw ra, 0(sp)
		sw a0, 4(sp)	#We store the ra and input n before function call. Lot of trial and error made me
				#realize stack ops should be as close as possible to function call.
		
		addi a0, a0, -1		#Change n value for calling fib(n - 1)
		jal Fibonacci		#Call fib(n - 1)
		
		lw t1, 4(sp)		#Load the original n value
		sw a0, 4(sp)		#store the return value/sum into the stack. We need it later to calculate the sum at that fib(n)
		
		addi a0, t1, -2		#Change n value for calling fib(n - 2)
		jal Fibonacci		#Call fib(n -2)
		
		lw t1, 4(sp)		#load the fib(n -1) we stored far up the stack that contains the result of the left side branches and sub right branches to add to the current right branch
		add a0, a0, t1		#Add the results we got, a0 is our return value/register

		lw ra, 0(sp)	#load return address,
				#we don't load a0 because we are gonna use it as our return and we also don't want to accidently load the n values for lower branches of the functions
		addi sp, sp, 8	#return sp to proper position
		
end:		ret		
