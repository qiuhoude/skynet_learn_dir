#include <arpa/inet.h>
#include <netinet/in.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// gcc socketclient.c -lpthread -o socketclient
#define MAXLINE 128

void *
readthread(void *arg)
{

    pthread_detach(pthread_self());
    int sockfd = (int)arg;
    int n = 0;
    char buf[MAXLINE];
    while (1)
    {
        n = read(sockfd, buf, MAXLINE);
        if (n == 0)
        {
            printf("the other side has been closed.\n");
            close(sockfd);
            exit(0);
        }
        else
            write(STDOUT_FILENO, buf, n); // 往控制台写入
    }
    return (void *)0;
}

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("usage:%s port\n", argv[0]);
        return -1;
    }
    int port = atoi(argv[1]);

    struct sockaddr_in servaddr;
    int sockfd;
    short size, nsize; // msg head len
    char buf[MAXLINE];
    unsigned char sendbuf[MAXLINE];

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    inet_pton(AF_INET, "127.0.0.1", &servaddr.sin_addr);
    servaddr.sin_port = htons(port);
    connect(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr));

    pthread_t thid;
    pthread_create(&thid, NULL, readthread, (void *)sockfd); // 创建线程

    while (fgets(buf, MAXLINE, stdin) != NULL)
    {
        size = (short)strlen(buf);                  // 计算需要发送的数据包长度
        nsize = htons(size);                        // 转换成大端序
        memcpy(sendbuf, &nsize, sizeof(nsize));     //nsize先填入sendbuf
        memcpy(sendbuf + sizeof(nsize), buf, size); //再填入buf内容
        write(sockfd, sendbuf,sizeof(nsize) + size); // head + data = totalLen
    }

    close(sockfd);
    return 0;
}
