bits 64

section .bss
    data:           resb 1024           ; the array to read
    read_data:      resb 1024           ; the array with the read data
    analyse:        resq 256            ; the analyse times
    print_area:     resb 65536          ; space for prepare printing
    align 4096
    probe:          times 257 resb 4096 ; the probe array

section .rodata
    sdata:          dw len_sdata
                    db "Data: "
    len_sdata:      equ $-sdata
    sdata_read:     dw len_sdata_read
                    db "Data read: "
    len_sdata_read: equ $-sdata_read
    scr:            db 0x0a
    page_size:      equ 4096            ; page size (must be a power of 2)

section .text
    extern printqw
    extern printw
    extern printb
    extern printhb
    global _start

_start:
    mov   RCX,1024            ; fill the data array with random data
    shr   RCX,2               ; divide by 4 (because we use a 32bit PRNG)
    mov   RDI,data            ; move address of data to RDI
    mov   EAX,0x55aa55aa      ; initialize the PRNG with a seed
rand_retry_data:              ; create a pseudo random number for data
    mov   EBX,EAX
    shl   EAX,13
    xor   EAX,EBX
    mov   EBX,EAX
    shr   EAX,17
    xor   EAX,EBX
    mov   EBX,EAX
    shl   EAX,5
    xor   EAX,EBX
    stosd                     ; store the value into the data array
    loop  rand_retry_data

    mov   RAX,page_size
    mov   RBX,257
    mul   RBX
    shr   RAX,2
    mov   RCX,RAX
    mov   RDI,probe           ; move address of probe array to RDI
    mov   EAX,0x55aa55aa
rand_retry_probe:             ; create a pseudo random number for probe
    mov   EBX,EAX
    shl   EAX,13
    xor   EAX,EBX
    mov   EBX,EAX
    shr   EAX,17
    xor   EAX,EBX
    mov   EBX,EAX
    shl   EAX,5
    xor   EAX,EBX
    stosd                     ; store the value into the data array
    loop  rand_retry_probe

    mov   RCX,257             ; counter for clearing the cache
    mov   RSI,probe           ; base address of the probe array (to clear from cache)
    mov   RBX,page_size       ; size of the pages
    xor   RDX,RDX             ; offset into the probe array
start_clflush:
    clflush [RSI+RDX]         ; clear the cache
    add   RDX,RBX
    loop  start_clflush

cache_data:                   ; this section reads a byte into the cache
    mov   RDI,data
    xor   RAX,RAX
    xor   RBX,RBX
    mov   AL,[RDI]
    mov   R15,page_size
    tzcnt RCX,R15
    shl   RAX,CL              ; multiply with the page size
    mov   BL,[RSI+RAX]

    call  determine_cache_hit ; determines the cache access times

    mov   RDI,data
    mov   AL,[RDI]
    mov   RDI,print_area
    call  printhb
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,print_area
    mov   RDX,2
    syscall
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    xor   RAX,RAX
    xor   RCX,RCX
    xor   R15,R15
    mov   R14,0x7fffffffffffffff
simple_out:
    mov   RAX,RCX
    mov   RDI,print_area
    call  printhb
    mov   RDX,2
    mov   AL,':'
    stosb
    inc   RDX
    mov   AL,' '
    stosb
    inc   RDX
    push  RCX
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,print_area
    syscall
    mov   RDI,print_area
    pop   RAX
    push  RAX
    mov   RSI,analyse
    mov   RAX,[RSI+RAX*8]
    add   R15,RAX
    cmp   R14,RAX
    jl    no_new_min
    mov   R14,RAX
no_new_min:
    call  printqw
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,print_area
    syscall
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall
    pop   RCX
    inc   RCX
    cmp   RCX,256
    jl    simple_out

    mov   RAX,R15             ; print out avg
    shr   RAX,8
    mov   R15,RAX
    mov   RDI,print_area
    call  printqw
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,print_area
    syscall
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RAX,R14             ; print out min
    mov   RDI,print_area
    call  printqw
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,print_area
    syscall
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RAX,R15
    add   RAX,R14
    shr   RAX,1
    mov   RDI,print_area
    call  printqw
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,print_area
    syscall
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

_end:
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

    xor   RDI,RDI             ; exit code
    mov   RAX,60              ; sys exit
    syscall

determine_cache_hit:
    mov   RSI,probe
    mov   RDI,analyse         ; load address of the analyse array
    mov   RBX,page_size       ; size of the pages
    xor   RCX,RCX
next_analyse:
    lfence
    rdtsc                     ; get the time stamp counter
    shl   RDX,32              ; mov EDX to the high double word
    add   RAX,RDX             ; add it to the low double word
    mov   R15,RAX
    mov   RAX,RCX
    mov   RDX,RCX
;    mov   R14,page_size
    tzcnt RCX,RBX
    shl   RAX,CL              ; multiply with the page size
    mov   RCX,RDX
;    shl   RAX,12              ; multiply with 4096 (page size)
    mov   DL,[RSI+RAX]

    lfence
    rdtsc                     ; get the time stamp counter
    shl   RDX,32              ; mov EDX to the high double word
    add   RAX,RDX             ; add it to the low double word
    sub   RAX,R15
    stosq

    inc   RCX
    cmp   RCX,256
    jl    next_analyse

    ret
