bits 64

    data_size:      equ 1024            ; data array size
    page_size:      equ 4096            ; page size (must be a power of 2)

section .bss
    align page_size
    probe:          times 256 resb page_size ; the probe array
    analyse:        resq 256            ; the analyse times
    sort_area:      resq 256            ; a sort area
    data:           resb data_size      ; the array to read
    read_data:      resb data_size      ; the array with the read data
    read_status:    resb data_size      ; the array with the status of the read data
    print_area:     resb 65536          ; space for prepare printing

section .rodata
    savg:           dw len_savg
                    db "Avg access time: "
    len_savg:       equ $-savg
    smin:           dw len_smin
                    db "Min access time: "
    len_smin:       equ $-smin
    sthres:         dw len_sthres
                    db "Threshold: "
    len_sthres:     equ $-sthres
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
    mov   RDI,data            ; move address of data to RDI
    rdtsc                     ; initialize the PRNG with a seed
    call  random_fill

; initialize the probe array with some data
; this is needed because an empty probe array leads to unreliable cache timing 
    mov   RAX,page_size
    mov   RBX,256
    mul   RBX                 ; the number f bytes the probe array has
    mov   RCX,RAX
    mov   RDI,probe           ; move address of probe array to RDI
    call  random_fill

    mov   RBX,page_size       ; size of the pages
    mov   RSI,probe           ; base address of the probe array (to clear from cache)
    call  clear_cache

    mov   RDI,data
    call  cache_data

    mov   RDI,analyse         ; load address of the analyse array
    call  determine_cache_times ; determines the cache access times

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

    mov   RSI,analyse
    call  analyse_access

    ; helping output...
    mov   RDI,print_area
    mov   RSI,savg
    call  prints
    mov   RAX,R15
    call  printqw
    mov   AL,[scr]
    stosb
    mov   RDX,RDI
    mov   RSI,print_area
    sub   RDX,RSI
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    syscall

    mov   RDI,print_area
    mov   RSI,smin
    call  prints
    mov   RAX,R14
    call  printqw
    mov   AL,[scr]
    stosb
    mov   RDX,RDI
    mov   RSI,print_area
    sub   RDX,RSI
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    syscall

    mov   RDI,print_area
    mov   RSI,sthres
    call  prints
    mov   RAX,R15
    add   RAX,R14
    shr   RAX,1
    mov   R13,RAX
    call  printqw
    mov   AL,[scr]
    stosb
    mov   RDX,RDI
    mov   RSI,print_area
    sub   RDX,RSI
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
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
search_hit:
    push  RCX
    mov   RSI,analyse
    mov   RAX,[RSI+8*RCX]
    cmp   RAX,R13
    jge   no_hit
    mov   RAX,RCX
    mov   RDI,print_area
    call  printhb
    mov   AL,' '
    stosb
    mov   RDX,3
    mov   RAX,1               ; sys write
    mov   RDI,1               ; stdout
    mov   RSI,print_area
    syscall
no_hit:
    pop   RCX
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

; Fill an array with (pseudo) random data. The generated data is NOT
; cryptographically secure. The arrays size should be a multiple of 4 because
; the PRNG puts 32bit data into the array.
; - in
; EAX: a seed for the PRNG
; RCX: number of bytes to fill (should be a multiple of 4)
; RDI: address of the array to fill
; - out
; EAX: internal state of the PRNG after filling the array. Can be used as seed
;      for the next call.
; RDI: the first address after the filled array
random_fill:
    push  RBX
    push  RCX
    shr   RCX,2               ; divide by 4 (because we use a 32bit PRNG)
next_fill:
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
    loop  next_fill

    pop   RCX
    pop   RBX
    ret

; Clear the cache
; - in
; RBX: the page size to use. Must be a power of 2.
; RSI: address of the probe array. Must be page aligned and have 256 times the
;      page size space. Should be initialized with some random data.
clear_cache:
    push  RCX
    push  RDX
    mov   RCX,256             ; counter for clearing the cache
    xor   RDX,RDX             ; offset into the probe array
start_clflush:
    clflush [RSI+RDX]         ; clear the cache
    add   RDX,RBX
    loop  start_clflush

    pop   RDX
    pop   RCX
    ret

; Read data from a probe array. The page in the probe array is determined by
; the data read from the data array.
; - in
; RBX: the page size to use. Must be a power of 2.
; RSI: address of the probe array. This array must be at least 256 times the
; page size.
; RDI: address of the data to use as index in the probe array
; - out
; AL: the byte read from the data used as offset to the probe array (the rest of
;     RAX is cleared)
cache_data:
    push  RBX
    push  RCX
    push  R15
    tzcnt RCX,RBX
    xor   RAX,RAX
    mov   AL,[RDI]            ; load the data (used as offset into the probe array)
    mov   R15,RAX
    shl   RAX,CL              ; multiply with the page size
    mov   BL,[RSI+RAX]        ; load the data from the probe array (to cache this data)
    mov   RAX,R15

    pop   R15
    pop   RCX
    pop   RBX
    ret

; Determine the cache access times (in cycles) and place them for each byte
; offset in an array
; - in
; RBX: the page size to use. Must be a power of 2.
; RSI: address of the probe array. Must be page aligned and have 256 times the
;      page size space. Should be initialized with some random data.
; RDI: address of the results array. Must be large enough to hold 256 quad words
; - out
; no registers
determine_cache_times:
    push  RAX
    push  RBX
    push  RCX
    push  RDX
    push  R8
    push  R9
    tzcnt RCX,RBX
    xor   RBX,RBX             ; RBX is used as counter
next_analyse:
    mov   R8,RBX
    shl   R8,CL               ; multiply with the page size
    mfence
    rdtsc                     ; get the time stamp counter
    mov   R9b,[RSI+R8]
    shl   RDX,32              ; mov EDX to the high double word
    add   RAX,RDX             ; add it to the low double word
    mov   R15,RAX

    mfence
    rdtsc                     ; get the time stamp counter
    shl   RDX,32              ; mov EDX to the high double word
    add   RAX,RDX             ; add it to the low double word
    sub   RAX,R15
    stosq

    inc   RBX
    cmp   RBX,256
    jl    next_analyse

    pop   R9
    pop   R8
    pop   RDX
    pop   RCX
    pop   RBX
    pop   RAX
    ret

; Analyse cache timing data.
; - in
; RSI: Address of the analysis data. The array is expected to contain 256 quad
;      word values (2 KiB).
; - out
; RSI: Address of the first byte after the array with analysis data.
; R14: Minimum of the access times.
; R15: Average access time to the cache.
analyse_access:
    pushfq
    push  RAX
    push  RCX

    cld
    xor   RCX,RCX
    mov   R14,0x7fffffffffffffff
    xor   R15,R15
next_value:
    lodsq
    add   R15,RAX
    cmp   R14,RAX
    jl    no_new_min1
    mov   R14,RAX
no_new_min1:
    inc   RCX
    cmp   RCX,256
    jl    next_value
    shr   R15,8

    pop   RCX
    pop   RAX
    popfq
    ret
