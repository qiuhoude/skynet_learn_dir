
#include <vector>
#include <algorithm>
#include <iostream>
using namespace std;

/*
可以改变容器
copy：将一个容器的内容复制到另一个容器。
remove：在容器中删除一个元素。
random_shuffle：随机打乱容器中的元素。
fill：用某个值填充容器。

// 不改变容器本身
find：在容器中查找元素。
count_if：统计容器中符合某种条件的元素的个数

*/

int main() {
  int a[10] = {10, 20, 30, 40};
  vector<int> v;
  v.push_back(1);
  v.push_back(2);
  v.push_back(3);
  v.push_back(4);  //此后v里放着4个元素：1,2,3,4
  vector<int>::iterator p = find(v.begin(), v.end(), 3);  //在v中查找3
  if (p != v.end())               //若找不到,find返回 v.end()
    cout << "1) " << *p << endl;  //找到了

  p = find(v.begin(), v.end(), 9);
  if (p == v.end()) cout << "not found " << endl;  //没找到

  p = find(v.begin() + 1, v.end() - 1, 4);  //在,3 这两个元素中查找4
  cout << "2) " << *p << endl;

  int* pp = find(a, a + 4, 20);  //  [a, a+4)
  if (pp == a + 4)
    cout << "not found" << endl;
  else
    cout << "3) " << *pp << endl;
}