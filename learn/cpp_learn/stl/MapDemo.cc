#include <iostream>
#include <map>

using namespace std;

template <class T1, class T2>
ostream& operator<<(
    ostream& o, const pair<T1, T2>& p) {  //将pair对象输出为 (first,second)形式
  o << "(" << p.first << "," << p.second << ")";
  return o;
}

template <class T>
void Print(T first, T last) {  //打印区间[first,last)
  for (; first != last; ++first) cout << *first << " ";
  cout << endl;
}

typedef map<int, double, greater<int> >  // 中间有空格
    MYMAP;  //此容器关键字是整型，元素按关键字从大到小排序

int main() {
  MYMAP mp;
  mp.insert(MYMAP::value_type(15, 2.7));

  pair<MYMAP::iterator, bool> p = mp.insert(make_pair(15, 99.3));
  if (!p.second) cout << *(p.first) << " already exists" << endl;  //会输出

  cout << "1) " << mp.count(15) << endl;  //输出 1) 1

  mp.insert(make_pair(20, 9.3));
  mp.insert(make_pair(40, 0));
  cout << "2) " << mp[40] << " , map.count() " << mp.count(40)
       << endl;  //如果没有关键字为40的元素，则插入一个

  cout << "3) ";
  Print(mp.begin(), mp.end());  //输出：3) (40,0)(20,9.3)(15,2.7)

  mp[15] = 6.28;  //把关键字为15的元素值改成6.28
  mp[17] = 3.14;  //插入关键字为17的元素，并将其值设为3.14

  cout << "4) ";
  Print(mp.begin(), mp.end());
  return 0;
}