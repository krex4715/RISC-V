
.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:
    # Error if mismatched dimensions

    bne a2 a4 mismatched_dimensions

    # Prologue
    addi sp sp -80
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw s6 24(sp)
    sw s7 28(sp)
    sw s8 32(sp)
    sw s9 36(sp)
    sw s10 40(sp)
    sw s11 44(sp)
    sw a0 48(sp)
    sw a1 52(sp)
    sw a2 56(sp)
    sw a3 60(sp)
    sw a4 64(sp)
    sw a5 68(sp)
    sw a6 72(sp)
    sw ra 76(sp)

    li t4 0 #check a1 index
    li t5 0 #check a5 index
    li t6 0 #result index

    li s10 0
    
    
    mv s0 a0
    mv s1 a1
    mv s2 a2

    mv s3 a3
    mv s4 a4
    mv s5 a5

    mv s6 a6

    

outer_loop_start:
    beq t5 a1 outer_loop_end
    

inner_loop_start:
    #check
    beq t4 a5 inner_loop_end

    
    #set m0 address     <a0>
    mv a0 s0

    #set m1 address     <a1>
    mv a3 s3
    slli t4 t4 2
    add a3 a3 t4
    srli t4 t4 2

    mv a1 a3 
    
    #dot size           <a2>
    mv a2 s4 # s2 = s4
    
    #stride0, stride1   <a3, a4>    
    li a3 1 # stride_0
    mv a4 s5 # stride_1

    jal dot

    #store output value
    slli t6 t6 2
    add a6 a6 t6
    sw a0 0(a6)
    srli t6 t6 2
    mv a6 s6
    
    #resest
    mv a1 s1
    mv a2 s2
    mv a4 s4
    mv a5 s5
  
   
   

    #add loop index
    addi t6 t6 1
    addi t4 t4 1
    j inner_loop_start

inner_loop_end:    

    li t4 0

    addi t5 t5 1
    mul s10 t5 s2 # a2(=a4)만큼 이동한거니까.
    slli s10 s10 2

    lw s0 0(sp)
    add s0 s0 s10
    srli s10 s10 2

    j outer_loop_start

outer_loop_end:


    mv a6 s6
    li t6 0


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
    lw s9 36(sp)
    lw s10 40(sp)
    lw s11 44(sp)
    lw a0 48(sp)
    lw a1 52(sp)
    lw a2 56(sp)
    lw a3 60(sp)
    lw a4 64(sp)
    lw a5 68(sp)
    lw a6 72(sp)
    lw ra 76(sp)
    addi sp sp 80

    ret


mismatched_dimensions:

    

    li a1 2
    jal exit2
