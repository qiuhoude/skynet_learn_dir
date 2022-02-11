#include <iostream>
using namespace std;
//虚基类A
class A
{
public:
    A(int a);

protected:
    int m_a;
};
A::A(int a) : m_a(a) {}
//直接派生类B
class B : virtual public A
{
public:
    B(int a, int b);

public:
    void display();

protected:
    int m_b;
};
B::B(int a, int b) : A(a), m_b(b) {}
void B::display()
{
    cout << "m_a=" << m_a << ", m_b=" << m_b << endl;
}
//直接派生类C
class C : virtual public A
{
public:
    C(int a, int c);

public:
    void display();

protected:
    int m_c;
};
C::C(int a, int c) : A(a), m_c(c) {}
void C::display()
{
    cout << "m_a=" << m_a << ", m_c=" << m_c << endl;
}
//间接派生类D
class D : public B, public C
{
public:
    D(int a, int b, int c, int d);

public:
    void display();

private:
    int m_d;
};
D::D(int a, int b, int c, int d) : B(90, b), C(100, c), A(a), m_d(d) {}
void D::display()
{
    cout << "m_a=" << m_a << ", m_b=" << m_b << ", m_c=" << m_c << ", m_d=" << m_d << endl;
}
int main()
{
    B b(10, 20);
    b.display();

    C c(30, 40);
    c.display();
    D d(50, 60, 70, 80);
    d.display();
    return 0;
}