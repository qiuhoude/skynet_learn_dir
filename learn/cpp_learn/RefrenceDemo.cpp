#include <iostream>
using namespace std;

/*
引用必须在定义的同时初始化，并且以后也要从一而终，不能再引用其它数据，这有点类似于常量（const 变量）。
注意，引用在定义时需要添加&，在使用时不能添加&，使用时添加&表示取地址
*/

void swap1(int a, int b);
void swap2(int *p1, int *p2);
void swap3(int &r1, int &r2);

int &plus10(int &r) // 返回ref类型
{
    cout << "in :" << &r << endl;
    r += 10;
    cout << "out:" << &r << endl;
    return r;
}

int main()
{
    int a = 99;
    const int &r = a;
    // r = 47; // 加const 不能再次赋值
    cout << a << ", " << r << endl;
    cout << &a << ", " << &r << endl;
    cout << "=============================" << endl;

    // int num1, num2;
    // cout << "Input two integers swap1: ";
    // cin >> num1 >> num2;
    // swap1(num1, num2);
    // cout << num1 << " " << num2 << endl;
    // cout << "Input two integers swap2: ";
    // cin >> num1 >> num2;
    // swap2(&num1, &num2);
    // cout << num1 << " " << num2 << endl;
    // cout << "Input two integers swap3: ";
    // cin >> num1 >> num2;
    // swap3(num1, num2);
    // cout << num1 << " " << num2 << endl;

    cout << "=============================" << endl;

    int num1 = 10;
    int &num2 = plus10(num1); // 要用引用去接 ,如果用int 接num2的地址就会重新stack上申请
    cout << num1 << " " << num2 << endl;
    cout << &num1 << " " << &num2 << endl;
    num2 = 3;
    cout << num1 << " " << num2 << endl;
    return 0;
}

//直接传递参数内容
void swap1(int a, int b)
{
    int temp = a;
    a = b;
    b = temp;
}
//传递指针
void swap2(int *p1, int *p2)
{
    int temp = *p1;
    *p1 = *p2;
    *p2 = temp;
}
//按引用传参
void swap3(int &r1, int &r2)
{
    int temp = r1;
    r1 = r2;
    r2 = temp;
}