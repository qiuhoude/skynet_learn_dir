
#include <iostream>
#include <algorithm>
using namespace std;

/*
编译是需要加 -std=c++11
g++ -std=c++11
[外部变量访问方式说明符] (参数表) -> 返回值类型
{
   语句块
}
“外部变量访问方式说明符”可以是=或&
*/

static void demo1() {
  int a[4] = {1, 2, 3, 4};
  int total = 0;
  // [&]表示该 Lambda 表达式中用到的外部变量 total
  // 是传引用的，其值可以在表达式执行过程中被改变（如果使用[=]，编译无法通过）
  for_each(a, a + 4, [&](int& x) {
    total += x;
    x *= 2;
  });
  cout << total << endl;  //输出 10
  for_each(a, a + 4, [=](int x) { cout << x << " "; });
  cout << endl;
}

static void demo2() {
  int x = 100, y = 200, z = 300;
  auto ff = [=, &y, &z](int n) { // 访问外部变量 x y
    cout << x << endl;
    y++;
    z++;
    return n * n;
  };
  cout << ff(15) << endl;
  cout << y << "," << z << endl;
}

int main() {
  //   demo1();
    demo2();

  return 0;
}