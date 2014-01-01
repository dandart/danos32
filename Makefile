CC	= gcc
CFLAGS	= -m32 -Wall -Wextra -nostdlib -fno-builtin -nostartfiles -nodefaultlibs -Ilib
LD	= ld
LDFLAGS = -m elf_i386
AS = as
ASFLAGS = --32
NASM = nasm
NASMFLAGS = -f elf
 
OBJFILES = src/loader.o src/kernel.o lib/video.o lib/io.o lib/clever.o lib/string.o src/main.o
 
all: kernel.bin

src/loader.o:
	$(NASM) $(NASMFLAGS) -o $@ src/loader.asm
 
.c.o:
	$(CC) $(CFLAGS) -o $@ -c $<

kernel.bin: $(OBJFILES)
	$(LD) $(LDFLAGS) -T src/linker.ld -o $@ $^
 
clean:
	$(RM) $(OBJFILES) kernel.bin
 
install:
	$(RM) $(OBJFILES) kernel.bin

kvm: all
	kvm -kernel kernel.bin
