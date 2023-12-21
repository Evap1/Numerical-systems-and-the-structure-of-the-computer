.text
main:   # Start of your code
		lw 		s0 8(x0)
		addi    s1 s0 12
		sw 		s1 16(x0)
        # End of your code
        add		t6, x0, x0
        beq		t6, x0, finish

deadend: beq	t6, x0, deadend        

finish:
        lw		t4, 0(x0)
        lw		t5, 4(x0)
        sw		t5, 0xFF(t4)
        beq		t6, x0, deadend


