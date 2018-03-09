bits 64
     global         _start
     pagesize       equ  4096

section .rodata
     suncached:     db "Uncached Access Time: ",0x00

section .bss
     measures:      resq 2048
     padding:       resb 4096
     align 4096
     data:          times 257 resb 4096

section .text
_start:
     mov       RDI,suncached
     call      _print
     xor       RDI,RDI
     mov       RAX,60
     syscall

_xorshift:
     mov       RCX,RSI
     shr       RCX,2
     mov       EAX,EDX
.next_random:
     mov       EBX,EAX
     shl       EAX,13
     xor       EAX,EBX
     mov       EBX,EAX
     shr       EAX,17
     xor       EAX,EBX
     mov       EBX,EAX
     shl       EAX,5
     xor       EAX,EBX
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
