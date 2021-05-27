
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
    bne s3 s6 mismatched_dimensions

    # Prologue
    addi sp sp -44
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw s6 24(sp)
    sw s7 28(sp)
    sw s8 32(sp)
    sw s11 36(sp)
    sw ra 40(sp)

    li t4 0 #check s4 index
    li t5 0 #check s5 index
    li t6 0 #result index

    # Print newline
    li a1 '\n'
    jal print_char
   

outer_loop_start:
    beq t5 s5 outer_loop_end
    

inner_loop_start:
    #check
    beq t4 s4 inner_loop_end
    
    #address set -> vect s0 col
    slli t4 t4 2
    add s0 s0 t4
    srli t4 t4 2 

   
    #dot
    addi s2 s3 0 # the number of dot components (s3 = s6)
    addi s3 s4 0 # stride1 (stride..곱하는 방향과 무관)
    li s4 1   # stride2

    jal dot
    
    lw s0 0(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)



    #store output value
    slli t6 t6 2
    add s11 s11 t6
    sw a0 0(s11)
    srli t6 t6 2
    lw s11 36(sp)
 
   

    #add loop index
    addi t6 t6 1
    addi t4 t4 1
    j inner_loop_start

inner_loop_end:    
    #reset Mat0 value
    li t4 0

    #move s1 vector
    lw s1 4(sp)
    addi t5 t5 1
    mul s10 t5 s6 # s6만큼 이동한거니까.
    slli s10 s10 2
    add s1 s1 s10
    srli s10 s10 2
    


    j outer_loop_start

outer_loop_end:


    slli t6 t6 2
    sub s11 s11 t6
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
    lw s11 36(sp)
    lw ra 40(sp)
    addi sp sp 44

    ret


mismatched_dimensions:
    li a1 'F'
    jal print_char
    
    li a1 2
    jal exit2
