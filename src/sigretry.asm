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

section .data
    tries:               dq 0           ; number of tries for the copy
    sigaction_act:       dq sighandler  ; sa_handler
                         dq 0x04000004  ; sa_flags (SA_RESTORER | SA_SIGINFO)
                         dq sa_restorer ; sa_restorer
                         dq 0           ; sa_mask
    sigaction_old:       dq 0,0,0,0     ; old sa_handler

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
    mov   RBX,tries          ; load address of tries
    mov   RAX,[RBX]          ; load the number of tries
    cmp   RAX,7              ; check if we already tried 8 times
    jge   retry_end
    inc   RAX                ; inc number of tries
    mov   [RBX],RAX          ; store the variable again

    mov   RAX,init_copy      ; move the address of copy to the RIP
    mov   RSI,RDX            ; ucontext
    mov   [RSI+40+128],RAX   ; ucontext.sigcontext.rip

    ret

retry_end:
    mov   RAX,60             ; sys exit
    mov   RDI,2              ; exit code
    syscall
