#include <iostream>
#include <map>
#include <string>

using namespace std;

class CStudent {
 public:
  struct CInfo {
    int id;
    string name;
  };
  int score;
  CInfo info;
};

typedef multimap<int, CStudent::CInfo> MAP_STD;

int main() {
  MAP_STD mp;
  CStudent st;
  string cmd;
  while (cin >> cmd) {
    if (cmd == "Add") {
      cin >> st.info.name >> st.info.id >> st.score;
      mp.insert(MAP_STD::value_type(st.score, st.info));
    } else if (cmd == "Query") {
      int score;
      cin >> score;
      MAP_STD::iterator p = mp.lower_bound(score);
      if (p != mp.begin()) {
        --p;
        score = p->first;  //比要查询分数低的最高分
        MAP_STD::iterator maxp = p;
        int maxId = p->second.id;
        for (; p != mp.begin() && p->first == score; --p) {
          //遍历所有成绩和score相等的学生
          if (p->second.id > maxId) {
            maxp = p;
            maxId = p->second.id;
          }
        }
        if (p->first == score) {  //如果上面的循环因为 p == mp.begin()
                                  //而终止，则p指向的元素还要处理
          if (p->second.id > maxId) {
            maxp = p;
            maxId = p->second.id;
          }
        }
        cout << maxp->second.name << " " << maxp->second.id << " "
             << maxp->first << endl;
      } else  // lower_bound 的结果就是 begin，说明没有分数比查询分数低
        cout << "Nobody" << endl;
    }
  }
}

/*
multimap 及 map 中的 find 和 count
不用==运算符比较两个关键字是否相等。如果 x<y && y<x 时为假，就认为 x 和 y
相等

iterator find( const Key & val);	在容器中查找关键字等于 val
的元素，返回其迭代器；如果找不到，返回 end()

iterator insert (pair <Key, T> const &p);	将 pair 对象 p
插入容器中并返回其迭代器

void insert(iterator first, iterator last);	将区间 [first, last) 插入容器

int count( const Key & val);	统计有多少个元素的关键字和 val 相等

iterator lower_bound( const Key & val);	查找一个最大的位置 it，使得
[begin( ), it) 中所有的元素的关键字都比 val 小

iterator upper_bound(const Key & val);	查找一个最小的位置 it，使得 [it,
end()) 中所有的元素的关键字都比 val 大

pair < iterator, iterator > equal_range (const Key & val);	同时求得
lower_bound 和 upper_bound

iterator erase(iterator it);	删除 it
指向的元素，返回其后面的元素的迭代器（Visual Studio 2010 中如此，但是在 C++
标准和 Dev C++ 中，返回值不是这样）

iterator erase(iterator first, iterator last);	删除区间 [first,
last)，返回 last（Visual Studio 2010 中如此，但是在 C++ 标准和 Dev C++
中，返回值不是这样）
*/