<<<<<<< HEAD
    # int Z = input('This program implements the formula E = Z * 5/3 + 7\n\nEnter an integer Z: ');

    # int Z_mult_5 = Z * 5;

    # double Z_div = Z_mult_5 / 3;

    # int E = Z_div + 7;

    # if (E < 7) {
    #     output("Right side");
    # } else {
    #     output("Left side");
    # }

.data   
initPrompt:     .asciiz "This program implements the equation E = Z*5/3 + 7\n\nEnter an integer Z: "
outputPrompt:   .asciiz "E = "
leftSideMsg:    .asciiz "\nLeft side."
rightSideMsg:   .asciiz "\nRight side."
.text   

    # Print prompt
    la      $a0,    initPrompt
    li      $v0,    4
    syscall 

    # Get input Z, stored inside $v0
    li      $v0,    5
    syscall 

    # int Z_mult_5 = $v0 * 5; store inside $t1
    li      $t0,    5
    mult    $v0,    $t0
    mflo    $t1

    # double Z_div = $t1 / 3; store inside $t1
    li      $t0,    3
    div     $t1,    $t0
    mflo    $t1

    # int E = Z_div + 7; store inside $t1
    addi    $t1,    $t1,            7

    # output E
    la      $a0,    outputPrompt
    li      $v0,    4
    syscall 
    move    $a0,    $t1
    li      $v0,    1
    syscall 

    # if E < 7, print Right side
    li      $t0,    6
    li      $v0,    4
    bge     $t1,    $t0,            left_side
    la      $a0,    rightSideMsg
    syscall 
    j       end
left_side:      
    la      $a0,    leftSideMsg
    syscall 

end:            
    li      $v0,    10
    syscall 
=======
    # int Z = input('This program implements the formula E = Z * 5/3 + 7\n\nEnter an integer Z: ');

    # int Z_mult_5 = Z * 5;

    # double Z_div = Z_mult_5 / 3;

    # int E = Z_div + 7;

    # if (E < 7) {
    #     output("Right side");
    # } else {
    #     output("Left side");
    # }

.data   
initPrompt:     .asciiz "This program implements the equation E = Z*5/3 + 7\n\nEnter an integer Z: "
outputPrompt:   .asciiz "E = "
leftSideMsg:    .asciiz "\nLeft side."
rightSideMsg:   .asciiz "\nRight side."
.text   

    # Print prompt
    la      $a0,    initPrompt
    li      $v0,    4
    syscall 

    # Get input Z, stored inside $v0
    li      $v0,    5
    syscall 

    # int Z_mult_5 = $v0 * 5; store inside $t1
    li      $t0,    5
    mult    $v0,    $t0
    mflo    $t1

    # double Z_div = $t1 / 3; store inside $t1
    li      $t0,    3
    div     $t1,    $t0
    mflo    $t1

    # int E = Z_div + 7; store inside $t1
    addi    $t1,    $t1,            7

    # output E
    la      $a0,    outputPrompt
    li      $v0,    4
    syscall 
    move    $a0,    $t1
    li      $v0,    1
    syscall 

    # if E < 7, print Right side
    li      $t0,    6
    li      $v0,    4
    bge     $t1,    $t0,            left_side
    la      $a0,    rightSideMsg
    syscall 
    j       end
left_side:      
    la      $a0,    leftSideMsg
    syscall 

end:            
    li      $v0,    10
    syscall 
>>>>>>> 9095b893ffa09dcf2d3608cea81aeb317439ec46
