OBJS = deamonDemo1

CFLAGS += -Wall -g

all:	$(OBJS)

%:	%.c
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)
 
clean:
	rm -f $(OBJS)  *.o