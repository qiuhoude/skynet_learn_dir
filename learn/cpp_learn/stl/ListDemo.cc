#include <iostream>
#include <list>
#include <algorithm>
#include <typeinfo>

using namespace std;

/*
STL 中的算法 sort 可以用来对 vector 和 deque 排序,list非随机访问不能使用

void push_front(const T & val)	将 val 插入链表最前面
void pop_front()	删除链表最前面的元素
void sort()	将链表从小到大排序
void remove (const T & val)	删除和 val 相等的元素
remove_if	删除符合某种条件的元素
void unique()	删除所有和前一个元素相等的元素
void merge(list <T> & x)	将链表 x 合并进来并清空 x。要求链表自身和 x
都是有序的 void splice(iterator i, list <T> & x, iterator first, iterator last)
在位置 i 前面插入链表 x 中的区间 [first, last)，并在链表 x
中删除该区间。链表自身和链表 x 可以是同一个链表，只要 i 不在 [first, last)
中即可
*/

class Human {
 private:
  int m_age;

 public:
  Human(int age) : m_age(age){};
  friend bool operator<(const Human& h1, const Human& h2);
  friend bool operator==(const Human& h1, const Human& h2);
  friend ostream& operator<<(ostream& o, const Human& h);
};

bool operator<(const Human& h1, const Human& h2) { return h1.m_age < h2.m_age; }

bool operator==(const Human& h1, const Human& h2) {
  return h1.m_age == h2.m_age;
}

ostream& operator<<(ostream& o, const Human& h) {
  //   o << "h(age=" << h.m_age << ") ";
  o << h.m_age;
  return o;
}

template <typename T>
void Print(T f, T l) {
  for (; f != l; f++) {
    cout << *f << " ";
  }
  cout << endl;
}

static void test1() {
  Human a[5] = {1, 3, 2, 4, 2};
  Human b[7] = {10, 30, 20, 30, 30, 40, 40};
  list<Human> lst1(a, a + 5), lst2(b, b + 7);
  lst1.sort();
  cout << "1)";
  Print(lst1.begin(), lst1.end());  //输出：1)1 2 2 3 4

  lst1.remove(2);  //删除所有和A(2)相等的元素
  cout << "2)";
  Print(lst1.begin(), lst1.end());  //输出：2)1 3 4

  lst2.pop_front();  //删除第一个元素
  cout << "3)";
  Print(lst2.begin(), lst2.end());  //输出：3)30 20 30 30 40 40

  lst2.unique();  //删除所有和前一个元素相等的元素
  cout << "4)";
  Print(lst2.begin(), lst2.end());  //输出：4)30 20 30 40

  lst2.sort();
  lst1.merge(lst2);  //合并 lst2 到 lst1 并清空 lst2
  cout << "5)";
  Print(lst1.begin(), lst1.end());  //输出：5)1 3 4 20 30 30 40

  cout << "6)";
  Print(lst2.begin(), lst2.end());  // lst2是空的，输出：6)

  lst1.reverse();  //将 lst1 前后颠倒
  cout << "7)";
  Print(lst1.begin(), lst1.end());  //输出 7)40 30 30 20 4 3 1

  lst2.insert(lst2.begin(), a + 1, a + 4);  //在 lst2 中插入 3,2,4 三个元素
  list<Human>::iterator p1, p2, p3;
  p1 = find(lst1.begin(), lst1.end(), 30);
  p2 = find(lst2.begin(), lst2.end(), 2);
  p3 = find(lst2.begin(), lst2.end(), 4);
  lst1.splice(p1, lst2, p2,
              p3);  //将[p2, p3)插入p1之前，并从 lst2 中删除[p2,p3)

  cout << "8)";
  Print(lst1.begin(), lst1.end());  //输出：8)40 2 30 30 20 4 3 1

  cout << "9)";
  Print(lst2.begin(), lst2.end());  //输出：9)3 4
}

static void tese2MonkeyKingGame() {
  list<int> monkeys;
  int n, m;
  while (true) {
    cout << "input n m:" << endl;
    cin >> n >> m;
    if (n == 0 && m == 0) {
      break;
    }
    monkeys.clear();
    for (int i = 1; i <= n; i++) {
      monkeys.push_back(i);
    }
    list<int>::iterator it = monkeys.begin();
    while (monkeys.size() > 1) {  // 最后一个是王
      for (int i = 1; i < m; i++) {
        it++;  // 报数
        if (it == monkeys.end()) {
          it = monkeys.begin();
        }
      }
      it = monkeys.erase(it);  //删除元素后，迭代器失效，
                               //要重新让迭代器指向被删元素的后面
      if (it == monkeys.end()) {
        it = monkeys.begin();
      }
    }
    cout << monkeys.front() << endl;  // front返回第一个元素的引用
  }
}

int main() {
  // test1();
  tese2MonkeyKingGame();
}