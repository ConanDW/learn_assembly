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

read_file:
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
find_newline:
    mov al, [rcx]
    cmp al, 10
    je remove_newline
    cmp al, 0
    je after_filename_cleanup
    inc rcx 
    jmp find_newline
find_newline_for_read:
    mov al, [rcx]    ; load byte
    cmp al, 10
    je remove_newline_read
    cmp al, 0
    je after_filename_cleanup_read
    inc rcx          ; move to next byte
    jmp find_newline_for_read 
remove_newline:
    mov byte [rcx], 0
remove_newline_read:
    mov byte [rcx], 0
after_filename_cleanup:
    ; call sys open to create file
    mov rax, 2        ; sys open
    mov rdi, filename ; filename pointer
    mov rsi, 0o600 ; flags: O_CREAT | O_WRONLY
    syscall

    ; close
    mov rdi, rax      ; file descriptor
    mov rax, 3        ; sys close
    syscall

    jmp exit
after_filename_cleanup_read:
    ; call sys open to read file
    mov rax, 2        ; sys open
    mov rdx, filename ; filename pointer
    mov rsi, 0        ; flags: O_RDONLY
    syscall

    mov rbx, rax      ; save file descriptor

    ; read file content
    mov rax, 0        ; sys read
    mov rdi, rbx     ; file descriptor
    mov rsi, filename ; memory buffer to store content
    mov rdx, 512     ; number of bytes to read
    syscall

    ; print to stdout
    mov rax, 1        ; sys write
    mov rdi, 1        ; stdout
    mov rsi, filename ; buffer with file content
    mov rdx, rax      ; number of bytes read
    syscall

    ; close 
    mov rax, 3        ; sys close
    mov rdi, rbx      ; file descriptor
    syscall

    jmp exit
exit:
    mov rax, 60       ; sys exit
    xor rdi, rdi      ; status 0
    syscall

; REMEBER TO NOT USE THE SAME JUMP LABELS TWICE