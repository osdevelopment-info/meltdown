bits 64

; struct sigaction {
;        __sighandler_t sa_handler;
;        unsigned long sa_flags;
;        __sigrestore_t sa_restorer;
;        sigset_t sa_mask;               /* mask last for extensibility */
;};


section .bss
    scratch:      resb 4096
    dest:         resb 1024*1024
    src:          resb 1024*1024

section .data
    ssigsegv:     db "Catched SIGSEGV"
    slen_sigsegv: equ $-ssigsegv
    sh:           dq sighandler  ; sa_handler
                  dd 0x00000004  ; sa_flags (SA_SIGINFO)
                  dq 0           ; sa_restorer
                  dq 0           ; sa_mask

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
    cld
    mov   RCX,1
    shl   RCX,21
    mov   RSI,src
    mov   RDI,dest
copy:
    movsb
    loop  copy

    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall

sighandler:
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,ssigsegv
    mov   RDX,slen_sigsegv
    syscall

    mov   RDI,1              ; exit code
    mov   RAX,60             ; sys exit
    syscall
