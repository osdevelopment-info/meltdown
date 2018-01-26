bits 64

section .bss
    measures: resq 2048
    padding:  resb 4096
    align 4096
    data:     times 257 resb 4096

section .data
    timing:     db "Timing: 0x"
    time:       times 8 db "x"
                db 0x0a
    len_timing: equ $-timing
    sx:         db "x: "
    so:         db "o: "
    scr:        db 0x0a

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
    mov   RAX,4096
    mov   RBX,257
    mul   RBX
    mov   RBX,4
    div   RBX
;    sub   RAX,4
    mov   RCX,RAX
    mov   RDI,data           ; move address of data to RSI
rand_retry:
    rdrand EAX
    jnc   rand_retry
    stosd
    loop  rand_retry

    mov   RCX,1024
    mov   RBP,measures

access_array_low:
    push  RCX
    mov   RSI,data           ; move address of data to RSI
    mov   RBX,4096
    clflush [RSI]            ; flush the cache
    clflush [RSI+RBX]        ; flush the cache

    mov   R8,[RSI]

    call  time_calc

    mov   RAX,R14
    sub   RAX,R15
    mov   [RBP],EAX
    add   RBP,4
;    mov   RDI,time
;    call  printhdw
;    mov   RAX,1              ; sys write
;    mov   RDI,1              ; stdout
;    mov   RSI,timing
;    mov   RDX,len_timing
;    syscall
    mov   RAX,R13
    sub   RAX,R14
    mov   [RBP],EAX
    add   RBP,4
;    mov   RDI,time
;    call  printhdw
;    mov   RAX,1              ; sys write
;    mov   RDI,1              ; stdout
;    mov   RSI,timing
;    mov   RDX,len_timing
;    syscall
    mov   EAX,[RBP-8]
    sub   EAX,[RBP-4]
;    mov   RDI,time
;    call  printhdw
;    mov   RAX,1              ; sys write
;    mov   RDI,1              ; stdout
;    mov   RSI,timing
;    mov   RDX,len_timing
;    syscall
    bt    EAX,31
    jc    mark_xl
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,so
    mov   RDX,1
    syscall
    jmp   markedl
mark_xl:
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sx
    mov   RDX,1
    syscall
markedl:
    pop   RCX
    dec   RCX
    jnz   access_array_low

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RBP,measures
    mov   RCX,1024
    xor   RAX,RAX
    xor   R8,R8
    xor   R9,R9
statistic_l:
    mov   EAX,[RBP]
    add   RBP,4
    sub   EAX,[RBP]
    add   RBP,4
    bt    EAX,31
    jc    inc_xl
    inc   R9
    jmp   stat_loop_l
inc_xl:
    inc   R8
stat_loop_l:
    loop  statistic_l

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sx
    mov   RDX,3
    syscall
    mov   RAX,R8
    mov   RDI,padding
    call  printdw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,padding
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,3
    syscall

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,so
    mov   RDX,3
    syscall
    mov   RAX,R9
    mov   RDI,padding
    call  printdw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,padding
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,3
    syscall

    mov   RCX,1024
    mov   RBP,measures

access_array_high:
    push  RCX
    mov   RSI,data           ; move address of data to RSI
    mov   RBX,4096
    clflush [RSI]            ; flush the cache
    clflush [RSI+RBX]        ; flush the cache

    mov   R8,[RSI+RBX]

    call  time_calc

    mov   RAX,R14
    sub   RAX,R15
    mov   [RBP],EAX
    add   RBP,4
    mov   RAX,R13
    sub   RAX,R14
    mov   [RBP],EAX
    add   RBP,4
    mov   EAX,[RBP-8]
    sub   EAX,[RBP-4]
    bt    EAX,31
    jc    mark_xh
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,so
    mov   RDX,1
    syscall
    jmp   markedh
mark_xh:
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sx
    mov   RDX,1
    syscall
markedh:
    pop   RCX
    dec   RCX
    jnz   access_array_high

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RBP,measures
    mov   RCX,1024
    xor   RAX,RAX
    xor   R8,R8
    xor   R9,R9
statistic_h:
    mov   EAX,[RBP]
    add   RBP,4
    sub   EAX,[RBP]
    add   RBP,4
    bt    EAX,31
    jc    inc_xh
    inc   R9
    jmp   stat_loop_h
inc_xh:
    inc   R8
stat_loop_h:
    loop  statistic_h

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sx
    mov   RDX,3
    syscall
    mov   RAX,R8
    mov   RDI,padding
    call  printdw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,padding
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,3
    syscall

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,so
    mov   RDX,3
    syscall
    mov   RAX,R9
    mov   RDI,padding
    call  printdw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,padding
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,3
    syscall

_end:
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall

; Get the time for reading data (with and w/o cache) by getting two values from
; a probe array (with some distance)
; - in
; RSI: start of the probe array (must be at least RCX bytes)
; RBX: offset in the probe array for the second access
; - out
; R15: the 1st time stamp (start of 1st read)
; R14: the 2nd time stamp (end of 1st read/start of 2nd read)
; R13: the 3rd time stamp (end of 2nd read)
; - clobbered
; RAX
; RCX
; RDX
time_calc:
    lfence
    rdtsc                    ; get the time stamp counter
;    shl   RDX,32             ; mov EDX to the high double word
;    add   RAX,RDX            ; add it to the low double word
    mov   R15,RAX            ; save the value to R15

    mov   RCX,[RSI]          ; load data from the probe array

    lfence
    rdtsc                    ; get the time stamp counter
;    shl   RDX,32             ; mov EDX to the high double word
;    add   RAX,RDX            ; add it to the low double word
    mov   R14,RAX            ; save the value to R14

    mov   RCX,[RSI+RBX]      ; load data from the probe array

    lfence
    rdtsc                    ; get the time stamp counter
;    shl   RDX,32             ; mov EDX to the high double word
;    add   RAX,RDX            ; add it to the low double word
    mov   R13,RAX            ; save the value to R13

    ret
