bits 64

section .bss
    measures: resq 1024 
    data:     times 256 resb 4096

section .data
    timing:     db "Timing: 0x"
    time:       times 16 db "x"
                db 0x0a
    len_timing: equ $-timing

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
    mov   RBP,measures       ; load measure data
    mov   RSI,data           ; move address of data to RSI
    add   RSI,4096

    clflush [RSI]            ; flush the cache
    clflush [RSI+4096]       ; flush the cache
    clflush [RSI+2048]       ; flush the cache
    mfence                   ; make sure that all previous operations are executed
    rdtsc                    ; read the time stamp counter
    mfence                   ; make sure that all previous operations are executed
    mov   [RBP],EAX
    add   RBP,4
    mov   [RBP],EDX
    add   RBP,4

    mov   RBX,[RSI]          ; read from memory

    mfence                   ; make sure that all previous operations are executed
    rdtsc                    ; read the time stamp counter
    mfence                   ; make sure that all previous operations are executed
    mov   [RBP],EAX
    add   RBP,4
    mov   [RBP],EDX
    add   RBP,4

    mov   RBX,[RSI]          ; read from memory

    mfence                   ; make sure that all previous operations are executed
    rdtsc                    ; read the time stamp counter
    mfence                   ; make sure that all previous operations are executed
    mov   [RBP],EAX
    add   RBP,4
    mov   [RBP],EDX
    add   RBP,4

    mov   RBX,[RSI+2048]     ; read from memory

    mfence                   ; make sure that all previous operations are executed
    rdtsc                    ; read the time stamp counter
    mfence                   ; make sure that all previous operations are executed
    mov   [RBP],EAX
    add   RBP,4
    mov   [RBP],EDX
    add   RBP,4

    mov   RBX,[RSI+2048]     ; read from memory

    mfence                   ; make sure that all previous operations are executed
    rdtsc                    ; read the time stamp counter
    mfence                   ; make sure that all previous operations are executed
    mov   [RBP],EAX
    add   RBP,4
    mov   [RBP],EDX
    add   RBP,4

    clflush [RSI]            ; flush the cache
    mfence                   ; make sure that all previous operations are executed
    mov   RBX,[RSI]          ; read from memory

    mfence                   ; make sure that all previous operations are executed
    rdtsc                    ; read the time stamp counter
    mfence                   ; make sure that all previous operations are executed
    mov   [RBP],EAX
    add   RBP,4
    mov   [RBP],EDX
    add   RBP,4

    mov   RBP,measures       ; load measure data
    mov   RAX,[RBP+8]
    sub   RAX,[RBP]
    add   RBP,8
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall

    mov   RAX,[RBP+8]
    sub   RAX,[RBP]
    add   RBP,8
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall

    mov   RAX,[RBP+8]
    sub   RAX,[RBP]
    add   RBP,8
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall

    mov   RAX,[RBP+8]
    sub   RAX,[RBP]
    add   RBP,8
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall

    mov   RAX,[RBP+8]
    sub   RAX,[RBP]
    add   RBP,8
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall

    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall
