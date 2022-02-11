
#include <iostream>
#include <vector>
using namespace std;

/*

*/
int main() {
  vector<int> v(100);                 // v被初始化成有100个元素
  for (int i = 0; i < v.size(); ++i)  // size返回元素个数
    cout << v[i];                     //像普通数组一样使用vector容器
  vector<int>::iterator i;
  for (i = v.begin(); i != v.end(); ++i)  //用 != 比较两个迭代器
    cout << *i;
  for (i = v.begin(); i < v.end(); ++i)  //用 < 比较两个迭代器
    cout << *i;
  i = v.begin();

  while (i < v.end()) {  //间隔一个输出
    cout << *i;
    i += 2;  // 随机访问迭代器支持 "+= 整数"  的操作
  }
}