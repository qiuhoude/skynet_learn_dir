#include <iostream>
#include <set>

using namespace std;

template <typename T>
void Print(T first, T last) {
  for (; first != last; ++first) cout << *first << " ";
  cout << endl;
}
class A {
 private:
  int n;

 public:
  A(int n_) { n = n_; }

 public:
  friend bool operator<(const A& a1, const A& a2) { return a1.n < a2.n; }
  friend ostream& operator<<(ostream& o, const A& a2) {
    o << a2.n;
    return o;
  }
  friend class MyLess;
};

class MyLess : public binary_function<_Tp, _Tp, bool> {
 public:
  bool operator()(const A& a1, const A& a2)  //按个位数比较大小
  {
    return (a1.n % 10) < (a2.n % 10);
  }
};
typedef multiset<A> MSET1;          // MSET1 用“<”运算符比较大小
typedef multiset<A, MyLess> MSET2;  // MSET2 用 MyLess::operator() 比较大小
int main() {
  const int SIZE = 6;
  A a[SIZE] = {4, 22, 19, 8, 33, 40};
  MSET1 m1;
  m1.insert(a, a + SIZE);
  m1.insert(22);
  cout << "1)" << m1.count(22) << endl;  //输出 1)2

  cout << "2)";
  Print(m1.begin(), m1.end());  //输出 2)4 8 19 22 22 33 40

  MSET1::iterator pp = m1.find(19);
  if (pp != m1.end())         //条件为真说明找到
    cout << "found" << endl;  //本行会被执行，输出 found

  cout << "3)";
  cout << *m1.lower_bound(22) << "," << *m1.upper_bound(22)
       << endl;  //输出 3)22,33

  // pp = m1.erase(m1.lower_bound(22), m1.upper_bound(22)); // unix编译出错
  m1.erase(m1.lower_bound(22), m1.upper_bound(22));
  //   // pp指向被删元素的下一个元素
  cout << "4)";

  Print(m1.begin(), m1.end());  //输出 4)4 8 19 33 40
  cout << "5)";
  cout << *pp << endl;  //输出 5)33

  MSET2 m2;  // m2中的元素按n的个位数从小到大排序
  m2.insert(a, a + SIZE);
  cout << "6)";
  Print(m2.begin(), m2.end());  //输出 6)40 22 33 4 8 19
  return 0;
}

/*

不能直接修改 multiset
容器中元素的值。因为元素被修改后，容器并不会自动重新调整顺序，于是容器的有序性就会被破坏，再在其上进行查找等操作就会得到错误的结果。因此，如果要修改
multiset 容器中某个元素的值，正确的做法是先删除该元素，再插入新元素。 iterator

find (const T & val);	在容器中查找值为 val
的元素，返回其迭代器。如果找不到，返 回 end()

iterator insert( const T & val);	将 val 插入容器中并返回其迭代器

void insert(iterator first, iterator last);	将区间 [first, last)
中的元素插人容器

int count( const T & val);	统计有多少个元素的值和 val 相等

iterator lower_bound( const T & val);	查找一个最大的位置 it，使得 [begin(),
it) 中所有的元素者比 val 小

iterator upper_bound( const T & val);	查找一个最小的位置 it，使得 [it, end())
中所有的元素都比 val 大

pair <iterator, iterator > equal_range (const T & val);	同时求得 lower_bound 和
upper_bound

iterator erase(iterator it);	删除 it
指向的元素，返回其后面的元素的迭代器（Visual Studio 2010 中如此，但是在 C++
标准和 Dev C++ 中，返回值不是这样）

iterator erase(iterator first, iterator last);	删除区间 [first, last)，返回
last（Visual Studio 2010 中如此，但是在 C++ 标准和 Dev C++ 中，返回值不是这样）
*/