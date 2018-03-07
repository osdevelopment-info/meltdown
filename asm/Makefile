NASM = /usr/bin/nasm
NASM_OPTS = -f elf64 -g -F stabs
LD = /usr/bin/ld
LD_OPTS = -melf_x86_64

all: build install

build: cachetiming

cachetiming.asm: ../Meltdown-Spectre.nw
	notangle -Rcachetiming.asm ../Meltdown-Spectre.nw > cachetiming.asm

cachetiming.o: cachetiming.asm
	$(NASM) $(NASM_OPTS) cachetiming.asm -l cachetiming.lst -o cachetiming.o

cachetiming: cachetiming.o
	$(LD) $(LD_OPTS) -o cachetiming cachetiming.o

install:
	mv cachetiming ../bin/

clean:
	rm *.o *.lst
