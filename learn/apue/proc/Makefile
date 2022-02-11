# SOURCE = $(wildcard *.c)

OBJS = SbrkDemo ShareFile DeadProc VforkDemo WaitDemo FIFODemo IPCMsgSnd IPCMsgRcv

CFLAGS += -Wall -g

all:	$(OBJS)

%:	%.c
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)
 
clean:
	rm -f $(OBJS)  *.o