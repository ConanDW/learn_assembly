; basic calculator

section .data
    prompt db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    op_prompt db "Enter operation (+, -, *, /): ", 0
    result_msg db "Result: ", 0
    newline db 0xa, 0

section .bss
    num1 resb 8
    num2 resb 8
    operation resb 2
    result resb 8

section .text
    global _start

_start:
    ; get first number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 20
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 0x80

    ; get second number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 22
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 0x80

    ; operation prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, op_prompt
    mov edx, 28
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, operation
    mov edx, 2
    int 0x80

    ; convert ascii to integer
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'

    ; math time
    mov cl, [operation]
    cmp cl, '+'
    je do_add
    cmp cl, '-'
    je do_sub
    cmp cl, '*'
    je do_times
    cmp cl, '/'
    je do_div

    jmp end_program

do_add:
    add al, bl
    jmp print_result

do_sub:
    sub al, bl
    jmp print_result

do_times:
    imul bl
    jmp print_result

do_div:
    xor ah, ah
    div bl
    jmp print_result

print_result:
    add al, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 8
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

end_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80
