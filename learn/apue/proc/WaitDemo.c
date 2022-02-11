#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <errno.h>

void waitDemo() {
  pid_t pid1;
  if ((pid1 = fork()) < 0) perror("fork");
  if (pid1 == 0) {
    printf("这是子进程,pid1=%d，", getpid());
    printf("父进程的pid1=%d\n", getppid());
    _exit(0);
  }

  pid_t pid2;
  if ((pid2 = fork()) < 0) perror("fork");
  if (pid2 == 0) {
    printf("这是子进程,pid2=%d，", getpid());
    printf("父进程的pid2=%d\n", getppid());
    _exit(0);
  }

  printf("这是父进程,pid=%d\n", getpid());

  while (1) {
    pid_t pid = wait(NULL);  //与 waitpid(-1,NULL,WNOHANG) 一致
    if (pid == -1) {
      if (errno != ECHILD) {
        perror("wait");
        exit(EXIT_FAILURE);
      }
      printf("子进程都死光了\n");
      break;
    }
    printf("%d子进程终止\n", pid);
  }
}

void waitpidDemo() {
  pid_t pid;
  if ((pid = fork()) < 0) {
    perror("fork");
    exit(1);
  } else if (pid == 0) {
    printf("这是子进程 pid = %d\n", getpid());
    printf("父进程的 pid = %d\n", getppid());
    exit(0);
  } else
    printf("这是父进程 pid = %d\n", getpid());

  //回收特定子进程
  pid = waitpid(pid, NULL, 0);
  if (pid == -1) {
    if (errno != ECHILD) {
      perror("waitpid");
      exit(1);
    }
  } else
    printf("%d子进程终止\n", pid);

  printf("%d父进程终止\n", getpid());
}

int main(void) {
  //   waitDemo();
  waitpidDemo();
  return 0;
}
