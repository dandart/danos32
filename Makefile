CC	= gcc
CFLAGS	= -m32 -Wall -Wextra -nostdlib -fno-builtin -nostartfiles -nodefaultlibs -Ilib
LD	= ld
LDFLAGS = -m elf_i386
AS = as
ASFLAGS = --32
NASM = nasm
NASMFLAGS = -f elf
 
OBJFILES = loader.o kernel.o lib/video.o lib/io.o lib/clever.o lib/string.o main.o
 
all: kernel.bin

loader.o:
	$(NASM) $(NASMFLAGS) -o $@ loader.asm
 
.c.o:
	$(CC) $(CFLAGS) -o $@ -c $<

kernel.bin: $(OBJFILES)
	$(LD) $(LDFLAGS) -T linker.ld -o $@ $^
 
clean:
	$(RM) $(OBJFILES) kernel.bin
 
install:
	$(RM) $(OBJFILES) kernel.bin

kvm: all
	kvm -kernel kernel.bin
