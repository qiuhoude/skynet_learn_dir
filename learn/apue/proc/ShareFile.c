#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>
#include <sys/types.h>

#define BUFSIZE 5 * 5

//定义函数lock设置写锁
bool lock(int fd) {
  struct flock lock;
  lock.l_type = F_WRLCK;
  lock.l_whence = SEEK_SET;
  lock.l_start = 0;
  lock.l_len = 0;
  lock.l_pid = -1;
  if (fcntl(fd, F_SETLK, &lock) == -1) {
    if (errno != EAGAIN) {
      perror("fcntl");
      exit(EXIT_FAILURE);
    }
    return false;
  }
  return true;
}

//定义函数unlock解除写锁
void unlock(int fd) {
  struct flock lock;
  lock.l_type = F_UNLCK;
  lock.l_whence = SEEK_SET;
  lock.l_start = 0;
  lock.l_len = 0;
  lock.l_pid = -1;
  if (fcntl(fd, F_SETLKW, &lock) == -1) {
    perror("fcntl");
    exit(EXIT_FAILURE);
  }
}

void writedata(int fd, char *buf, char c) {
  int i = 0;
  //设置写锁，防止子进程和父进程同时写入造成数据混乱
  while (!lock(fd))
    ;
  //将缓冲区用要写入的字符填充。
  for (i = 0; i < BUFSIZE - 1; i++) buf[i] = c;
  for (i = 0; i < 5; i++) {
    int writed;
    //向文件fd中写入字符。
    if ((writed = write(fd, buf + i, 1)) == -1) {
      perror("write");
      exit(EXIT_FAILURE);
    }
    printf("111111111->%c,buf[0]=%c, writed = %d\n", c, *(buf + i), writed);
  }
  //解除写锁
  unlock(fd);
}

int main() {
  // fork
  // 的一个特性是进程的所有打开文件描述符都被复制到子进程中。我们说的“复制”是因为对每个文件描述符来说，就好像执行了
  // dup 函数。父进程和子进程每个相同的打开描述符共享一个文件表项。
  // 重要的一点是，父进程和子进程共性同一个文件偏移量。

  int fd = open("data.txt", O_RDWR | O_CREAT | O_TRUNC, 0666);
  if (fd == -1) {
    perror("open");
    exit(EXIT_FAILURE);
  }

  pid_t pid;
  if ((pid = fork()) < 0) {
    perror("fork");
    return 1;
  }
  //创建子进程
  if (pid == 0) {
    char buf[BUFSIZE] = {};
    writedata(fd, buf, '0');  //向 fd 写入'0'
  }
  //父进程
  else {
    sleep(3);
    char buf[BUFSIZE] = {};
    writedata(fd, buf, '1');  //向 fd 写入 '1'
  }

  if (close(fd) == -1) {
    perror("close");
    exit(EXIT_FAILURE);
  }

  return 0;
}
