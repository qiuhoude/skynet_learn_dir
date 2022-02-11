#include <iostream>
#include <string>
#include <cstring>
using namespace std;

class String {
 public:
  char* str;
  String() : str(new char[1]) { str[0] = 0; }
  String(const char* s) {
    str = new char[strlen(s) + 1];
    strcpy(str, s);
  }
  String(const String& s) {  //复制构造函数
    cout << "copy constructor called" << endl;
    str = new char[strlen(s.str) + 1];
    strcpy(str, s.str);
  }
  String& operator=(const String& s) {  //复制赋值号
    cout << "copy operator = called" << endl;
    if (str != s.str) {
      delete[] str;
      str = new char[strlen(s.str) + 1];
      strcpy(str, s.str);
    }
    return *this;
  }

  String(String&& s) : str(s.str) {  //移动构造函数
    cout << "move constructor called" << endl;
    s.str = new char[1];
    s.str[0] = 0;
  }

  String& operator=(String&& s) {  //移动赋值号
    cout << "move operator = called" << endl;
    if (str != s.str) {
      str = s.str;
      s.str = new char[1];
      s.str[0] = 0;
    }
    return *this;
  }
  ~String() {
    cout << this->str << "~String call" << endl;
    delete[] str;
  }
};

template <class T>
void MoveSwap(T& a, T& b) {
  T tmp(move(a));  // std::move(a) 为右值，这里会调用移动构造函数
  a = move(b);     // move(b) 为右值，因此这里会调用移动赋值号
  b = move(tmp);   // move(tmp) 为右值，因此这里会调用移动赋值号
}

int main() {
  String s;
  s = String("this");  //调用移动赋值号
  cout << "* * * *" << endl;
  cout << s.str << endl;
  String s1 = "hello", s2 = "world";
  MoveSwap(s1, s2);  //调用一次移动构造函数和两次移动赋值号
  cout << s2.str << endl;
  return 0;
}