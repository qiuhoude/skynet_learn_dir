
#include <stdio.h>
#include <stdlib.h>

// system 函数主要用于执行指定的shell命令，以及shell脚本 参数是 shell
// 命令行字符串, 如果命令字符串是NULL,则仅当命令处理程序可用时，system 返回非 0
// 值；可以用于测试system函数是否可以用

// 返回值：
// 1 .fork 失败或者 waitpid 返回除 EINTR 之外的出错，则 system 返回 -1，并且设置
// errno
// 2. 如果 exec 失败（表示不能执行 shell），则其返回值如同 shell 执行了 exit
// (127) 一样
// 3. 否则所有 3 个函数（fork、exec 和 waitpid）都成功，那么 system 的返回值是
// shell 的终止状态，其格式已在 waitpid 中说明。参看：UNIX再学习 -- exit 和 wait
// 系列函数