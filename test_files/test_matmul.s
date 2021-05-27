.import ../matmul.s
.import ../utils.s
.import ../dot.s

# static values for testing
.data
m0: .word 1 2 3 4 5 6 7 8 9 10
m1: .word 2 4 6 7 4 5 5 3 4 5 1 2 3 4 5 6 7 8 9 10 11 5 4 3 2 44
d: .word 0 0 0 0 0 0 0 0 0 # allocate static space for output

.text
main:
    # Load addresses of input matrices (which are in static memory), and set their dimensions

    la s0 m0
    li s1 2 #Mat0 row
    li s2 5 #Mat0 col
    la s3 m1
    li s4 5 #Mat1 row
    li s5 5 #Mat1 col
    la s6 d
    
    
    

    #print m0 before multiply
    mv a0 s0
    mv a1 s1
    mv a2 s2
    jal print_int_array

    # Print newline
    li a1 '\n'
    jal print_char
    
    #print m1 before multiply
    mv a0 s3
    mv a1 s4
    mv a2 s5
    jal print_int_array

    # Print newline
    li a1 '\n'
    jal print_char


    # Call matrix multiply, m0 * m1
    mv a0 s0
    mv a1 s1
    mv a2 s2
    mv a3 s3
    mv a4 s4
    mv a5 s5
    mv a6 s6
	jal ra matmul

    
    # Print the output (use print_int_array in utils.s)
	mv a0 a6
	mv a1 a1
	mv a2 a5
	jal ra print_int_array


    # Exit the program
    jal exit
