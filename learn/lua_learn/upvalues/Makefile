
SHARED = --shared

CFLAG = -g -O2 -Wall  -fPIC


all: mytest.so

mytest.so:	lua_test.c
	$(CC) $(CFLAG) $(SHARED)  $^ -o $@
clean:
	rm -f mytest.so