# Lab 6 - Test Application

	.data	# Data declaration section

Result:	.word	0

	.text

main:		# Start of code section

	add zero, zero, zero
	addi x1, zero, 1
	slli x2, x1, 1
	slli x3, x2, 1
	slli x4, x3, 1
	slli x5, x4, 1
	slli x6, x5, 1
	slli x7, x6, 1
	slli x8, x7, 1
	slli x10, x8, 1
	slli x11, x10, 1
	slli x12, x11, 1
	slli x13, x12, 1
	slli x14, x13, 1
	slli x15, x14, 1
	slli x18, x15, 1
	slli x19, x18, 1
	slli x20, x19, 1
	slli x21, x20, 1
	slli x22, x21, 1
	srli x23, x22, 1
	srli x24, x23, 1
	srli x25, x24, 1
	srli x26, x25, 1
	srli x27, x26, 1
	srli x28, x27, 1
	
	
stop:	
	beq  zero, zero, stop

# END OF PROGRAM
