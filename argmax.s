.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:

    # Prologue
    addi sp sp -24
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw ra 20(sp)


    li s1 0
    li s2 0

    #set maxpoint address setting
    addi t0 s1 0
    slli t0 t0 2
    add t0 s0 t0

loop_start:
    #check till end
    beq s2 a1 loop_end

    #set t1 address setting
    addi t1 s2 0
    slli t1 t1 2
    add t1 s0 t1

    # compare each memory dada
    lw s3 0(t0)
    lw s4 0(t1)
    bgt s4 s3 set_neoMax
    jal loop_continue

set_neoMax:
    mv s1 s2

    addi t0 s1 0
    slli t0 t0 2
    add t0 s0 t0

    mv a0 t0    

loop_continue:
    addi s2 s2 1
    jal loop_start

loop_end:
    

    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw ra 20(sp)
    addi sp sp 24

    ret
