NASM = /usr/bin/nasm
NASM_OPTS = -f elf64 -g -F stabs
LD = /usr/bin/ld
LD_OPTS = -melf_x86_64

all: extract build install

extract: ../Meltdown-Spectre.nw
	notangle -Rcachetiming.asm ../Meltdown-Spectre.nw > cachetiming.asm

build: cachetiming

cachetiming.o: cachetiming.asm
	$(NASM) $(NASM_OPTS) cachetiming.asm -l cachetiming.lst -o cachetiming.o

cachetiming: cachetiming.o
	$(LD) $(LD_OPTS) -o cachetiming cachetiming.o

install:
	mv cachetiming ../bin
