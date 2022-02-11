#include <iostream>
#include <typeinfo>
using namespace std;

class Base
{
};

struct STU
{
};

int main()
{
    //获取一个普通变量的类型信息
    int n = 100;
    const type_info &nInfo = typeid(n);
    cout << nInfo.name() << endl;

    //获取一个字面量的类型信息
    const type_info &dInfo = typeid(25.65);
    cout << dInfo.name() << endl;

    //获取一个对象的类型信息
    Base obj;
    const type_info &objInfo = typeid(obj);
    cout << objInfo.name() << endl;

    //获取一个类的类型信息
    const type_info &baseInfo = typeid(Base);
    cout << baseInfo.name() << endl;

    //获取一个结构体的类型信息
    const type_info &stuInfo = typeid(struct STU);
    cout << stuInfo.name() << endl;

    //获取一个普通类型的类型信息
    const type_info &charInfo = typeid(char);
    cout << charInfo.name() << endl;

    //获取一个表达式的类型信息
    const type_info &expInfo = typeid(20 * 45 / 4.5);
    cout << expInfo.name() << endl;

    return 0;
}