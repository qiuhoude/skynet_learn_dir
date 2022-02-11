#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/wait.h>

#define MYFIFO "myfifo.fifo"
#define FILE_MODE (S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)

int main(void) {
  char buffer[256];
  pid_t pid;
  int fd;

  unlink(MYFIFO);
  if (mkfifo(MYFIFO, FILE_MODE) < 0) {
    perror("mkfifo error");
    return -1;
  }

  if ((pid = fork()) < 0) {
    perror("fork");
    return -1;
  } else if (pid > 0) {
    char s[] = "hello world!";
    fd = open(MYFIFO, O_RDWR);
    write(fd, s, sizeof(s));
    close(fd);
  } else {
    fd = open(MYFIFO, O_RDONLY);
    read(fd, buffer, 256);
    printf("%s\n", buffer);
    close(fd);
    exit(0);
  }

  waitpid(pid, NULL, 0);
  return 0;
}