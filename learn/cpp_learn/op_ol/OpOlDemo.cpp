#include <cmath>
#include <iostream>

using namespace std;
// 复数
class Complex
{
public:
    Complex();
    Complex(double real, double imag);

public:
    //以全局函数的形式重载
    friend Complex operator+(const Complex &c1, const Complex &c2);
    friend Complex operator-(const Complex &c1, const Complex &c2);
    friend Complex operator*(const Complex &c1, const Complex &c2);
    friend Complex operator/(const Complex &c1, const Complex &c2);
    friend bool operator==(const Complex &c1, const Complex &c2);
    friend bool operator!=(const Complex &c1, const Complex &c2);
    friend istream &operator>>(istream &in, Complex &c);  // 重载输入运算符>>
    friend ostream &operator<<(ostream &out, Complex &c); // 重载输入运算符<<

    //以成员函数的形式重载
    Complex &operator+=(const Complex &c);
    Complex &operator-=(const Complex &c);
    Complex &operator*=(const Complex &c);
    Complex &operator/=(const Complex &c);

    double real() const { return m_real; }
    double imag() const { return m_imag; }
    void display() const;

private:
    double m_real; //实部
    double m_imag; //虚部
};
Complex::Complex() : m_real(0.0), m_imag(0.0) {}
Complex::Complex(double real, double imag) : m_real(real), m_imag(imag) {}

// 重载+ 运算符
Complex operator+(const Complex &c1, const Complex &c2)
{
    return Complex(c1.m_real + c2.m_real,
                   c1.m_imag + c2.m_imag);
}
//重载-运算符
Complex operator-(const Complex &c1, const Complex &c2)
{
    return Complex(c1.m_real - c2.m_real,
                   c1.m_imag - c2.m_imag);
}

//重载*运算符  (a+bi) * (c+di) = (ac-bd) + (bc+ad)i
Complex operator*(const Complex &c1, const Complex &c2)
{
    return Complex(c1.m_real * c2.m_real - c1.m_imag * c2.m_imag,
                   c1.m_imag * c2.m_real + c1.m_real * c2.m_imag);
}
//重载/运算符  (a+bi) / (c+di) = [(ac+bd) / (c²+d²)] + [(bc-ad) / (c²+d²)]i
Complex operator/(const Complex &c1, const Complex &c2)
{
    Complex c;
    c.m_real = (c1.m_real * c2.m_real + c1.m_imag * c2.m_imag) / (pow(c2.m_real, 2) + pow(c2.m_imag, 2));
    c.m_imag = (c1.m_imag * c2.m_real - c1.m_real * c2.m_imag) / (pow(c2.m_real, 2) + pow(c2.m_imag, 2));
    return c;
}
//重载==运算符
bool operator==(const Complex &c1, const Complex &c2)
{
    return c1.m_real == c2.m_real && c1.m_imag == c2.m_imag;
}

//重载!=运算符
bool operator!=(const Complex &c1, const Complex &c2)
{
    return c1.m_real != c2.m_real || c1.m_imag != c2.m_imag;
}

// 重载输入运算符>>
istream &operator>>(istream &in, Complex &c)
{
    in >> c.m_real >> c.m_imag;
    return in;
}
// 重载输入运算符<<
ostream &operator<<(ostream &out, Complex &c)
{
    out << c.m_real << " + " << c.m_imag << "i";
    return out;
}

//重载+=运算符
Complex &Complex::operator+=(const Complex &c)
{
    this->m_real += c.m_real;
    this->m_imag += c.m_imag;
    return *this;
}
//重载-=运算符
Complex &Complex::operator-=(const Complex &c)
{
    this->m_real -= c.m_real;
    this->m_imag -= c.m_imag;
    return *this;
}
//重载*=运算符
Complex &Complex::operator*=(const Complex &c)
{
    this->m_real = this->m_real * c.m_real - this->m_imag * c.m_imag;
    this->m_imag = this->m_imag * c.m_real + this->m_real * c.m_imag;
    return *this;
}
//重载/=运算符
Complex &Complex::operator/=(const Complex &c)
{
    this->m_real = (this->m_real * c.m_real + this->m_imag * c.m_imag) / (pow(c.m_real, 2) + pow(c.m_imag, 2));
    this->m_imag = (this->m_imag * c.m_real - this->m_real * c.m_imag) / (pow(c.m_real, 2) + pow(c.m_imag, 2));
    return *this;
}

void Complex::display() const
{
    cout << m_real << " + " << m_imag << "i" << endl;
}

int main()
{
    Complex c1(25, 35);
    Complex c2(10, 20);
    Complex c3(1, 2);
    Complex c4(4, 9);
    Complex c5(34, 6);
    Complex c6(80, 90);

    Complex c7 = c1 + c2;
    Complex c8 = c1 - c2;
    Complex c9 = c1 * c2;
    Complex c10 = c1 / c2;
    cout << "c7 = " << c7 << endl;
    cout << "c8 = " << c8 << endl;
    cout << "c9 = " << c9 << endl;
    cout << "c10 = " << c10 << endl;

    c3 += c1;
    c4 -= c2;
    c5 *= c2;
    c6 /= c2;
    cout << "c3 = " << c3 << endl;

    cout << "c4 = " << c4 << endl;
    cout << "c5 = " << c5 << endl;
    cout << "c6 = " << c6 << endl;

    if (c1 == c2)
    {
        cout << "c1 == c2" << endl;
    }
    if (c1 != c2)
    {
        cout << "c1 != c2" << endl;
    }

    cout << "----------------------" << endl;
    cout << "input complex:" << endl;
    Complex ci1, ci2, ci3;
    cin >> ci1 >> ci2;
    ci3 = ci1 + ci2;
    cout << "ci1 + ci2 = " << ci3 << endl;
    return 0;
}