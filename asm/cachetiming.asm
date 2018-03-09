bits 64
     global         _start
     pagesize       equ  4096

section .rodata
     suncached:     db "Uncached Access Time: ",0x00
     scached:       db "Cached Access Time: ",0x00

section .bss
     align          pagesize
     data:          times 2 resb pagesize

section .text
_start:
     mov       RDI,suncached
     call      _print
     xor       RDI,RDI
     mov       RAX,60
     syscall

_calccachetime:
     xor       RAX,RAX
     xor       RDX,RDX
     lfence
     rdtsc
     shl       RDX,32
     add       RAX,RDX
     mov       R8,RAX
     mov       RCX,[RDI]
     lfence
     rdtsc
     shl       RDX,32
     add       RAX,RDX
     sub       RAX,R8
     ret

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


_nprint:
     mov       RDX,RSI
     mov       RSI,RDI
     mov       RDI,1
     mov       RAX,1
     syscall
     ret

_print:
     xor       AL,AL
     mov       RSI,RDI
.next_char:
     scasb
     jne       .next_char
     xchg      RDI,RSI
     sub       RSI,RDI
     call      _nprint
     ret
