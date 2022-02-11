#include <iostream>
#include <stack>
using namespace std;

int main() {
  int n, k;
  stack<int> stk;

  cin >> n >> k;  //将n转换为k进制数
  if (n == 0) {
    cout << 0;
    return 0;
  }

  while (n) {
    stk.push(n % k);
    n /= k;
  }

  while (!stk.empty()) {
    cout << stk.top();
    stk.pop();
  }
  
  return 0;
}

/*
void pop();	弹出（即删除）栈顶元素

T & top();
返回栈顶元素的引用。通过此函数可以读取栈顶元素的值，也可以修改栈顶元素

void push(const T & x);	将 x 压入栈顶
*/