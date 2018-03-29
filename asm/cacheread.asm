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
     pagesize       equ 4096

section .bss
     align          pagesize
     data:          resb pagesize
     probe:         times 256 resb pagesize
     result:        resb pagesize
     timing:        resq 256
     scratch:       resb 64
;     readback:      align pagesize, resb pagesize

section .data
     scr:           db 0x0a
     sbgred:        db 0x1b,"[1;41m",0x00
     sresetstyle:   db 0x1b,"[0m",0x00
     sseparator:    db "- ",0x00
     sblank:        db " "
     semptybyte:    db "   ",0x00

section .text
_start:
     mov       RDI,data
     mov       RSI,pagesize
     rdtsc
     mov       EDX,EAX
     call      _xorshift
     mov       RDI,probe
     mov       RAX,pagesize
     mov       RCX,256
     mul       RCX
     mov       RSI,RCX
     rdtsc
     mov       EDX,EAX
     call      _xorshift
     call      _cachereadback
     mov       RDI,data
     mov       RSI,result
     call      _printcompare

     xor       RDI,RDI
     mov       RAX,60
     syscall

_printcompare:
     mov       RDX,16
     call      _printcompare16
     ret

_printcompare16:
     push      RBP
     mov       RBP,RSP
     sub       RSP,32
     mov       [RBP-8],RDI
     mov       [RBP-16],RSI
     mov       [RBP-24],RDX
     push      R12
     cmp       RDX,0x10
     ja        .done
     xor       RCX,RCX
.nextbyteleft:
     cmp       RCX,RDX
     mov       [RBP-32],RCX
     jae       .leftbytesdone
     mov       AL,[RDI+RCX]
     xor       AH,AH
     mov       DI,AX
     mov       RSI,scratch
     call      _printh8bit
     mov       RDI,1
     mov       RSI,sblank
     call      _nprint
     mov       RDI,[RBP-8]
     mov       RDX,[RBP-24]
     mov       RCX,[RBP-32]
     inc       RCX
     jmp       .nextbyteleft
.leftbytesdone:
     cmp       RCX,0x10
     jae       .leftdone
     mov       RDI,semptybyte
     call      _print
     inc       RCX
     jmp       .leftbytesdone
.leftdone:
     mov       RDI,sseparator
     call      _print
     mov       RDI,[RBP-8]
     mov       RSI,[RBP-16]
     mov       RDX,[RBP-24]
     xor       RCX,RCX
.nextbyteright:
     mov       [RBP-32],RCX
     cmp       RCX,RDX
     jae       .rightbytesdone
     mov       AL,[RSI+RCX]
     mov       AH,[RDI+RCX]
     mov       R12W,AX
     cmp       AH,AL
     je        .printplain
     mov       RDI,sbgred
     call      _print
.printplain:
     xor       RDI,RDI
     mov       AX,R12W
     xor       AH,AH
     mov       DI,AX
     mov       RSI,scratch
     call      _printh8bit
     mov       AX,R12W
     cmp       AH,AL
     je        .printdone
     mov       RDI,sresetstyle
     call      _print
.printdone:
     mov       RDI,1
     mov       RSI,sblank
     call      _nprint
     mov       RDI,[RBP-8]
     mov       RSI,[RBP-16]
     mov       RDX,[RBP-24]
     mov       RCX,[RBP-32]
     inc       RCX
     jmp       .nextbyteright
.rightbytesdone:
     cmp       RCX,0x10
     jae       .rightdone
     inc       RCX
     jmp       .rightbytesdone
.rightdone:
.done:
     mov       RDI,sresetstyle
     call      _print
     mov       RDI,1
     mov       RSI,scr
     call      _nprint
     pop       R12
     mov       RSP,RBP
     pop       RBP
     ret

_cachereadback:
     xor       R8,R8
.nextbyte:
     push      R8
     mov       RDI,probe
     mov       RSI,pagesize
     call      _clearcache
     pop       R8
     mov       RSI,data
     xor       RAX,RAX
     mov       AL,[RSI+R8]
     mov       RDX,pagesize
     mul       RDX
     mov       RSI,probe
     mov       AL,[RSI+RAX]
     mov       RDI,probe
     mov       RSI,pagesize
     mov       RDX,timing
     push      R8
     call      _detectbytebycl
     pop       R8
     mov       RDI,result
     mov       [RDI+R8],AL
     inc       R8
     cmp       R8,pagesize
     jb        .nextbyte
     ret

_clearcache:
     cld
     mov       RCX,256
     xor       RAX,RAX
.clear_next:
     clflush   [RDI+RAX]
     add       RAX,RSI
     loop      .clear_next
;     lfence
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

_calcareacachetime:
     xor       RCX,RCX
.next_timing:
     push      RCX
     push      RDX
     push      RDI
     push      RSI
     call      _calccachetime
     push      RAX
     mov       RDI,RAX
     mov       RSI,scratch
     call      _printdu64bit
     mov       RDI,1
     mov       RSI,scr
     call      _nprint
     pop       RAX
     pop       RSI
     pop       RDI
     pop       RDX
     pop       RCX
     mov       [RDX+8*RCX],RAX
     add       RDI,RSI
     inc       RCX
     cmp       RCX,256
     jb        .next_timing
     ret

_detectbytebycl:
     push      RDI
     call      _calcareacachetime
     pop       RDI
     mov       RSI,RDX
     xor       RCX,RCX
     mov       R8,0xffffffffffffffff
     xor       R9,R9
.nextbyte:
     mov       RAX,[RDI+8*RCX]
     cmp       RAX,R8
     jb        .foundbyte
     inc       RCX
     cmp       RCX,256
     jae       .done
     jmp       .nextbyte
.foundbyte:
     mov       R8,RAX
     mov       R9,RCX
     jmp       .nextbyte
.done:
     mov       RAX,R9
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
