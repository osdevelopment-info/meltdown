bits 64
     global _start

section .bss
     measures: resq 2048
     padding:  resb 4096
     align 4096
     data:     times 257 resb 4096

section .text
_start:
     xor       RDI,RDI
     mov       RAX,60
     syscall

_print:
     xor       AL,AL
     mov       RSI,RDI
.next_char:
     scasb
     je        .found0
     jmp       .next_char
.found0:
     mov       RDX,RDI
     sub       RDX,RSI
     mov       RAX,1
     mov       RDI,1
     syscall
     ret
