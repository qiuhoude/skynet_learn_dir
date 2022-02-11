
#include <exception>
#include <iostream>
#include <string>
using namespace std;

int main() {
  string str = "http://c.biancheng.net";

  try {
    char ch1 = str[100000000];
    cout << ch1 << endl;
  } catch (exception e) {
    cout << "[1]out of bound!" << endl;
  }
  try {
    char ch2 = str.at(100);
    cout << ch2 << endl;
  } catch (exception &e) {  // exception类位于<exception>头文件中
    cout << "[2]out of bound!" << endl;
  }
  return 0;
}