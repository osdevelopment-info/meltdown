bits 64
     global         _start
     pagesize       equ 4096
     datasize       equ 1024

section .bss
     align          pagesize
     data:          resb datasize
     scratch:       resb 32

section .text
_start:

     xor       RDI,RDI
     mov       RAX,60
     syscall

_calccachetime:
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
     cld
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
     mov       RDX,RDI
     mov       RDI,1
     mov       RAX,1
     syscall
     ret

_print:
     cld
     xor       AL,AL
     mov       RSI,RDI
.next_char:
     scasb
     jne       .next_char
     sub       RDI,RSI
     call      _nprint
     ret

_printdu64bit:
     mov       RAX,RDI
     mov       RDI,RSI
     mov       R8,RDI
     mov       RCX,10
     cld
.next:
     cmp       RAX,0
     je        .done
     xor       RDX,RDX
     div       RCX
     xchg      RDX,RAX
     add       AL,'0'
     stosb
     mov       RAX,RDX
     jmp       .next
.done:
     cmp       RDI,RSI
     jne       .printout
     mov       AL,'0'
     stosb
.printout:
     mov       RDX,RDI
     sub       RDX,RSI
     dec       RDI
.reverse:
     mov       AL,[RSI]
     mov       AH,[RDI]
     mov       [RSI],AH
     mov       [RDI],AL
     dec       RDI
     inc       RSI
     cmp       RSI,RDI
     jb        .reverse
     mov       RSI,R8
     mov       RDI,RDX
     call      _nprint
     ret
