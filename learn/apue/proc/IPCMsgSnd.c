 #include "IPCHead.h"


int main(void) {
  struct msgtype msg;
  key_t key;
  int msgid;
  if ((key = ftok(MSG_FILE, 'a')) == -1) {
    perror("ftok");
    exit(1);
  }
  if ((msgid = msgget(key, PERM | IPC_CREAT | IPC_EXCL)) == -1) {
    perror("msgget");
    exit(1);
  }

  while (1) {
    msgrcv(msgid, &msg, sizeof(struct msgtype), 1, 0);
    printf("Server Receive: %s\n", msg.buffer);
    msg.mtype = 2;
    msgsnd(msgid, &msg, sizeof(struct msgtype), 0);
  }
  return 0;
}
