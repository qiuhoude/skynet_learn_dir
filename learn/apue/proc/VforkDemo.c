#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

// 与 fork区别
// 1.
// 函数创建的子进程不复制父进程的物理内存，也不拥有自己独立的内存映射，而是与父进程共享全部地址空间；
// 2. 第二，vfork函数会在创建子进程的同时挂起其父进程，直到子进程终止，或通过
// exec 函数启动了另一个可执行程序

// 终止 vfork 函数创建的子进程，不要使用 return 语句，也不要调用 exit
// 函数，而要调用 _exit 函数，以避免对其父进程造成不利影响。

// vfork 函数的典型用法就是在所创建的子进程里直接调用 exec
// 函数启动另外一个进程取代其自身，这比调用 fork 函数完成同样的工作要快得多。

int globvar = 6; /* external variable in initialized data */

static void test1() {
  int var; /* automatic variable on the stack */
  pid_t pid;

  var = 88;
  printf("before vfork\n"); /* we don't flush stdio */
  if ((pid = vfork()) < 0) {
    perror("vfork error");
  } else if (pid == 0) { /* child */
    globvar++;           /* modify parent's variables */
    var++;
    _exit(0); /* child terminates */
  }

  /* parent continues here */
  printf("pid = %ld, glob = %d, var = %d\n", (long)getpid(), globvar, var);
  exit(0);
}
static void test2() {
  pid_t pid;
  if ((pid = vfork()) < 0) {
    perror("vfork error:");
    exit(1);
  } else if (pid == 0) {
    printf("child proce run pid=%d\n", getpid());
    sleep(3);
    printf("子进程结束\n");
    // 子进程不退出，则结果不可预知
    _exit(0);  //终止子进程
  }
  printf("父进程 pid = %d 开始执行\n", getpid());
  printf("父进程结束\n");
}

// 经典用法 vfork 后 execl
static void test3() {
  printf("父进程开始执行\n");
  pid_t pid;
  if ((pid = vfork()) < 0) {
    perror("vfork error:");
    exit(1);
  } else if (pid == 0) {
    printf("子进程开始执行\n");
    char *arg[] = {"ls", "-l", NULL};
    if (execv ("/bin/ls", arg) == -1) {
      // execl("/bin/ls", "ls", "-l", NULL)
      // execlp ("ls","ls", "-l", NULL) //最后一个参数须用空指针NULL作结束
      // execle ("/bin/ls", "ls", "-l", NULL, NULL)
      // execv ("/bin/ls", arg)
      // execvp ("ls", arg)
      // execve ("/bin/ls", arg, NULL)
      perror("execl");
      _exit(1);
    }
  }
  wait(NULL);
  printf("父进程结束\n");
}

int main() {
  //   test1();
  //   test2();
  test3();
  return 0;
}