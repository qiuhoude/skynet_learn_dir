
#include <iostream>
#include <stdio.h>
using namespace std;
int main() {
  int x, y;
  cin >> x >> y;
  freopen("test.txt", "w", stdout);  // 将标准输出重定向到 test.txt文件
  if (y == 0) {                      // 除数为0则输出错误信息
    cerr << "error." << endl;  // cerr 不能被重定向 clog 与cerr区别在于有buffer
  } else {
    cout << "x / y = " << (x / y) << endl;  // x/y结果放到test.txt文件中
  }
  return 0;
}