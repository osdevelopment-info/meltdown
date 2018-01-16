bits 64

section .bss
    scratch: resb 4096

section .data
    ssigsegv: db "Catched SIGSEGV"

section .text
    extern printqw
    extern printdw
    extern printw
    extern printb
    extern printhqw
    extern printhdw
    extern printhw
    extern printhb
    global _start

_start:

    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall
