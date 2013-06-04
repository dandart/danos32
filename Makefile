CC	= gcc
CFLAGS	= -m32 -Wall -Wextra -nostdlib -fno-builtin -nostartfiles -nodefaultlibs
LD	= ld
LDFLAGS = -m elf_i386
NASM = nasm
 
OBJFILES = loader.o kernel.o video.o main.o
 
all: kernel.elf

loader.o:
	$(NASM) -f elf -o $@ loader.asm
 
.c.o:
	$(CC) $(CFLAGS) -o $@ -c $<

kernel.elf: $(OBJFILES)
	$(LD) $(LDFLAGS) -T linker.ld -o $@ $^
 
clean:
	$(RM) $(OBJFILES) kernel.elf
 
install:
	$(RM) $(OBJFILES) kernel.elf

kvm: all
	kvm -kernel kernel.elf
