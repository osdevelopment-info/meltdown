SHELL = /bin/sh
.SUFFIXES: .asm
NASM = /usr/bin/nasm
NASM_OPTS = -f elf64 -g -F stabs
LD = /usr/bin/ld
LD_OPTS = -melf_x86_64

clean:
	rm -rf bin
	rm -rf build

all: prepare cpuinfo sighandler sigretry

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

cpuinfo: print.o cpuinfo.o
	$(LD) $(LD_OPTS) -o bin/cpuinfo build/print.o build/cpuinfo.o

sighandler: print.o sighandler.o
	$(LD) $(LD_OPTS) -o bin/sighandler build/print.o build/sighandler.o

sigretry: print.o sigretry.o
	$(LD) $(LD_OPTS) -o bin/sigretry build/print.o build/sigretry.o
