// 对象写入

#include <iostream>
#include <fstream>
#include <string.h>

using namespace std;

class CStudent {
 public:
  CStudent() {}
  CStudent(char* n, int a) {
    strcpy(name, n);
    age = a;
  }
  char name[10];
  int age;
};

static void wirteObjTest() {
  CStudent s1("abcde", 30);
  //   cout << s1.name << endl;
  ofstream outFile("student.data", ios::out | ios::binary);
  outFile.write((char*)&s1, sizeof(s1));
  outFile.close();
  cout << "写入成功" << endl;
}

static void readObjTest() {
  ifstream inFile("student.data", ios::in | ios::binary);
  if (!inFile) {
    cout << "read error" << endl;
    return;
  }
  CStudent s;
  while (inFile.read((char*)&s, sizeof(s))) {  //一直读到文件结束
    int readedBytes = inFile.gcount();         // 读取字节数
    cout << "读取到的student " << s.name << " " << s.age << " " << readedBytes
         << endl;
  }
  inFile.close();
}

int main() {
  wirteObjTest();
  readObjTest();
}