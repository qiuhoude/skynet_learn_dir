#include <iostream>
#include <set>

using namespace std;

int main() {
  typedef set<int>::iterator IT;
  int a[5] = {3, 4, 6, 1, 2};  // st里是 1 2 3 4 6
  set<int> st(a, a + 5);
  pair<IT, bool> result = st.insert(5);  // st变成  1 2 3 4 5 6
  if (result.second) {                   //插入成功则输出被插入元素
    cout << *result.first << " inserted" << endl;  //输出: 5 inserted
  }
  if ((result = st.insert(5)).second)  // 继续插入5,将失败
    cout << *result.first << endl;
  else
    cout << *result.first << " already exists" << endl;

  pair<IT, IT> bounds = st.equal_range(4);  //同时查找上界和下界
  cout << *bounds.first << "," << *bounds.second;  //输出：4,5
  cout << endl;
  return (0);
}