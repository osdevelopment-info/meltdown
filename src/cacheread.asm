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

section .text
    extern printqw
    extern printw
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

    mov   RAX,4096
    mov   RBX,256
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

    mov   RCX,256             ; counter for clearing the cache
    mov   RSI,probe           ; base address of the probe array (to clear from cache)
    mov   RDI,data            ; move address of data to RDI
    mov   RBX,4096            ; size of the pages
    xor   RDX,RDX             ; offset into the probe array
start_clflush:
    clflush [RSI+RDX]         ; clear the cache
    add   RDX,RBX
    loop  start_clflush

    mov   RDI,data
    xor   RAX,RAX
    xor   RBX,RBX
    mov   AL,[RDI]
    mov   BX,4096
    mul   RBX
    mov   BL,[RSI+RAX]

    call  determine_cache_hit

    mov   RCX,256
simple_out:
    mov   RAX,RCX
    dec   RAX
    mov   RDI,print_area
    call  printw
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
    pop   RCX
    push  RCX
    mov   RSI,analyse
    mov   RAX,[RSI+RCX*8]
    call printqw
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
    dec   RCX
    jnz   simple_out

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
    mov   RBX,4096            ; size of the pages
    mov   RCX,256
next_analyse:
    lfence
    rdtsc                     ; get the time stamp counter
    shl   RDX,32              ; mov EDX to the high double word
    add   RAX,RDX             ; add it to the low double word
    mov   R15,RAX
    mov   RAX,RBX
    mul   RCX
    sub   RAX,RBX
    mov   RDX,[RSI+RAX]

    lfence
    rdtsc                     ; get the time stamp counter
    shl   RDX,32              ; mov EDX to the high double word
    add   RAX,RDX             ; add it to the low double word
    mov   R14,RAX

    sub   R14,R15
    mov   [RDI],R14
    add   RDI,8
    loop  next_analyse

    ret
