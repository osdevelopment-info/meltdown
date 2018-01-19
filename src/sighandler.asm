bits 64

;struct ucontext {
;        unsigned long     uc_flags;
;        struct ucontext  *uc_link;
;        stack_t           uc_stack;
;        struct sigcontext uc_mcontext;
;        sigset_t          uc_sigmask;   /* mask last for extensibility */
;};

;typedef struct sigaltstack {
;        void *ss_sp;
;        int ss_flags;
;        size_t ss_size;
;} stack_t;

;struct sigcontext {
;        __u64 r8;
;        __u64 r9;
;        __u64 r10;
;        __u64 r11;
;        __u64 r12;
;        __u64 r13;
;        __u64 r14;
;        __u64 r15;
;        __u64 rdi;
;        __u64 rsi;
;        __u64 rbp;
;        __u64 rbx;
;        __u64 rdx;
;        __u64 rax;
;        __u64 rcx;
;        __u64 rsp;
;        __u64 rip;
;        __u64 eflags;           /* RFLAGS */
;        __u16 cs;
;        __u16 gs;
;        __u16 fs;
;        __u16 __pad0;
;        __u64 err;
;        __u64 trapno;
;        __u64 oldmask;
;        __u64 cr2;
;        struct _fpstate *fpstate;       /* zero when no FPU context */
;#ifdef __ILP32__
;        __u32 __fpstate_pad;
;#endif
;        __u64 reserved1[8];
;};

section .bss
    scratch:         resb 4096
    dest:            resb 1024*1024
    src:             resb 1024*1024

section .rodata
    sstart_copy:         db "Start copying data",0x0a
    slen_start_copy:     equ $-sstart_copy
    snotregistered:      db "Cannot register signal handler",0x0a
    slen_notregistered:  equ $-snotregistered
    ssignal_nr1:         db "Signal Nr (from function parameter): "
    slen_signal_nr1:     equ $-ssignal_nr1
    ssiginfo:            db "Signal Info (address): 0x"
    slen_siginfo:        equ $-ssiginfo
    ssignal_nr2:         db "Signal Nr (from siginfo): "
    slen_signal_nr2:     equ $-ssignal_nr2
    serror_nr:           db "Error Nr (from siginfo): "
    slen_error_nr:       equ $-serror_nr
    scode:               db "Code (from siginfo): "
    slen_code:           equ $-scode
    ssigaddr:            db "Address (Memory ref): 0x"
    slen_sigaddr:        equ $-ssigaddr
    ssrcaddr:            db "Address (src + 1Mi): 0x"
    slen_srcaddr:        equ $-ssrcaddr
    sinsaddr:            db "Address (copy instruction): 0x"
    slen_insaddr:        equ $-sinsaddr
    sucontext:           db "uContext (address): 0x"
    slen_ucontext:       equ $-sucontext
    suc_flags:           db "uc_flags (from ucontext): 0x"
    slen_uc_flags:       equ $-suc_flags
    ssigcontext_rip:     db "ucontext.sigcontext.rip: 0x"
    slen_sigcontext_rip: equ $-ssigcontext_rip
    ssigcontext_rsp:     db "ucontext.sigcontext.rsp: 0x"
    slen_sigcontext_rsp: equ $-ssigcontext_rsp
    ssigcontext_rcx:     db "ucontext.sigcontext.rcx: 0x"
    slen_sigcontext_rcx: equ $-ssigcontext_rcx
    ssigcontext_rsi:     db "ucontext.sigcontext.rsi: 0x"
    slen_sigcontext_rsi: equ $-ssigcontext_rsi
    ssigcontext_rdi:     db "ucontext.sigcontext.rdi: 0x"
    slen_sigcontext_rdi: equ $-ssigcontext_rdi
    ssigsegv:            db "Catched SIGSEGV",0x0a
    slen_sigsegv:        equ $-ssigsegv
    strampoline:         db "Trampoline",0x0a
    slen_trampoline:     equ $-strampoline
    scr:                 db 0x0a

