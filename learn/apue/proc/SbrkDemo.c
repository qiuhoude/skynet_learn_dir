#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
  void *cur = sbrk(0);
  printf("1) cur = %p\n", cur);

  void *ptr = malloc(100);

  cur = sbrk(0);
  printf("2) cur = %p, ptr = %p\n", cur, ptr);
  printf("======================= \n");

  ptr = malloc(100);
  cur = sbrk(0);
  printf("3) cur = %p, ptr = %p\n", cur, ptr);

  free(ptr);
  cur = sbrk(0);
  printf("4) cur = %p, ptr = %p\n", cur, ptr);
  return 0;
}