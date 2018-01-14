bits 64

section .bss
    scratch: resb 4096

section .data
    vendor:        db "Vendor: "
    cpu_vend:      db "xxxxxxxxxxxx",0xa
    len_vendor:    equ $-vendor
    max_cpuid:     db "Max Basic CPUID value: "
    len_max_cpuid: equ $-max_cpuid
    cr:            db 0xa

section .text
    extern printdw
    global _start

_start:
    xor   RAX,RAX
    cpuid
    mov   [cpu_vend],EBX
    mov   [cpu_vend+4],EDX
    mov   [cpu_vend+8],ECX
    mov   RAX,1          ; sys write
    mov   RDI,1          ; stdout
    mov   RSI,vendor
    mov   RDX,len_vendor
    syscall
    mov   RAX,1          ; sys write
    mov   RDI,1          ; stdout
    mov   RSI,max_cpuid
    mov   RDX,len_max_cpuid
    syscall
    mov   RDI,scratch
    call  printdw
    mov   RAX,1          ; sys write
    mov   RDI,1          ; stdout
    mov   RSI,scratch
    syscall
    mov   RAX,1          ; sys write
    mov   RDI,1          ; stdout
    mov   RSI,cr
    mov   RDX,1
    syscall

    xor   RDI,RDI ; exit code
    mov   RAX,60  ; sys exit
    syscall