section .data
    tries:               dq 0           ; number of tries for the copy
    sigaction_act:       dq sighandler  ; sa_handler
                         dq 0x04000004  ; sa_flags (SA_RESTORER | SA_SIGINFO)
                         dq sa_restorer ; sa_restorer
                         dq 0           ; sa_mask
    sigaction_old:       dq 0,0,0,0,0   ; old sa_handler

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
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,strampoline
    mov   RDX,slen_trampoline
    syscall

    mov   RAX,15             ; sys sigreturn
    syscall

sighandler:
    mov   R15,RDX            ; sigcontext
    mov   R14,RSI            ; siginfo
    mov   R13,RDI            ; signum

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,ssigsegv
    mov   RDX,slen_sigsegv
    syscall

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
    mov   EAX,[RSI]          ; siginfo.si_signo
    mov   RDI,scratch
    call  printdw
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
    mov   EAX,[RSI+4]        ; siginfo.si_errno
    mov   RDI,scratch
    call  printdw
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
    mov   EAX,[RSI+8]        ; siginfo.si_code
    mov   RDI,scratch
    call  printdw
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
    mov   RSI,ssigaddr
    mov   RDX,slen_sigaddr
    syscall
    mov   RSI,R14            ; siginfo
    mov   RAX,[RSI+16]       ; siginfo._sigfault._addr
    mov   RDI,scratch
    call  printhqw
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
    mov   RSI,ssrcaddr
    mov   RDX,slen_srcaddr
    syscall
    mov   RAX,src
    add   RAX,1024*1024
    mov   RDI,scratch
    call  printhqw
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
    mov   RSI,sinsaddr
    mov   RDX,slen_insaddr
    syscall
    mov   RAX,copy
    mov   RDI,scratch
    call  printhqw
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
    mov   RSI,sucontext
    mov   RDX,slen_ucontext
    syscall
    mov   RAX,R15            ; ucontext
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
    mov   RSI,suc_flags
    mov   RDX,slen_uc_flags
    syscall
    mov   RSI,R15            ; ucontext
    mov   RAX,[RSI]          ; ucontext.uc_flags
    mov   RDI,scratch
    call  printhqw
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
    mov   RSI,ssigcontext_rip
    mov   RDX,slen_sigcontext_rip
    syscall
    mov   RSI,R15            ; ucontext
    mov   RAX,[RSI+40+128]   ; ucontext.sigcontext.rip
    mov   RDI,scratch
    call  printhqw
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
    mov   RSI,ssigcontext_rsp
    mov   RDX,slen_sigcontext_rsp
    syscall
    mov   RSI,R15            ; ucontext
    mov   RAX,[RSI+40+120]   ; ucontext.sigcontext.rsp
    mov   RDI,scratch
    call  printhqw
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
    mov   RSI,ssigcontext_rcx
    mov   RDX,slen_sigcontext_rcx
    syscall
    mov   RSI,R15            ; ucontext
    mov   RAX,[RSI+40+112]   ; ucontext.sigcontext.rcx
    mov   RDI,scratch
    call  printhqw
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
    mov   RSI,ssigcontext_rsi
    mov   RDX,slen_sigcontext_rsi
    syscall
    mov   RSI,R15            ; ucontext
    mov   RAX,[RSI+40+72]    ; ucontext.sigcontext.rsi
    mov   RDI,scratch
    call  printhqw
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
    mov   RSI,ssigcontext_rdi
    mov   RDX,slen_sigcontext_rdi
    syscall
    mov   RSI,R15            ; ucontext
    mov   RAX,[RSI+40+64]    ; ucontext.sigcontext.rdi
    mov   RDI,scratch
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RAX,normal_end     ; move the address of the normal end to the RIP
    mov   RSI,R15            ; ucontext
    mov   [RSI+40+128],RAX   ; ucontext.sigcontext.rip

    ret

    mov   RAX,60             ; sys exit
    mov   RDI,1              ; exit code
    syscall
