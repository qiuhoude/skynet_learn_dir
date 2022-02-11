#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>

static void deadProc() {
  pid_t pid;
  //创建一个进程
  pid = fork();
  //创建失败
  if (pid < 0) {
    perror("fork error:");
    exit(1);
  }

  if (pid == 0) {  //子进程
    printf("I am the child process.\n");
    //输出进程ID和父进程ID
    printf("pid: %d\tppid:%d\n", getpid(), getppid());
    printf("child process is exited.\n");
    exit(0);
  } else {  //父进程
    printf("I am father process.\n");
    // 等待子进程先退出
    sleep(2);
    //输出进程信息
    system("ps -o pid,ppid,state,tty,command");  // 显示僵尸进程 状态时z
    printf("father process is  exited.\n");
  }
}

// 产生多个僵尸进程
static void multDeadProc() {
  pid_t pid;

  while (1) {
    if ((pid = fork()) < 0) {
      perror("fork error");
      exit(1);
    } else if (pid == 0) {
      printf("I am a child process.\nI am exiting.\n");
      //子进程退出，成为僵尸进程
      exit(0);
    } else {
      //父进程休眠20s 继续创建子进程
      sleep(20);
      continue;
    }
  }
}
static void sig_child(int);

// 处理僵尸进程的方式 1. 信号
static void resolveDeadProcBySign() {
  pid_t pid;
  signal(SIGCHLD, sig_child);

  if ((pid = fork()) < 0) {
    perror("fork error");
    exit(1);
  } else if (pid == 0) {  // child
    printf("I am child process,pid id %d.I am exiting.\n", getpid());
    exit(0);
  } else {
    printf("I am father process.I will sleep two seconds\n");
    // 等待子进程先退出
    sleep(2);
    //输出进程信息
    system("ps -o pid,ppid,state,tty,command");  // 显示僵尸进程 状态时z
    printf("father process is  exited.\n");
  }
}
// 子进程信关闭号处理
static void sig_child(int signo) {
  pid_t pid;
  int stat;
  while ((pid = waitpid(-1, &stat, WNOHANG)) > 0) {  //处理僵尸进程 非阻塞模式
    printf("----------child %d terminated stat=%d.\n", pid, stat);
  }
}

// 处理僵尸进程的方式 2. 2次fork
static void resolveDeadProcBy2Fork() {
  pid_t pid;

  if ((pid = fork()) < 0) {
    perror("fork error");
    exit(1);
  } else if (pid == 0) {  // child

    printf("I am the 【first】 child process.pid:%d\tppid:%d\n", getpid(),
           getppid());

    if ((pid = fork()) < 0) {  //子进程再创建子进程
      perror("child fork error");
      exit(1);
    } else if (pid > 0) {
      printf("first procee is exited.\n");
      exit(0);
    }
    //第二个子进程
    //睡眠3s保证第一个子进程退出，这样第二个子进程的父亲就是init进程里
    sleep(3);
    printf("I am the 【second】 child process.pid: %d\tppid:%d\n", getpid(),
           getppid());
    exit(0);
  } else {
    printf("I am  father  process \n");
    if (waitpid(pid, NULL, 0) != pid) {  // 等待第一个子进程结束
      perror("waitepid error:");
      exit(1);
    }

    system("ps -o pid,ppid,state,tty,command");  // 显示僵尸进程 状态时z
    printf("father process is  exited.\n");
  }
}

int main() {
  //   deadProc();
  //   multDeadProc();
    resolveDeadProcBySign();
//   resolveDeadProcBy2Fork();
  return 0;
}