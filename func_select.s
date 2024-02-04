##326529138 Tal Ariel Ziv

.extern printf 
.extern scanf
.extern pstrlen
.extern swapCase
.extern pstrijcpy

.section .rodata
first_choice1:
    .string "first pstring length: %d"
first_choice2:
    .string ", second pstring length: %d\n"
second_choice:
    .string "length: %d, string: %s\n"
third_choice:
    .string "length: %d, string: %s\n"
invalid:
    .string "invalid option!\n"
invalid_task_three:
    .string "invalid input!\n"
scanf_fmt:
    .string "%d%d"

.section .text
.globl run_func
.type	run_func, @function
run_func:
    # Enter
    pushq %rbp
    movq %rsp, %rbp

    ##if user choice 31
    cmpq $31, %rdi
    je .task_one

    ##if user choice 33
    cmpq $33, %rdi
    je .task_two

    ##if user choice 34
    cmpq $34, %rdi
    je .task_three

    ##if user inserted something else
    jmp .invalid_input

.task_one:

    ##printing size of each pstring
    movq %rsi, %rdi ##moving first pstring to argument1
    movq %rdx, %r13 #saving second pstring
    xorq %rax, %rax
    call pstrlen

    ##printing result of first string
    mov $first_choice1, %rdi
    mov %rax, %rsi
    call printf

    movq %r13, %rdi
    xorq %rax, %rax
    call pstrlen

    ##printing result of second string
    mov $first_choice2, %rdi
    mov %rax, %rsi
    call printf
    jmp .exit

.task_two:
    movq %rsi, %r13 ##saving pstring in r13
    movq %rdx, %r14 ##saving string2 in r14

    mov %rsi, %rdi ##moving pstring to argument 1
    xorq %rax, %rax
    call swapCase

   
    ##getting size of string
    movq %rax, %rdi
    movq %rax, %r13 ##saving new Pstring in r13
    xorq %rax, %rax
    call pstrlen

    ##printing result
    movq $second_choice, %rdi
    movq %rax, %rsi ##string length to 2 argument
    incq %r13 ##getting only the string
    movq %r13, %rdx #new string
    xorq %rax, %rax
    call printf

    ##second string
    mov %r14, %rdi ##moving pstring to argument 1
    xorq %rax, %rax
    call swapCase

    ##getting size of string
    movq %rax, %rdi
    movq %rax, %r14 ##saving new string in r14
    xorq %rax, %rax
    call pstrlen

    ##printing result
    movq $second_choice, %rdi
    movq %rax, %rsi ##string length to 2 argument
    incq %r14 ##getting only string
    movq %r14, %rdx #new string
    xorq %rax, %rax
    call printf
    jmp .exit

.task_three:
    ##saving strings
    movq %rsi, %r12
    movq %rdx, %r13

    ##scaning two numbers
    xorq %rax, %rax
    movq $scanf_fmt, %rdi
    subq $32, %rsp

    ##creating place in stack
    leaq -8(%rbp), %rsi
    leaq -16(%rbp), %rdx

    ##calling scanf with placing in stack
    call scanf

    ##moving input to registers
    movl -8(%rbp), %r14d
    movl -16(%rbp), %r15d

    ##checking if input is valid

    ##if i>jS
    cmpq %r14, %r15
    jl .invalid_task_three

    ##if j>str1.len
    movq %r12, %rdi
    xorq %rax, %rax
    call pstrlen
    subq $1, %rax
    cmpq %r15, %rax
    jl .invalid_task_three

    ##if j>str2.len
    movq %r13, %rdi
    xorq %rax, %rax
    call pstrlen
    subq $1, %rax
    cmpq %r15, %rax
    jl .invalid_task_three

    ##if i<0
    cmpq $0, %r14
    jl .invalid_task_three


    ##mooving arguments to function
    movq %r12, %rdi
    movq %r13, %rsi
    movq %r14, %rdx
    movq %r15, %rcx
    xorq %rax, %rax
    call pstrijcpy

    movq %rax, %r12
    jmp .print_task_three


.invalid_task_three:
    ##printing invalid option
    movq $invalid_task_three, %rdi
    xorq %rax, %rax
    call printf
    jmp .print_task_three


.print_task_three:
    ##printing the original size and string

    ##getting size of string
    movq %r12, %rdi
    xorq %rax, %rax
    call pstrlen

    ##printing string
    movq $third_choice, %rdi
    movq %rax, %rsi ##string length to 2 argument
    incq %r12
    movq %r12, %rdx #string
    xorq %rax, %rax
    call printf

    ##getting size of string
    movq %r13, %rdi
    xorq %rax, %rax
    call pstrlen

    ##printing string
    movq $third_choice, %rdi
    movq %rax, %rsi ##string length to 2 argument
    incq %r13
    movq %r13, %rdx #string
    xorq %rax, %rax
    call printf
    jmp .exit

##printing if the input is not in range
.invalid_input:
    movq $invalid, %rdi
    xorq %rax, %rax
    call printf
    jmp .exit


.exit:
    # Exit
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    