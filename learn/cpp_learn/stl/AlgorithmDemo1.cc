
#include <list>
#include <iostream>
#include <algorithm>  //要使用操作迭代器的函数模板，需要包含此文件

using namespace std;

int main() {
  int a[5] = {1, 2, 3, 4, 5};
  list<int> lst(a, a + 5);
  list<int>::iterator p = lst.begin();
  advance(p, 2);               // p向后移动两个元素，指向3
  cout << "1)" << *p << endl;  //输出 1)3
  advance(p, -1);              // p向前移动一个元素，指向2
  cout << "2)" << *p << endl;  //输出 2)2

  list<int>::iterator q = lst.end();
  q--;                                       // q 指向 5
  cout << "3)" << distance(p, q) << endl;    //输出 3)3
  cout << "3.2)" << distance(q, p) << endl;  //输出 3.2)3
  iter_swap(p, q);                           //交换 2 和 5
  cout << "4)";
  for (p = lst.begin(); p != lst.end(); ++p) cout << *p << " ";
  return 0;
}