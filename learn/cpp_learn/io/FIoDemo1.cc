#include <iostream>
#include <fstream>
#include <cstdlib>  //qsort在此头文件中声明

using namespace std;

//文件IO
/*
C++ 标准类库中有三个类可以用于文件操作，它们统称为文件流类。这三个类是
ifstream：用于从文件中读取数据。
ofstream：用于向文件中写人数据。
fstream：既可用于从文件中读取数据，又可用于 向文件中写人数据。

ios

istream extends ios
ostream extends ios

iostream extends ostream,istream
ifstream extends istream
ofstream extends ostream

fstream extends iostream
*/

static void testOpen() {
  ifstream inFile;
  inFile.open("test.txt", ios::in);
  if (inFile)  //条件成立，则说明文件打开成功
    inFile.close();
  else
    cout << "test.txt doesn't exist" << endl;
  ofstream oFile;
  oFile.open("test1.txt", ios::out);
  if (!oFile)  //条件成立，则说明文件打开出错
    cout << "error 1" << endl;
  else
    oFile.close();
  oFile.open("tmp/test2.txt", ios::out | ios::in);
  if (oFile)  //条件成立，则说明文件打开成功
    oFile.close();
  else
    cout << "error 2" << endl;
  fstream ioFile;
  ioFile.open("test3.txt", ios::out | ios::in | ios::trunc);
  if (!ioFile)
    cout << "error 3" << endl;
  else
    ioFile.close();
}

//例题：编写一个程序，将文件 in.txt 中的整数排序后输出到 out.txt
const int MAX_NUM = 1000;
int buff[MAX_NUM];  //存放文件中读入的整数

// 比较函数
int compareNum(const void* e1, const void* e2) {
  return *((int*)e1) - *((int*)e2);
}
static int test2() {
  //读入的整数个数
  ifstream srcFile("in.txt", ios::in);  //以文本模式打开in.txt备读
  if (!srcFile) {                       //打开失败
    cout << "error opening source file." << endl;
    return 0;
  }

  ofstream destFile("out.txt", ios::out);  //以文本模式打开out.txt备写
  if (!destFile) {
    srcFile.close();  // (注意)程序结束前不能忘记关闭以前打开过的文件
    cout << "error opening destination file." << endl;
    return 0;
  }

  int x;
  int total = 0;

  while (srcFile >> x)  //可以像用cin那样用ifstream对象
  {
    buff[total++] = x;  // 存储到buff中
  }
  qsort(buff, total, sizeof(int), compareNum);

  for (int i = 0; i < total; i++) {
    destFile << buff[i] << " ";
  }
  destFile.close();
  srcFile.close();
  return 0;
}

int main() {
  //  testOpen();
  return test2();
}