OBJS = Add8to4 Arithmetic Controlflow FArithmetic ProcessStack FunctionT SystemCallDemo

all:	$(OBJS)

%:	%.asm
	nasm -g -f elf64 $@.asm
	ld -o $@ $@.o
 
clean:
	rm -f $(OBJS)  *.o