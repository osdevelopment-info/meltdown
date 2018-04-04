NASM = /usr/bin/nasm
NASM_OPTS = -f elf64 -g -F stabs
LD = /usr/bin/ld
LD_OPTS = -melf_x86_64

all: build install

build: cachetiming cachereadbyte cachereadbyte2 cachereadbyte3 cacheread

cachetiming.asm: ../Meltdown-Spectre.nw
	notangle -Rcachetiming.asm ../Meltdown-Spectre.nw > cachetiming.asm

cachetiming.o: cachetiming.asm
	$(NASM) $(NASM_OPTS) cachetiming.asm -l cachetiming.lst -o cachetiming.o

cachetiming: cachetiming.o
	$(LD) $(LD_OPTS) -o cachetiming cachetiming.o

cachereadbyte.asm: ../Meltdown-Spectre.nw
	notangle -Rcachereadbyte.asm ../Meltdown-Spectre.nw > cachereadbyte.asm

cachereadbyte.o: cachereadbyte.asm
	$(NASM) $(NASM_OPTS) cachereadbyte.asm -l cachereadbyte.lst -o cachereadbyte.o

cachereadbyte: cachereadbyte.o
	$(LD) $(LD_OPTS) -o cachereadbyte cachereadbyte.o

cachereadbyte2.asm: ../Meltdown-Spectre.nw
	notangle -Rcachereadbyte2.asm ../Meltdown-Spectre.nw > cachereadbyte2.asm

cachereadbyte2.o: cachereadbyte2.asm
	$(NASM) $(NASM_OPTS) cachereadbyte2.asm -l cachereadbyte2.lst -o cachereadbyte2.o

cachereadbyte2: cachereadbyte2.o
	$(LD) $(LD_OPTS) -o cachereadbyte2 cachereadbyte2.o

cachereadbyte3.asm: ../Meltdown-Spectre.nw
	notangle -Rcachereadbyte3.asm ../Meltdown-Spectre.nw > cachereadbyte3.asm

cachereadbyte3.o: cachereadbyte3.asm
	$(NASM) $(NASM_OPTS) cachereadbyte3.asm -l cachereadbyte3.lst -o cachereadbyte3.o

cachereadbyte3: cachereadbyte3.o
	$(LD) $(LD_OPTS) -o cachereadbyte3 cachereadbyte3.o

cacheread.asm: ../Meltdown-Spectre.nw
	notangle -Rcacheread.asm ../Meltdown-Spectre.nw > cacheread.asm

cacheread.o: cacheread.asm
	$(NASM) $(NASM_OPTS) cacheread.asm -l cacheread.lst -o cacheread.o

cacheread: cacheread.o
	$(LD) $(LD_OPTS) -o cacheread cacheread.o

install:
	mv cachetiming ../bin/
	mv cachereadbyte ../bin/
	mv cachereadbyte2 ../bin/
	mv cachereadbyte3 ../bin/
	mv cacheread ../bin/

clean:
	rm *.o *.lst
