	.data
KelBias:	.float 273.15
ask:	.asciz "Enter temperature (in Fahrenheit): "
resultCel: .asciz "The temperature (in Celsius): "
resultKel: .asciz "The temperature (in Kelvin): "
newln: .asciz "\r\n"

.text

main:	li a7, 4	#System call for printing string
	la a0, ask
	ecall
	
	li a7, 6	#System call for reading float
	ecall
	
	fmv.x.w a0, fa0	#Set the input register before function call
	jal ConvFahToCel
	
	fmv.s.x fs0, a1	#Store the result from previous function in a floating point saved register.
	
	mv a0, a1	#return value is now used for the input value
	jal ConvCelToKel
	
	fmv.s.x fs1, a1	#Store result from previous function into another floating point saved register.
	
	li a7, 10	#System call for exit
	ecall	


ConvFahToCel:	addi t0, zero, 32
		fcvt.s.w ft0, t0	#loads 32.0 into ft0
		addi t0, zero, 9
		fcvt.s.w ft1, t0	#Loads 9.0 into ft1
		addi t0, zero, 5	
		fcvt.s.w ft2, t0	#Loads 5.0 into ft2
		
		fmv.s.x fa0, a0		#moves input into fa0 for calculations
		
		fsub.s fa0, fa0, ft0	#This does Fahrenheit - 32.0
		fmul.s fa0, fa0, ft2	#This multiplies the previous quantity by 5.0
		fdiv.s fa0, fa0, ft1	#This divides the previous quantity by 9.0 and fa1 now has the Celsius value to be printed out
		
		li a7, 4
		la a0, resultCel
		ecall
		
		li a7, 2	#System call to print float in ascii
		ecall
		
		li a7, 4
		la a0, newln
		ecall
		
		fmv.x.s a1, fa0	#Set return register
		ret

ConvCelToKel:	flw ft0, KelBias, t0	#Kelvin bias of 273.15 is needed to be fetched from memory.
		fmv.s.x fa0, a0		#Use the input value as the float value
		fadd.s fa0, fa0, ft0	#Converts celsius to kelvin
		
		li a7, 4	#System call for printing string
		la a0, resultKel
		ecall
		
		li a7, 2	#System call to print float in ascii
		ecall
		
		li a7, 4
		la a0, newln
		ecall
		
		fmv.x.s a1, fa0
		ret
