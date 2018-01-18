bits 64

section .bss
    scratch:         resb 4096
    dest:            resb 1024*1024
    src:             resb 1024*1024

section .rodata
    sstart_copy:        db "Start copying data",0x0a
    slen_start_copy:    equ $-sstart_copy
    snotregistered:     db "Cannot register signal handler",0x0a
    slen_notregistered: equ $-snotregistered
    ssignal_nr1:        db "Signal Nr (from function parameter): "
    slen_signal_nr1:    equ $-ssignal_nr1
    ssiginfo:           db "Signal Info (address): 0x"
    slen_siginfo:       equ $-ssiginfo
    ssignal_nr2:        db "Signal Nr (from siginfo): "
    slen_signal_nr2:    equ $-ssignal_nr2
    serror_nr:          db "Error Nr (from siginfo): "
    slen_error_nr:      equ $-serror_nr
    scode:              db "Code (from siginfo): "
    slen_code:          equ $-scode
    ssigcontext:        db "Signal Context (address): 0x"
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
                             ; It looks like this are the number of bytes needed
                             ; to mask all signals (up to 64)
    syscall

    test  RAX,0x00           ; Check if the call was successful
    jne   failed_register

init_copy:
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sstart_copy
    mov   RDX,slen_start_copy
    syscall

    cld
    mov   RCX,1
    shl   RCX,21             ; number of repeats: 2^21
    mov   RSI,src
    mov   RDI,dest
copy:
    movsb
    loop  copy

normal_end:
    mov   RAX,60             ; sys exit
    xor   RDI,RDI            ; exit code
    syscall

failed_register:
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,snotregistered
    mov   RDX,slen_notregistered
    syscall

    mov   RAX,60             ; sys exit
    mov   RDI,1              ; exit code
    syscall

sa_restorer:
    mov   RAX,15             ; sys sigreturn
    syscall

sighandler:
    push  RAX
    push  RDX
    push  R15
    push  R14
    push  R13
    mov   R15,RDX            ; sigcontext
    mov   R14,RSI            ; siginfo
    mov   R13,RDI            ; signum

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,ssignal_nr1
    mov   RDX,slen_signal_nr1
    syscall
    mov   RAX,R13            ; signum
    mov   RDI,scratch
    call  printqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
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
    mov   RAX,R14            ; siginfo
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
    mov   RSI,ssignal_nr2
    mov   RDX,slen_signal_nr2
    syscall
    mov   RSI,R14            ; siginfo
    mov   RAX,[RSI]          ; siginfo.si_signo
    mov   RDI,scratch
    call  printqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,serror_nr
    mov   RDX,slen_error_nr
    syscall
    mov   RSI,R14            ; siginfo
    mov   RAX,[RSI+4]        ; siginfo.si_errno
    mov   RDI,scratch
    call  printqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scode
    mov   RDX,slen_code
    syscall
    mov   RSI,R14            ; siginfo
    mov   RAX,[RSI+8]        ; siginfo.si_code
    mov   RDI,scratch
    call  printqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
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
    mov   RAX,R15            ; sigcontext
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

    pop   R13
    pop   R14
    pop   R15
    pop   RDX
    pop   RAX

    mov   RAX,60             ; sys exit
    mov   RDI,1              ; exit code
    syscall
