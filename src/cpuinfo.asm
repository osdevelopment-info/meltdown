bits 64

section .bss
    cpu_family: resb 1       ; storage for the processor family
    scratch:    resb 4096

section .data
    svendor:        db "vendor_id: "
    scpu_vend:      db "xxxxxxxxxxxx",0xa
    slen_vendor:    equ $-svendor
    smax_cpuid:     db "Max Basic CPUID value: "
    slen_max_cpuid: equ $-smax_cpuid
    sfamily:        db "cpu family: 0x"
    scpu_family:    db "xxxx",0xa
    slen_family:    equ $-sfamily
    smodel:         db "cpu model: 0x"
    scpu_model:     db "xxxx",0xa
    slen_model:     equ $-smodel
    sstepping:      db "stepping: 0x"
    scpu_stepping:  db "xx",0xa
    slen_stepping:  equ $-sstepping
    sfeatures:      db "features:"
    slen_features:  equ $-sfeatures
    sfeat_fpu:      db " fpu"
    slen_feat_fpu:  equ $-sfeat_fpu
    sfeat_vme:      db " vme"
    slen_feat_vme:  equ $-sfeat_vme
    sfeat_de:       db " de"
    slen_feat_de:   equ $-sfeat_de
    sfeat_pse:      db " pse"
    slen_feat_pse:  equ $-sfeat_pse
    sfeat_tsc:      db " tsc"
    slen_feat_tsc:  equ $-sfeat_tsc
    scr:            db 0xa

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

; Scratch registers (for the complete programm)
; R8 maximum Basic CPUID Information
_start:
    xor   RAX,RAX            ; clear RAX
    cpuid                    ; get cpu information 0x00 (Basic CPUID Information)
    mov   R8,RAX             ; save the maximal for Basic CPUID Information
    mov   [scpu_vend],EBX    ; copy vendor information to reserved string 
    mov   [scpu_vend+4],EDX
    mov   [scpu_vend+8],ECX
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,svendor
    mov   RDX,slen_vendor
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,smax_cpuid
    mov   RDX,slen_max_cpuid
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
    mov   RSI,scr
    mov   RDX,1
    syscall

    mov   RAX,R8             ; restore the maximum Basic CPUID Information
    cmp   EAX,1              ; check if node 1 is supported by CPUID
    jl    done_basic         ; if 1 is not supported we're done

    mov   EAX,1              ; get the next node
    cpuid                    ; get cpu information 0x01 (Family/Model)
    mov   R9,RAX             ; save the model and family
    mov   R10,RBX            ; save the additional information
    mov   R12,RCX            ; save the features (part 2)
    mov   R13,RDX            ; save the features (part 1)
    shr   EAX,8              ; get bit 8 (lsb of family) to bit 0
    and   EAX,0x0f           ; mask the bits of the family
    mov   [cpu_family],AL    ; save the family
    cmp   EAX,0x0f           ; test if the family is a special value (0x0f)
    jne   simple_family      ; if not go directly to the output
    mov   RAX,R9             ; restore family information
    shr   EAX,20             ; get the extended family information
    and   EAX,0xff           ; mask the extended family information
    add   EAX,0x0f           ; add the family
simple_family:
    mov   RDI,scpu_family
    call  printhw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sfamily
    mov   RDX,slen_family
    syscall
    mov   RAX,R9             ; restore model information
    shr   EAX,4              ; get bit 4 (lsb of model) to bit 0
    and   EAX,0x0f           ; mask the bits of the model
    mov   BL,[cpu_family]    ; get the family information back
    cmp   BL,0x06            ; test if we need extended model information (0x06 or 0x0f)
    je    extended_model
    cmp   BL,0x0f
    jne   simple_model
extended_model:
    mov   RBX,R9             ; restore model information
    shr   EBX,12             ; get the extended model information to the high nibble
    and   EBX,0xf0
    or    EAX,EBX            ; add the model information to the low nibble
simple_model:
    mov   RDI,scpu_model
    call  printhw
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,smodel
    mov   RDX,slen_model
    syscall
    mov   RAX,R9             ; restore stepping information
    and   EAX,0x0f           ; mask the stepping information
    mov   RDI,scpu_stepping
    call  printhb
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sstepping
    mov   RDX,slen_stepping
    syscall
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sfeatures
    mov   RDX,slen_features
    syscall

    call  handle_features1

    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,scr
    mov   RDX,1
    syscall

done_basic:

    xor   RDI,RDI            ; exit code
    mov   RAX,60             ; sys exit
    syscall

handle_features1:
    bt    R13,0              ; test for fpu
    jnc   no_fpu
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sfeat_fpu
    mov   RDX,slen_feat_fpu
    syscall
no_fpu:
    bt    R13,1              ; test for vme
    jnc   no_vme
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sfeat_vme
    mov   RDX,slen_feat_vme
    syscall
no_vme:
    bt    R13,2              ; test for de
    jnc   no_de
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sfeat_de
    mov   RDX,slen_feat_de
    syscall
no_de:
    bt    R13,3              ; test for pse
    jnc   no_pse
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sfeat_pse
    mov   RDX,slen_feat_pse
    syscall
no_pse:
    bt    R13,4              ; test for tsc
    jnc   no_tsc
    mov   RAX,1              ; sys write
    mov   RDI,1              ; stdout
    mov   RSI,sfeat_tsc
    mov   RDX,slen_feat_tsc
    syscall
no_tsc:
    ret
