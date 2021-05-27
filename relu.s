.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue
    addi sp sp -76
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw s6 24(sp)
    sw s7 28(sp)
    sw s8 32(sp)
    sw s10 36(sp)
    sw s11 40(sp)
    sw a0 44(sp)
    sw a1 48(sp)
    sw a2 52(sp)
    sw a3 56(sp)
    sw a4 60(sp)
    sw a5 64(sp)
    sw a6 68(sp)
    sw ra 72(sp)

    li s1 0

loop_start:
    # check 
    
    beq s1 a1 loop_end

    #set temporary memory data address t0
    addi t0 s1 0
    slli t0 t0 2
    add t0 t0 s0

    #..if 0(t0)<=0, set zero 
    #..else loop continue
    lw t1 0(t0)
    ble t1 zero set_zero
    jal loop_continue

set_zero:
    sw zero 0(t0)

loop_continue:
    addi s1 s1 1
    jal loop_start


loop_end:
   # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw s6 24(sp)
    lw s7 28(sp)
    lw s8 32(sp)
    lw s10 36(sp)
    lw s11 40(sp)
    lw a0 44(sp)
    lw a1 48(sp)
    lw a2 52(sp)
    lw a3 56(sp)
    lw a4 60(sp)
    lw a5 64(sp)
    lw a6 68(sp)
    lw ra 72(sp)
    addi sp sp 76
    
	ret
