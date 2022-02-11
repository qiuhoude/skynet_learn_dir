#include <iostream>
using namespace std;
//基类Base
class Base
{
public:
    virtual void func();
    virtual void func(int);
};
void Base::func()
{
    cout << "void Base::func()" << endl;
}
void Base::func(int n)
{
    cout << "void Base::func(int)" << endl;
}
//派生类Derived
class Derived : public Base
{
public:
    void func();
    void func(char *);
};
void Derived::func()
{
    cout << "void Derived::func()" << endl;
}
void Derived::func(char *str)
{
    cout << "void Derived::func(char *)" << endl;
}
int main()
{
    Base *p = new Derived();
    p->func();                         //输出void Derived::func()
    p->func(10);                       //输出void Base::func(int)
    // p->func("http://c.biancheng.net"); //compile error
    return 0;
}