.text

main:    addi x11, x0, 11
         addi x12, x0, 22
         nop
         nop
         nop
         
         addi x11, x12, 5
         nop
         nop
         nop
         add x13, x11, x12
         addi x14, x11, 15
         nop
         nop
         add x15, x13, x12