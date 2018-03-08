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

_xorshift:
     mov       RCX,RSI
     shr       RCX,2
.next_random:
     mov       EBX,EDX
     shl       EDX,13
     xor       EDX,EBX
     mov       EBX,EDX
     shr       EDX,17
     xor       EDX,EBX
     mov       EBX,EDX
     shl       EDX,5
     xor       EDX,EBX
     stosd
     loop      .next_random
     ret

_print:
     xor       AL,AL
     mov       RSI,RDI
.next_char:
     scasb
     jne       .next_char
     mov       RDX,RDI
     sub       RDX,RSI
     mov       RAX,1
     mov       RDI,1
     syscall
     ret
