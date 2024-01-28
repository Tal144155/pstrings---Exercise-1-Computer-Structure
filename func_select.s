.extern printf 
.extern scanf
.extern pstrlen
.extern swapCase

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

    jmp .invalid_input

.task_one:
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
    movq %r13, %rdi
    movq %rax, %r13 ##saving new string in r13
    xorq %rax, %rax
    call pstrlen

    ##printing result
    movq $second_choice, %rdi
    movq %rax, %rsi ##string length to 2 argument
    movq %r13, %rdx #new string
    xorq %rax, %rax
    call printf

    ##second string
    mov %r14, %rdi ##moving pstring to argument 1
    xorq %rax, %rax
    call swapCase

    ##getting size of string
    movq %r14, %rdi
    movq %rax, %r14 ##saving new string in r14
    xorq %rax, %rax
    call pstrlen

    ##printing result
    movq $second_choice, %rdi
    movq %rax, %rsi ##string length to 2 argument
    movq %r14, %rdx #new string
    xorq %rax, %rax
    call printf
    jmp .exit

.task_three:
    ##scaning two numbers
    xorq %rax, %rax
    movq $scanf_fmt, %rdi
    call scanf
    jmp .exit

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
    