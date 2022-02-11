#include <iostream>

using namespace std;

template <typename T>
void Swap(T *const a, T *const b)
{
    T tmp = *a;
    *a = *b;
    *b = tmp;
}

template <typename T>
void Swap2(T &a, T &b)
{
    T tmp = a;
    a = b;
    b = tmp;
}

template <class T>
T max2(T a, T b)
{
    return a > b ? a : b;
}

template <typename T>
T max3(T a, T b, T c)
{
    return max2(max2(a, b), c);
}

static void test1()
{
    //交换 int 变量的值
    int n1 = 100, n2 = 200;
    Swap(&n1, &n2);
    cout << n1 << ", " << n2 << endl;

    //交换 float 变量的值
    float f1 = 12.5, f2 = 56.93;
    Swap(&f1, &f2);
    cout << f1 << ", " << f2 << endl;

    //交换 char 变量的值
    char c1 = 'A', c2 = 'B';
    Swap(&c1, &c2);
    cout << c1 << ", " << c2 << endl;

    //交换 bool 变量的值
    bool b1 = false, b2 = true;
    Swap(&b1, &b2);
    cout << b1 << ", " << b2 << endl;
}
static void test2()
{
    //交换 int 变量的值
    int n1 = 100, n2 = 200;
    Swap2(n1, n2);
    cout << n1 << ", " << n2 << endl;

    //交换 float 变量的值
    float f1 = 12.5, f2 = 56.93;
    Swap2(f1, f2);
    cout << f1 << ", " << f2 << endl;

    //交换 char 变量的值
    char c1 = 'A', c2 = 'B';
    Swap2(c1, c2);
    cout << c1 << ", " << c2 << endl;

    //交换 bool 变量的值
    bool b1 = false, b2 = true;
    Swap2(b1, b2);
    cout << b1 << ", " << b2 << endl;
}

static void test3()
{
    //求三个整数的最大值
    int i1, i2, i3, i_max;
    cin >> i1 >> i2 >> i3;
    i_max = max3(i1, i2, i3);
    cout << "i_max=" << i_max << endl;
    //求三个浮点数的最大值
    double d1, d2, d3, d_max;
    cin >> d1 >> d2 >> d3;
    d_max = max3(d1, d2, d3);
    cout << "d_max=" << d_max << endl;
    //求三个长整型数的最大值
    long g1, g2, g3, g_max;
    cin >> g1 >> g2 >> g3;
    g_max = max3(g1, g2, g3);
    cout << "g_max=" << g_max << endl;
}

int main()
{
    test1();
    cout << "----------------------------------" << endl;
    test2();
    cout << "----------------------------------" << endl;
    test3();

    return 0;
}