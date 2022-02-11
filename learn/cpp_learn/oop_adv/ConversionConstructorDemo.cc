
#include <iostream>
using namespace std;
//复数类
class Complex {
 public:
  //   Complex() : m_real(0.0), m_imag(0.0) {}
  Complex(double real = 0.0, double imag = 0.0)
      : m_real(real), m_imag(imag) {}  // 精简构造
  //   Complex(double real) : m_real(real), m_imag(0.0) {  //转换构造函数
  //     cout << "conversion constructor call" << endl;
  //   }

 public:
  friend ostream &operator<<(ostream &out, Complex &c);  //友元函数
  friend Complex operator+(const Complex &c1, const Complex &c2);
  //   Complex &operator+(const Complex &c);
  operator double() const { return this->m_real; }  //类型转换函数

 private:
  double m_real;  //实部
  double m_imag;  //虚部
};
//全局的方式 重载>>运算符
ostream &operator<<(ostream &out, Complex &c) {
  out << c.m_real << " + " << c.m_imag << "i";
  return out;
}

// 重载+ 运算符
Complex operator+(const Complex &c1, const Complex &c2) {
  return Complex(c1.m_real + c2.m_real, c1.m_imag + c2.m_imag);
}

// Complex &Complex::operator+(const Complex &c) {
//   this->m_imag + c.m_imag;
//   this->m_real + c.m_real;
//   return *this;
// }

int main() {
  Complex a(10.0, 20.0);
  cout << a << endl;
  a = 25.5;  //调用转换构造函数
  cout << a << endl;
  Complex a2;
  a2 = Complex(29.6) + a;  // 只有全局的重载+ 才能数字在前，被隐式转换城 complex
  cout << a2 << endl;
  cout << "------------------------" << endl;

  Complex c1 = 100;  // int --> double --> Complex
  cout << c1 << endl;
  c1 = 'A';  // char --> int --> double --> Complex
  cout << c1 << endl;
  c1 = true;  // bool --> int --> double --> Complex
  cout << c1 << endl;
  Complex c2(25.8, 0.7);
  //已经重载了+运算符
  c1 = c2 + Complex('H') + Complex(true) +
       Complex(15);  //将char、bool、int都转换为Complex类型再运算
  cout << c1 << endl;

  double f = c1;  //相当于 double f = Complex::operator double(&c1);
  cout << "f = " << f << endl;

  return 0;
}