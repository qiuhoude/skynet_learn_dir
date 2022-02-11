#include <iostream>

using namespace std;

int main() {
  pair<int, double> p1;
  cout << p1.first << "," << p1.second << endl;  //输出  0,0

  pair<string, int> p2("this", 20);
  cout << p2.first << "," << p2.second << endl;  //输出  this,20

  pair<int, int> p3(pair<char, char>('a', 'b'));
  cout << p3.first << "," << p3.second << endl;  //输出  97,98

  pair<int, string> p4 = make_pair(200, "hello"); //make_pair 也可以创建
  cout << p4.first << "," << p4.second << endl;  //输出  200,hello

  return 0;
  
}