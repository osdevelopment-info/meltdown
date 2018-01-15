bits 64

section .bss
    scratch:   resb 4096

section .data
    vendor:        db "vendor_id: "
    cpu_vend:      db "xxxxxxxxxxxx",0xa
    len_vendor:    equ $-vendor
    max_cpuid:     db "Max Basic CPUID value: "
    len_max_cpuid: equ $-max_cpuid
    family:        db "cpu family: 0x"
    cpu_family     db "xxxx",0xa
    len_family     equ $-family
    cr:            db 0xa

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

; Scratch registers
; R8 maximum Basic CPUID Information
_start:
    xor   RAX,RAX            ; clear RAX
    cpuid                    ; get cpu information 0x0 (Basic CPUID Information)
    mov   R8,RAX             ; save the maximal for Basic CPUID Information
    mov   [cpu_vend],EBX     ; copy vendor information to reserved string 
    mov   [cpu_vend+4],EDX
    mov   [cpu_vend+8],ECX
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,vendor
    mov   RDX,len_vendor
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,max_cpuid
    mov   RDX,len_max_cpuid
    syscall
    mov   RAX,R8             ; restore the maximum Basic CPUID Information
    mov   RDI,scratch        ; mov the scratch area for usage of print
    call  printdw            ; print the max number of Basic CPUID Information
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scratch
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,cr
    mov   RDX,1
    syscall

    mov   RAX,R8             ; restore the maximum Basic CPUID Information
    cmp   EAX,1              ; check if node 1 is supported by CPUID
    jl    done_basic         ; if 1 is not supported we're done

    mov   EAX,1              ; get the next node
    cpuid                    ; get cpu information 0x0 (Basic CPUID Information)
    mov   R9,RAX             ; save the model and family
    shr   EAX,8              ; get bit 8 (lsb of family) to bit 0
    and   EAX,0x0f           ; mask the bits of the family
    cmp   EAX,0x0f           ; test if the family is a special value (0x0f)
    jne   simple_family      ; if not go directly to the output
    mov   RAX,R9             ; restore family information
    shr   EAX,20             ; get the extended family information
    and   EAX,0xff           ; mask the extended family information
    add   EAX,0x0f           ; add the family
simple_family:
    mov   RDI,cpu_family
    call  printhw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,family
    mov   RDX,len_family
    syscall

done_basic:

    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall
