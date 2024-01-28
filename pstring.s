.section .text
.globl pstrlen
.type	pstrlen, @function
pstrlen:
    movb (%rdi), %al
    ret

.globl swapCase
.type swapCase, @function
swapCase:
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
    jbe .capital

    ##if the value is higher or equal to 'a', its small
    cmpb $0x61, %al
    jae .small

.capital:
    ##changing upper to small
    addb $0x20, %al
    movb %al, (%rdi)
    jmp .next

.small:
    ##changing small to upper
    subb $0x20, %al
    movb %al, (%rdi)
    jmp .next

.next:
    # Increment pointer, and continue
    incq %rdi
    jmp .loop

.exit:
    movq %rsi, %rax
    ret


