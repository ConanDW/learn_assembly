section .data
    menu db "File Explorer", 10
         db "1. Create File", 10
         db "2. Read File", 10
         db "3. Write File", 10
         db "4. Delete File", 10
    menu_len equ $-menu

    create_msg db "Creating a new file...", 10
    create_msg_len equ $-create_msg
    file_name db "Enter filename: ", 0
    file_name_len equ $-file_name

section .bss
    input resb 2
    filename resb 100 

section .text
    global _start

_start:
    ; Display menu
    mov rax, 1         ; sys write 
    mov rdi, 1         ; stdout
    mov rsi, menu      
    mov rdx, menu_len
    syscall

    ; Get user input
    mov rax, 0         ; sys read
    mov rdi, 0         ; stdin
    mov rsi, input
    mov rdx, 2
    syscall

    ; get input
    mov al, [input]
    cmp al, '1'
    je create_file
    cmp al, '2'
    je read_file

    ; if not exit
    jmp exit

create_file:
    mov rax, 1        ; sys write
    mov rdi, 1        ; stdout
    mov rsi, file_name
    mov rdx, file_name_len
    syscall
    
    ; read filename
    mov rax, 0
    mov rdi, 0        ; stdin
    mov rsi, filename
    mov rdx, 100
    syscall

    mov rcx, filename
exit:
    mov rax, 60       ; sys exit
    xor rdi, rdi      ; status 0
    syscall