.text

main:	li a0, 0x01234567
	li a1, 0x11223344
	
	add s0, a0, a1		#Add
	
	#addi s1, a0, 0x11223344	#addi
	
	sub s2, a0, a1		#sub
	
	li a0, 0x11223344
	sub s3, a0, a1		#sub with zero output
	
	li a1, 0xFFFFFFFF
	and s4, a0, a1		#and
	
	andi s5, a0, 0xFFFFFFFF	#andi
	
	li a0, 0x50505050
	li a1, 0x05050505
	or s6, a0, a1		#or
	
	#ori s7, a0, 0x05050505	#ori	Out of range
	
	li a0, 0xFFAABBCC
	li a1, 0x00000002
	
	sll s8, a0, a1		#sll by 2 bits
	
	slli s9, a0, 2		#slli by 2 bits
	
	srl s10, a0, a1		#srl by 2 bits
	srli s11, a0, 2		#srli by 2 bits
	
	mv t0, a1		#"pass-through" into t0
	
	