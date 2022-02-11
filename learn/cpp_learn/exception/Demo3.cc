#include <exception>
#include <iostream>
#include <string>
using namespace std;

class Base {};
class Derived : public Base {};

static void test1() {
  try {
    throw Derived();  //抛出自己的异常类型，实际上是创建一个Derived类型的匿
    cout << "This statement will not be executed." << endl;
  } catch (int) {
    cout << "Exception type: int" << endl;
  } catch (char *) {
    cout << "Exception type: cahr *" << endl;
  } catch (Base) {  //匹配成功（向上转型）
    cout << "Exception type: Base" << endl;
  } catch (Derived) {
    cout << "Exception type: Derived" << endl;
  }
}
/*
算数转换：例如 int 转换为 float，char 转换为 int，double 转换为 int 等。

向上转型：也就是派生类向基类的转换，请猛击《C++向上转型（将派生类赋值给基类）》了解详情。

const 转换：也即将非 const 类型转换为 const 类型，例如将 char * 转换为 const
char *。

数组或函数指针转换：如果函数形参不是引用类型，那么数组名会转换为数组指针，函数名也会转换为函数指针。

用户自定的类型转换。
*/

static void test2() {
  int nums[] = {1, 3, 4};
  try {
    throw nums;  // 应该是 匹配 int [3]
    cout << "This statement will not be executed." << endl;
  } catch (int[2]) {
    cout << "Exception type: int[2] " << endl;
  } catch (const int *e2) {
    cout << "Exception type: const int * : e = " << e2 << endl;
  }
}

int main() {
  test1();
  test2();

  return 0;
}