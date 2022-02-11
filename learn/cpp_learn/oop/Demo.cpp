#include <iostream>
using namespace std;
class Demo
{
private:
    int m_a;
    int m_b;

public:
    Demo(int b);
    void show();
};
// 注意，成员变量的初始化顺序与初始化列表中列出的变量的顺序无关，它只与成员变量在类中声明的顺序有关
Demo::Demo(int b) : m_b(b), m_a(m_b) {}
void Demo::show() { cout << m_a << ", " << m_b << endl; }

class VLA
{
private:
    const int m_len; //数组长度
    int *m_arr;      //数组指针
    int *m_p;        //指向数组第i个元素的指针
private:
    int *at(int i); //获取第i个元素的指针

public:
    VLA(int len);
    ~VLA(); //析构函数

public:
    void input(); //从控制台输入数组元素
    void show();
};

//const 成员变量的唯一方法就是使用初始化列表
VLA::VLA(int len) : m_len(len)
{
    if (len > 0)
    {
        m_arr = new int[len]; /*分配内存*/
    }
    else
    {
        m_arr = NULL;
    }
}
VLA::~VLA()
{
    delete[] m_arr; //释放内存
    cout << "call ~VLA" << endl;
}

void VLA::input()
{
    for (int i = 0; m_p = at(i); i++)
    {
        cin >> *at(i);
    }
}

void VLA::show()
{
    for (int i = 0; m_p = at(i); i++)
    {
        if (i == m_len - 1)
        {
            cout << *at(i) << endl;
        }
        else
        {
            cout << *at(i) << ", ";
        }
    }
}

int *VLA::at(int i)
{
    if (!m_arr || i < 0 || i >= m_len)
    {
        return NULL;
    }
    else
    {
        return m_arr + i;
    }
}

int main()
{
    Demo obj(100);
    obj.show();

    //创建一个有n个元素的数组（对象）
    int n;
    cout << "Input array length: ";
    cin >> n;
    VLA *parr = new VLA(n);
    //输入数组元素
    cout << "Input " << n << " numbers: ";
    parr->input();
    //输出数组元素
    cout << "Elements: ";
    parr->show();
    //删除数组（对象）
    delete parr;

    return 0;
}