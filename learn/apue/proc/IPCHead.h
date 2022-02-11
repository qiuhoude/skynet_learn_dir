#ifndef IPCHEAD
#define IPCHEAD

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <errno.h>
#include <sys/stat.h>

#define MSG_FILE "./IPCData.txt"
#define BUFFER 255
#define PERM S_IRUSR | S_IWUSR

struct msgtype {
  long mtype;
  char buffer[BUFFER + 1];
};
#endif