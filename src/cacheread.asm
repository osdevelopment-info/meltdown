bits 64

    data_size:      equ 1024            ; data array size
    page_size:      equ 4096            ; page size (must be a power of 2)

section .bss
    data:           resb data_size      ; the array to read
    read_data:      resb data_size      ; the array with the read data
    analyse:        resq 256            ; the analyse times
    print_area:     resb 65536          ; space for prepare printing
    align page_size
    probe:          times 256 resb page_size ; the probe array

section .rodata
    sdata:          dw len_sdata
                    db "Data: "
    len_sdata:      equ $-sdata
    sdata_read:     dw len_sdata_read
                    db "Data read: "
    len_sdata_read: equ $-sdata_read
    spossible:      dw len_spossible
                    db "Possible data: ",0x0a
    len_spossible:  equ $-spossible
    scr:            db 0x0a

section .text
    extern prints
    extern printqw
    extern printw
    extern printb
    extern printhb
    global _start

_start:
; initialize the data are with some random data
    mov   RCX,data_size
    shr   RCX,2               ; divide by 4 (because we use a 32bit PRNG)
    mov   RDI,data            ; move address of data to RDI
    rdtsc                     ; initialize the PRNG with a seed
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

; initialize the probe array with some data
; this is needed because an empty probe array leads to unreliable cache timing 
    mov   RAX,page_size
    mov   RBX,256
    mul   RBX                 ; the number f bytes the probe array has
    shr   RAX,2               ; divide by 4 (because we use a 32bit PRNG)
    mov   RCX,RAX
    mov   RDI,probe           ; move address of probe array to RDI
    xor   RAX,RAX
    mov   EAX,0x55aa55aa      ; initialize the PRNG with a seed
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
    mov   AL,[RDI]            ; load the data (used as offset into the probe array)
    mov   R15,page_size
    tzcnt RCX,R15
    shl   RAX,CL              ; multiply with the page size
    mov   BL,[RSI+RAX]        ; load the data from the probe array (to cache this data)

    call  determine_cache_hit ; determines the cache access times

    mov   RDI,data            ; output the real data (for reference)
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
    mov   R13,RAX
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

    mov   RSI,spossible
    mov   RDI,print_area
    call  prints
    mov   RDX,RDI
    mov   RSI,print_area
    sub   RDX,RSI
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    syscall

    xor   RCX,RCX
    mov   RSI,analyse
search_hit:
    mov   RAX,[RSI+8*RCX]
    cmp   RAX,R13
    jge   no_hit
    mov   RAX,RCX
    mov   RDI,print_area
    call  printhb
    mov   RDX,2
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,print_area
    syscall
no_hit:
    inc   RCX
    cmp   RCX,256
    jl    search_hit
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
    tzcnt RCX,RBX
    shl   RAX,CL              ; multiply with the page size
    mov   RCX,RDX
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
