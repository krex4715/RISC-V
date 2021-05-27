.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:

    # Prologue
    addi sp sp -60
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw s6 24(sp)
    sw t0 28(sp)
    sw t1 32(sp)
    sw t2 36(sp)
    sw t3 40(sp)
    sw t4 44(sp)
    sw t5 48(sp)
    sw t6 52(sp)
    sw ra 56(sp)

    

    #set loop index 
    li t0 0    # t0 is loop index
    li s0 0

    
    li t5 0     # t5 is sum index

    li s5 0     # s5 and s6 is stride value
    li s6 0



loop_start:
    #check
    beq t0 a2 loop_end

   
    
    #get address
    mv t1 a0
    mv t2 a1

    slli s5 s5 2
    slli s6 s6 2
    add t1 t1 s5
    add t2 t2 s6
    srli s5 s5 2
    srli s6 s6 2

    #get vector values
    lw t3 0(t1)
    lw t4 0(t2)

    

    mul t5 t3 t4
    add s0 s0 t5 # Result of Dot product


    #go loop
    addi t0 t0 1
    add s5 s5 a3
    add s6 s6 a4
    j loop_start


loop_end:

    mv a0 s0
    
    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw s6 24(sp)
    lw ra 28(sp)
    lw t1 32(sp)
    lw t2 36(sp)
    lw t3 40(sp)
    lw t4 44(sp)
    lw t5 48(sp)
    lw t6 52(sp)
    lw ra 56(sp)
    addi sp sp 60

    ret