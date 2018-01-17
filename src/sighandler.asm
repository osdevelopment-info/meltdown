bits 64

section .bss
    scratch:         resb 4096
    dest:            resb 1024*1024
    src:             resb 1024*1024

section .rodata
    snotregistered:     db "Cannot register signal handler",0x0a
    slen_notregistered: equ $-snotregistered
    ssignal_nr1:        db "Signal Nr (from function parameter): "
    slen_signal_nr1:    equ $-ssignal_nr1
    ssiginfo:           db "Signal Info (address): "
    slen_siginfo:       equ $-ssiginfo
    ssigcontext:        db "Signal Context (address): "
    slen_sigcontext:    equ $-ssigcontext
    ssigsegv:           db "Catched SIGSEGV",0x0a
    slen_sigsegv:       equ $-ssigsegv
    scr:                db 0x0a

section .data
    tries:              dq 0           ; number of tries for the copy
    sigaction_act:      dq sighandler  ; sa_handler
                        dq 0x04000004  ; sa_flags (SA_RESTORER | SA_SIGINFO)
                        dq sa_restorer ; sa_restorer
                        dq 0           ; sa_mask
    sigaction_old:      dq 0,0,0,0     ; old sa_handler

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
    mov   RAX,13             ; sys rt_sigaction
    mov   RDI,11             ; SIGSEGV
    mov   RSI,sigaction_act
    mov   RDX,sigaction_old
    mov   R10,8              ; I do not really understand this number.
                             ; it looks like this are the number of bytes needed
                             ; to mask all signals (up to 64)
    syscall

    test  RAX,0x00           ; Check if the call was successful
    jne   failed_register

init_copy:
    cld
    mov   RCX,1
    shl   RCX,21             ; number of repeats: 2^21
    mov   RSI,src
    mov   RDI,dest
copy:
    movsb
    loop  copy

normal_end:
    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall

failed_register:
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,snotregistered
    mov   RDX,slen_notregistered
    syscall

    mov   RDI,1              ; exit code
    mov   RAX,60             ; sys exit
    syscall

sa_restorer:
    mov   RAX,15             ; sys sigreturn
    syscall

sighandler:
    push  RDX                ; sigcontext
    push  RSI                ; siginfo
    push  RDI                ; signum

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,ssignal_nr1
    mov   RDX,slen_signal_nr1
    syscall
    pop   RAX                ; signum
    mov   RDI,scratch
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
    mov   RDX,16
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,ssiginfo
    mov   RDX,slen_siginfo
    syscall
    pop   RAX                ; siginfo
    mov   RDI,scratch
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
    mov   RDX,16
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,ssigcontext
    mov   RDX,slen_sigcontext
    syscall
    pop   RAX                ; sigcontext
    mov   RDI,scratch
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
    mov   RDX,16
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,ssigsegv
    mov   RDX,slen_sigsegv
    syscall

    mov   RDI,1              ; exit code
    mov   RAX,60             ; sys exit
    syscall
