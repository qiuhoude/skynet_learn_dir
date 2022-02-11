#include <string.h>
#include <stdio.h>

#include "lua.h" // 包括创建Lua环境、调用Lua函数、读写Lua环境中全局变量，以及注册供Lua调用的新函数等等；
#include "lauxlib.h" // 定义了辅助库提供的辅助函数
#include "lualib.h" // 定义了打开标准库的函数


//gcc -g lua_c_demo.c -llua -lm -ldl -o lua_c_demo

int
main(){
    char buff[256] = {0};
    int error;
    lua_State *L = luaL_newstate(); // 打开Lua
    luaL_openlibs(L); // 打开标准库
    while (fgets(buff, sizeof(buff), stdin) != NULL)
    {
        error = luaL_loadbuffer(L, buff, strlen(buff), "line")
            || lua_pcall(L, 0, 0, 0);
        if (error)
        {
            fprintf(stderr, "%s", lua_tostring(L, -1));
            lua_pop(L, 1); // 从栈中弹出错误消息
        }
    }

    lua_close(L);
    return 0;

}