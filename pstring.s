.section .text
.globl pstrlen
.type	pstrlen, @function
pstrlen:
    pushq %rbp
    movq %rsp, %rbp
    movb (%rdi), %al
    movq %rbp, %rsp
    popq %rbp
    ret

.globl swapCase
.type swapCase, @function
swapCase:
    pushq %rbp
    movq %rsp, %rbp
    ##incrementing pointer to remove length from struct
    incq %rdi

     ##saving pointer to start of word
    movq %rdi, %rsi
.loop:
    # take first byte from string in %rdi
    movb (%rdi), %al

    # if the pointer is null (0) exit loop
    cmpb $0x0, %al
    je .exit

    ##if value is lower or equal than 'Z', its defenitly capital
    cmpb $0x5A, %al
    jle .capital

    ##if the value is higher or equal to 'a', its small
    cmpb $0x61, %al
    jge .small

.capital:
    ##changing upper to small
    cmpb $0x20, %al
    je .next
    addb $0x20, %al
    movb %al, (%rdi)
    jmp .next

.small:
    ##changing small to upper
    cmpb $0x20, %al
    je .next
    subb $0x20, %al
    movb %al, (%rdi)
    jmp .next

.next:
    # Increment pointer, and continue
    incq %rdi
    jmp .loop

.exit:
    movq %rbp, %rsp
    popq %rbp
    movq %rsi, %rax
    ret


.globl pstrijcpy
.type pstrijcpy, @function

pstrijcpy:
    pushq %rbp
    movq %rsp, %rbp

    ##saving pointer to start of word
    movq %rdi, %r8

    ##incrementing pointer to remove length from struct
    incq %rdi
    incq %rsi


    ##incrementing by i
    addq %rdx, %rdi
    addq %rdx, %rsi

    subq $1, %rdx

    ## %rdx will be our counter
.loop_three:

    ##check condition
    cmpq %rdx, %rcx
    je .exit_three

    # take first byte from string in %rsi to %rdi
    movb (%rsi), %al

    ##moving from %al to (%rdi)
    movb %al, (%rdi)
    jmp .next_three


.next_three:
    # Increment pointer, and continue
    incq %rdi
    incq %rsi
    incq %rdx
    jmp .loop_three

.exit_three:
    movq %rbp, %rsp
    popq %rbp
    movq %r8, %rax
    ret


