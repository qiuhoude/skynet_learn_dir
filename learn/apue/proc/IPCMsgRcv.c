#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/stat.h>

#include "IPCHead.h"

int main(void) {
  struct msgtype msg;
  key_t key;
  int msgid;
  if ((key = ftok(MSG_FILE, 'a')) == -1) {
    perror("ftok");
    exit(1);
  }
  if ((msgid = msgget(key, PERM)) == -1) {
    perror("msgget");
    exit(1);
  }

  msg.mtype = 1;
  strcpy(msg.buffer, "这是客户端发出的消息内容");
  msgsnd(msgid, &msg, sizeof(struct msgtype), 0);
  memset(&msg, '\0', sizeof(struct msgtype));
  msgrcv(msgid, &msg, sizeof(struct msgtype), 2, 0);
  printf("Client Receive: %s\n", msg.buffer);
  return 0;
}
