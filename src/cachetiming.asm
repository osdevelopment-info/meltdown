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
    mov   RSI,data           ; move address of data to RSI
    mov   RBP,measures
    mov   RCX,256
    clflush [RSI]            ; flush the cache
    clflush [RSI+RCX]        ; flush the cache

    mov   RBX,[RSI]

    call  time_calc

    mov   RAX,R14
    sub   RAX,R15
    mov   [RBP],RAX
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall
    mov   RAX,R13
    sub   RAX,R14
    mov   [RBP+8],RAX
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall
    mov   RAX,[RBP]
    sub   RAX,[RBP+8]
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall

    mov   RCX,256
    mov   RSI,data           ; move address of data to RSI
    clflush [RSI]            ; flush the cache
    clflush [RSI+RCX]        ; flush the cache

    mov   RBX,[RSI+RCX]

    call  time_calc

    mov   RAX,R14
    sub   RAX,R15
    mov   [RBP],RAX
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall
    mov   RAX,R13
    sub   RAX,R14
    mov   [RBP+8],RAX
    mov   RDI,time
    call  printhqw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,timing
    mov   RDX,len_timing
    syscall
    mov   RAX,[RBP]
    sub   RAX,[RBP+8]
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

; Get the time for reading data (with and w/o cache) by getting two values from
; a probe array (with some distance)
; - in
; RSI: start of the probe array (must be at least RCX bytes)
; RCX: offset in the probe array for the second access
; - out
; R15: the 1st time stamp (start of 1st read)
; R14: the 2nd time stamp (end of 1st read/start of 2nd read)
; R13: the 3rd time stamp (end of 2nd read)
; - clobbered
; RAX
; RBX
; RDX
time_calc:
    lfence
    rdtsc                    ; get the time stamp counter
    shl   RDX,32             ; mov EDX to the high double word
    add   RAX,RDX            ; add it to the low double word
    mov   R15,RAX            ; save the value to R15

    mov   RBX,[RSI]          ; load data from the probe array

    lfence
    rdtsc                    ; get the time stamp counter
    shl   RDX,32             ; mov EDX to the high double word
    add   RAX,RDX            ; add it to the low double word
    mov   R14,RAX            ; save the value to R14

    mov   RBX,[RSI+RCX]      ; load data from the probe array

    lfence
    rdtsc                    ; get the time stamp counter
    shl   RDX,32             ; mov EDX to the high double word
    add   RAX,RDX            ; add it to the low double word
    mov   R13,RAX            ; save the value to R13

    ret
