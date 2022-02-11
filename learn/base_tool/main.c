#include <stdio.h>
#include <stdlib.h>

// gcc -c main.c
// objdump -h main.o


static char bss[1024];     // 未初始化全局变量，在BSS段
//int data = 0;            // 初始化为0全局变量，在BSS段
//static int data = 0;     // 初始化为0静态全局变量，在BSS段
//int data = 1234;         // 已初始化全局变量，在DATA段
static int data = 1234;    // 已初始化静态全局变量，在DATA段
static const char *text = "foobar";

static void foobar(void)
{
        printf("Hi foobar\n");
}

int main(void)
{
        //static int bss = 0;          // 已初始化为0的静态局部变量，在BSS段
        //static int bss;              // 未初始化的静态局部变量，在BSS段
        //static int data = 123;       // 已初始化静态局部变量，在DATA段
        //char *ptr = "Hello World!";  // 局部变量，ptr存在在栈中，而指向的字符串则是在字符常量区
        int stack = 0;                 // 局部变量，存在在栈中
        char *heap = (char *)malloc(1000);

        printf("Address of various segments:\n");
        printf("     Text Segment: %p\n", foobar);
        printf("       RO Segment: %p\n", text);
        printf("     Data Segment: %p\n", &data);
        printf("              BSS: %p\n", bss);
        printf("    Stack Segment: %p\n", &stack);
        printf("     Heap Segment: %p\n", heap);

        return 0;
}