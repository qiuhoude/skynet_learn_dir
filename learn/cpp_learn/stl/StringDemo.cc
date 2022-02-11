#include <iostream>
#include <string>

using namespace std;

int main() {
  {
    string s1();  // si = ""
    cout << s1 << endl;

    string s2("Hello");  // s2 = "Hello"
    cout << s2 << endl;

    string s3(4, 'K');  // s3 = "KKKK"
    cout << s3 << endl;

    string s4("12345", 1,
              3);  // s4 = "234"，即 "12345" 的从下标 1 开始，长度为 3 的子串
    cout << s4 << endl;
  }
  cout << "--------------------------" << endl;
  {
    string s1("12345"), s2, s3;
    s3.assign(s1);             // s3 = s1
    s2.assign(s1, 1, 2);       // s2 = "23"，即 s1 的子串(1, 2)
    s2.assign(4, 'K');         // s2 = "KKKK"
    s2.assign("abcde", 2, 3);  // s2 = "cde"，即 "abcde" 的子串(2, 3)
  }

  cout << "--------------------------" << endl;
  {
    string s1("123"), s2("abc");
    s1.append(s2);        // s1 = "123abc"
    s1.append(s2, 1, 2);  // s1 = "123abcbc"
    s1.append(3, 'K');    // s1 = "123abcbcKKK"
    s1.append("ABCDE", 2,
              3);  // s1 = "123abcbcKKKCDE"，添加 "ABCDE" 的子串(2, 3)
  }
  cout << "--------------------------" << endl;
  {
    /*
小于 0 表示当前的字符串小；
等于 0 表示两个字符串相等；
大于 0 表示另一个字符串小
    */
    string s1("hello"), s2("hello, world");
    int n = s1.compare(s2);
    n = s1.compare(1, 2, s2, 0, 3);  //比较s1的子串 (1,2) 和s2的子串 (0,3)
    n = s1.compare(0, 2, s2);        // 比较s1的子串 (0,2) 和 s2
    n = s1.compare("Hello");
    n = s1.compare(1, 2, "Hello");  //比较 s1 的子串(1,2)和"Hello”
    n = s1.compare(1, 2, "Hello", 1,
                   2);  //比较 s1 的子串(1,2)和 "Hello" 的子串(1,2)
  }
  {
    string s1 = "this is ok";
    string s2 = s1.substr(2, 4);  // s2 = "is i"
    s2 = s1.substr(2);            // s2 = "is is ok"
  }
  {
    string s1("West"), s2("East");
    s1.swap(s2);  // s1 = "East"，s2 = "West"
  }
}