.import ../argmax.s
.import ../utils.s

.data
v0: .word 6 -42 333 777 -5 6 5 -114 2 5 2 3 # MAKE CHANGES HERE

.text
main:
    # Load address of v0
    la s0 v0
    
    #print present address
    mv a1 s0
    jal ra print_int
    li a1 '\n'
    jal ra print_char
    
    # Set length of v0
    li s1 12 # MAKE CHANGES HERE
    

    # Call argmax
    mv a0 s0
    mv a1 s1
    jal argmax

    # Print the output of argmax
    mv a1 a0
    jal ra print_int

    # Print newline
    li a1 '\n'
    jal ra print_char

    # Exit program
    jal exit
