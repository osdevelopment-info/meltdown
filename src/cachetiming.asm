bits 64

section .bss
    data:   times 256 resb 4096

section .data
    time1:  times 16 db 0
            db 0x0a
    time2:  times 16 db 0
            db 0x0a

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
    mov   RSI,data           ; move address of data to RSI

    clflush [RSI]            ; flush the cache
    rdtsc                    ; read the time stamp counter
    shl   RDX,32             ; move the value of EAX to the high double word
    add   RAX,RDX            ; combine EDX:EAX to a single value
    mov   R8,RAX             ; save the time stamp

    mov   RBX,[RSI]          ; read from memory

    lfence                   ; make sure that all previous operations are executed
    rdtsc                    ; read the time stamp counter
    shl   RDX,32             ; move the value of EAX to the high double word
    add   RAX,RDX            ; combine EDX:EAX to a single value
    mov   R9,RAX             ; save the time stamp
    sub   RAX,R8             ; calculate the time used for the read
    mov   R8,RAX

    mov   RBX,[RSI]          ; read from (cached memory)

    lfence                   ; make sure that all previous operations are executed
    rdtsc                    ; read the time stamp counter
    shl   RDX,32             ; move the value of EAX to the high double word
    add   RAX,RDX            ; combine EDX:EAX to a single value
    sub   RAX,R9             ; calculate the time used for the read
    mov   R9,RAX

    mov   RDI,time1
    mov   RAX,R8
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,time1
    mov   RDX,17
    syscall

    mov   RDI,time2
    mov   RAX,R9
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,time2
    mov   RDX,17
    syscall

    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall
