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
     sbgred:        db 0x1b,"[1;41m",0x00
     sresetstyle:   db 0x1b,"[0m",0x00
     sseparator:    db "- ",0x00
     sblank:        db " "
     semptybyte:    db "   ",0x00
     sstatistics:   db "Failed read relation: ",0x00
     sper:          db "/"

section .bss
     alignb         pagesize
     data:          resb pagesize
     alignb         pagesize
     probe          times 256 resb pagesize
     alignb         pagesize
     readbackdata   resb pagesize
     timings        resq 256
     scratch:       resb 32

section .text
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
     mov       RSI,pagesize
     mov       RDX,probe
     mov       RCX,pagesize
     mov       R8,readbackdata
     mov       R9,timings
     call      _readarea
     mov       RDI,data
     mov       RSI,readbackdata
     mov       RDX,pagesize
     call      _printcompare
     push      RAX
     mov       RDI,sstatistics
     call      _print
     pop       RDI
     mov       RSI,scratch
     call      _printdu64bit
     mov       RDI,1
     mov       RSI,sper
     call      _nprint
     mov       RDI,pagesize
     mov       RSI,scratch
     call      _printdu64bit
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
     xor       R9,R9
     xor       RCX,RCX
     mov       RSI,RDI
.nexttry:
     lodsq
     cmp       RAX,R8
     ja        .nohit
     mov       R8,RAX
     mov       R9,RCX
.nohit:
     inc       RCX
     cmp       RCX,256
     jb        .nexttry
     xor       RCX,RCX
     pop       RSI
.nextcount:
     lodsq
     cmp       RAX,R8
     ja        .nomin
     inc       R10
.nomin:
     inc       RCX
     cmp       RCX,256
     jb        .nextcount
     mov       RAX,R10
     shl       RAX,8
     mov       AL,R9b
     ret

_readarea:
     push      RBP
     mov       RBP,RSP
     sub       RSP,56
     mov       [RBP-8],RDI
     mov       [RBP-16],RSI
     mov       [RBP-24],RDX
     mov       [RBP-32],RCX
     mov       [RBP-40],R8
     mov       [RBP-48],R9
     xor       RAX,RAX
     mov       [RBP-56],RAX
.startread:
     mov       RDI,[RBP-24]
     mov       RSI,[RBP-32]
     call      _clearcache
     mov       RSI,[RBP-8]
     add       RSI,[RBP-56]
     xor       RAX,RAX
     mov       AL,[RSI]
     mov       RDX,[RBP-32]
     mul       RDX
     mov       RSI,[RBP-24]
     mov       AL,[RSI+RAX]
     mov       RDI,[RBP-24]
     mov       RSI,[RBP-32]
     mov       RDX,[RBP-48]
     call      _readcachetiming
     mov       RDI,[RBP-48]
     call      _analyzecachetiming
     cmp       AH,1
     ja        .startread
     mov       RDI,[RBP-40]
     mov       RCX,[RBP-56]
     add       RDI,RCX
     mov       [RDI],AL
     inc       RCX
     mov       [RBP-56],RCX
     cmp       RCX,[RBP-16]
     jb        .startread
     mov       RSP,RBP
     pop       RBP
     ret

_printcompare:
     push      RBP
     mov       RBP,RSP
     sub       RSP,40
     mov       [RBP-8],RDI
     mov       [RBP-16],RSI
     mov       [RBP-24],RDX
     push      R12
     xor       R12,R12
     shr       RDX,4
     mov       [RBP-32],RDX
     xor       RCX,RCX
.nextline:
     mov       [RBP-40],RCX
     cmp       RCX,[RBP-32]
     jae       .linesdone
     mov       RAX,RCX
     shl       RAX,4
     mov       RDI,[RBP-8]
     add       RDI,RAX
     mov       RSI,[RBP-16]
     add       RSI,RAX
     mov       RDX,0x10
     call      _printcompare16
     add       R12,RAX
     mov       RCX,[RBP-40]
     inc       RCX
     jmp       .nextline
.linesdone:
     mov       RAX,R12
     pop       R12
     mov       RSP,RBP
     pop       RBP
     ret

_printcompare16:
     push      RBP
     mov       RBP,RSP
     sub       RSP,32
     mov       [RBP-8],RDI
     mov       [RBP-16],RSI
     cmp       RDX,0x10
     jb        .valueok
     mov       RDX,0x10
.valueok:
     mov       [RBP-24],RDX
     push      R12
     push      R13
     xor       R13,R13
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
.leftemptybyte:
     cmp       RCX,0x10
     jae       .leftdone
     mov       RDI,semptybyte
     call      _print
     inc       RCX
     jmp       .leftemptybyte
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
     inc       R13
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
.rightemptybyte:
     cmp       RCX,0x10
     jae       .rightdone
     inc       RCX
     jmp       .rightemptybyte
.rightdone:
     mov       RDI,sresetstyle
     call      _print
     mov       RDI,1
     mov       RSI,slf
     call      _nprint
     mov       RAX,R13
     pop       R13
     pop       R12
     mov       RSP,RBP
     pop       RBP
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
