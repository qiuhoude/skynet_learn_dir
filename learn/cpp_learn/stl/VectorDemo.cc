#include <iostream>
#include <vector>
#include <algorithm>
#include <typeinfo>
#include <stddef.h>

using namespace std;

/*
vector()	无参构造函数，将容器初始化为空
vector(int n)	将容器初始化为有 n 个元素
vector(int n, const T & val)	假定元素的类型是 T，此构造函数将容器初始化为有 n
个元素，每 个元素的值都是 val vector(iterator first, iterator last)	first 和
last 可以是其他容器的迭代器。一般来说，本构造函数初始化的结果就是将 vector
容器的内容变成与其他容器上的区间 [first, last) —致 void clear()	删除所有元素
bool empty()	判断容器是否为空
void pop_back()	删除容器末尾的元素
void push_back( const T & val)	将 val 添加到容器末尾
int size()	返回容器中元素的个数
T & front()	返回容器中第一个元素的引用
T & back()	返回容器中最后一个元素的引用
iterator insert(iterator i, const T & val)	将 val 插入迭代器 i
指向的位置，返回 i iterator insert( iterator i, iterator first, iterator last)
将其他容器上的区间 [first, last) 中的元素插入迭代器 i 指向的位置 iterator
erase(iterator i)	删除迭代器 i
指向的元素，返回值是被删元素后面的元素的迭代器 iterator erase(iterator first,
iterator last)	删除容器中的区间 [first, last) void swap( vector <T> & v)
将容器自身的内容和另一个同类型的容器 v 互换
 */

#define COUNT_OF(x) \
  ((sizeof(x) / sizeof(0 [x])) / ((size_t)(!(sizeof(x) % sizeof(0 [x])))))

template <typename T>
void PrintVector(const vector<T>& v) {
  // typename 用来说明 vector <T>::const_iterator 是一个类型
  typename vector<T>::const_iterator it;
  for (it = v.begin(); it != v.end(); it++) {
    //  const type_info& nInfo = typeid(n);
    cout << *it << " ";
  }
  cout << endl;
}

void test1() {
  int arr[] = {1, 2, 3, 4, 5};
  vector<int> v(arr, arr + COUNT_OF(arr));  // 将arr放入v中
  cout << "1) " << v.end() - v.begin()
       << endl;  //两个随机迭代器可以相减，输出：1)5

  cout << "2)";
  PrintVector(v);  //输出：2)1 2 3 4 5

  v.insert(v.begin() + 2, 13);  //在 begin()+2 位置插人 13
  cout << "3)";
  PrintVector(v);  //输出：3)1 2 13 3 4 5

  v.erase(v.begin() + 2);  //删除位于 begin()+2 位置的元素
  cout << "4)";
  PrintVector(v);  //输出：4)1 2 3 4 5

  vector<int> v2(4, 100);  // v2 有 4 个元素，都是 100
  cout << "4.5)v2:";
  PrintVector(v2);
  v2.insert(v2.begin(), v.begin() + 1, v.begin() + 3);  //将v的一段插入v2开头

  cout << "5)v2:";
  PrintVector(v2);  //输出：5)v2:2 3 100 100 100 100

  v.erase(v.begin() + 1, v.begin() + 4);  //删除 v 上的一个区间，即 [2,4)

  cout << "6)";
  PrintVector(v);  //输出：6)1 5

  vector<int>* v3 = new vector<int>;
  for (size_t i = 0; i < 10; i++) {
    v3->push_back(i);
  }
  PrintVector(*v3);
  random_shuffle(v3->begin(), v3->end());
  PrintVector(*v3);
}

void test2() {
  vector<vector<int> > v(3);  // v有3个元素，每个元素都是vector<int> 容器
  for (int i = 0; i < v.size(); ++i)
    for (int j = 0; j < 4; ++j) v[i].push_back(j);

  for (int i = 0; i < v.size(); ++i) {
    //  for (int j = 0; j < v[i].size(); ++j) cout << v[i][j] << " ";
    //  cout << endl;
    PrintVector(v[i]);
  }
}
int main() {
  test1();
  cout << "-------------" << endl;
  test2();
}
