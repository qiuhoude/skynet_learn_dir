#include <unistd.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/syslog.h>
#include <sys/param.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int init_deamon(void) {
  // 1）屏蔽一些控制终端操作的信号
  signal(SIGTTOU, SIG_IGN);
  signal(SIGTTIN, SIG_IGN);
  signal(SIGTSTP, SIG_IGN);
  signal(SIGHUP, SIG_IGN);

  int pid;
  // 2）在后台运行
  if ((pid = fork()) != 0) {  // 父进程
    exit(0);                  //结束父进程，子进程继续
  } else if (pid < 0) {       // 出错
    perror("fork");
    exit(EXIT_FAILURE);
  }

  // 3）脱离控制终端、登录会话和进程组
  setsid();

  // 4）禁止进程重新打开控制终端
  if ((pid = fork()) != 0) {  // 父进程
    exit(0);  // 结束第一子进程，第二子进程继续（第二子进程不再是会话组长）
  } else if (pid < 0) {  // 出错
    perror("fork");
    exit(EXIT_FAILURE);
  }

  // 6）改变当前工作目录
  chdir("/tmp");

  // 7）重设文件创建掩模
  umask(0); // 编程规则中需要的

  // 8）处理 SIGCHLD 信号
  signal(SIGCHLD, SIG_IGN);

  return 0;
}

int main() {
  init_deamon();
  // ps axj 查看
  while (1)
    ;
  return 0;
}