SHELL = /bin/sh
.SUFFIXES: .asm
NASM = /usr/bin/nasm
NASM_OPTS = -f elf64 -g -F stabs
LD = /usr/bin/ld
LD_OPTS = -melf_x86_64

.PHONY: pdf

#all: prepare cpuinfo sighandler sigretry cachetiming cacheread

all: build

pdf: Meltdown-Spectre.nw
	make -C pdf

build: prepare Meltdown-Spectre.nw
	make -C asm

clean:
	make -C pdf clean
	make -C asm clean
	rm -rf bin
	rm -rf build

prepare:
	mkdir -p bin
	mkdir -p build

print.o:
	$(NASM) $(NASM_OPTS) src/print.asm -l build/print.lst -o build/print.o

cpuinfo.o:
	$(NASM) $(NASM_OPTS) src/cpuinfo.asm -l build/cpuinfo.lst -o build/cpuinfo.o

sighandler.o:
	$(NASM) $(NASM_OPTS) src/sighandler.asm -l build/sighandler.lst -o build/sighandler.o

sigretry.o:
	$(NASM) $(NASM_OPTS) src/sigretry.asm -l build/sigretry.lst -o build/sigretry.o

cachetiming.o:
	$(NASM) $(NASM_OPTS) src/cachetiming.asm -l build/cachetiming.lst -o build/cachetiming.o

cacheread.o:
	$(NASM) $(NASM_OPTS) src/cacheread.asm -l build/cacheread.lst -o build/cacheread.o

cpuinfo: print.o cpuinfo.o
	$(LD) $(LD_OPTS) -o bin/cpuinfo build/cpuinfo.o build/print.o

sighandler: print.o sighandler.o
	$(LD) $(LD_OPTS) -o bin/sighandler build/sighandler.o build/print.o

sigretry: print.o sigretry.o
	$(LD) $(LD_OPTS) -o bin/sigretry build/sigretry.o build/print.o

cachetiming: print.o cachetiming.o
	$(LD) $(LD_OPTS) -o bin/cachetiming build/cachetiming.o build/print.o

cacheread: print.o cacheread.o
	$(LD) $(LD_OPTS) -o bin/cacheread build/cacheread.o build/print.o
