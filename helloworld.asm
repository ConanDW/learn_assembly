; Created 07/25/2025

section .text                ; section for code
    bits 32                   ; 32-bit mode
    global _start

_start:
    mov edx, len            ; Move length of message to EDX
    mov ecx, msg            ; Move pointer to message to ECX
    mov ebx, 1              ; File descriptor (stdout)
    mov eax, 4              ; Syscall number for sys_write
    int 0x80                ; Call kernel

    mov eax, 1              ; Syscall number for sys_exit
    int 0x80                ; Exit program

section .data
    msg db " _          _ _        _ _         ", 0xa
    db "| |        | | |      | | |        ", 0xa
    db "| |__   ___| | | ___  | | | ___    ", 0xa
    db "| '_ \\ / _ \\ | |/ _ \\ | | |/ _ \\   ", 0xa
    db "| | | |  __/ | | (_) || | | (_) |  ", 0xa
    db "|_| |_|\\___|_|_|\\___(_)_|_|\\___/   ", 0xa
    db "change da world.", 0xa
    db 0xa
    db "my final message", 0xa
    db "Goodb ye", 0xa
    db "   (\_/)", 0xa
    db "   (o.o)   __", 0xa
    db "   / >---/  )v", 0xa
    db "  /      / /", 0xa
    db " /      (_/", 0xa
    db "      __     ", 0xa
    db "     /  \\__  ", 0xa
    db "    (    @\\___", 0xa
    db "    /         O", 0xa
    db "   /   (_____/", 0xa
    db "  /_____/   U", 0xa
    db "     ||      ", 0xa
    db "    /  \\    ", 0xa
    db "   /    \\   ", 0xa
    db "  (      )  ", 0xa
    db "   |    |   ", 0xa
    db "   |    |   ", 0xa
    db "   |____|   ", 0xa
    db "   /    \\   ", 0xa
    db "  /      \\  ", 0xa
    db " (        ) ", 0xa
    db "  |      |  ", 0xa
    db "  |      |  ", 0xa
    db "  |______|  ", 0xa
    len equ $ - msg              ; Length of message

