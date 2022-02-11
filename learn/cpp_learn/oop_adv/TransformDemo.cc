

#include <iostream>
#include <cstdlib>

using namespace std;

class Complex {
 public:
  Complex(double real = 0.0, double imag = 0.0) : m_real(real), m_imag(imag) {}

 public:
  operator double() const { return m_real; }  //类型转换函数
 private:
  double m_real;
  double m_imag;
};

class A {
 private:
  int m_a;
  int m_b;

 public:
  A(int a = 0, int b = 0) : m_a(a), m_b(b) {}
  ~A();
};

class Base {
 private:
  int m_a;

 public:
  Base(int a = 0) : m_a(a) {}
  int get_a() const { return m_a; }
  virtual void func() const {}  // 虚方法
};
class Derived : public Base {
 public:
  Derived(int a = 0, int b = 0) : Base(a), m_b(b) {}
  int get_b() const { return m_b; }

 private:
  int m_b;
};

int main() {
  // 1. static_cast	用于良性转换，一般不会导致意外发生，风险很低。
  // 2. const_cast	用于 const 与非 const、volatile 与非 volatile
  // 之间的转换。
  // 3. reinterpret_cast
  // 高度危险的转换，这种转换仅仅是对二进制位的重新解释，不会借助已有的转换规则对数据进行调整，但是可以实现最灵活的C++
  // 类型转换。
  // 4. dynamic_cast	借助RTTI，用于类型安全的向下转型（Downcasting）。

  cout << "----------static_cast ------------" << endl;
  {
    // static_cast
    // 是“静态转换”的意思，也就是在编译期间转换，转换失败的话会抛出一个编译错误。
    //下面是正确的用法
    int m = 100;
    Complex c(12.5, 23.8);
    long n = static_cast<long>(m);  //宽转换，没有信息丢失
    cout << "n: " << n << endl;

    char ch = static_cast<char>(m);  //窄转换，可能会丢失信息
    cout << "ch: " << ch << endl;

    int *p1 = static_cast<int *>(
        malloc(10 * sizeof(int)));  //将void指针转换为具体类型指针
    cout << "p1: " << p1 << endl;

    void *p2 = static_cast<void *>(p1);  //将具体类型指针，转换为void指针
    cout << "p2: " << p2 << endl;

    double real = static_cast<double>(c);  //调用类型转换函数
    cout << "real: " << real << endl;
  }
  //下面的用法是错误的
  //  float *p3 = static_cast<float *>(p1); 不能在两个具体类型的指针之间进行转换
  //  p3 = static_cast<float *>(0X2DF9);  不能将整数转换为指针类型

  cout << "----------const_cast ------------" << endl;
  {
    // const_cast 比较好理解，它用来去掉表达式的 const 修饰或 volatile
    // 修饰。换句话说，const_cast 就是用来将 const/volatile 类型转换为非
    // const/volatile 类型。
    const int m = 100;
    int *mp = const_cast<int *>(&m);
    *mp = 234;
    cout << "m = " << m << endl;
    cout << "*mp = " << *mp << endl;
  }
  cout << "----------reinterpret_cast  ------------" << endl;
  {
    // reinterpret 是“重新解释”的意思，顾名思义，reinterpret_cast
    // 这种转换仅仅是对二进制位的重新解释，不会借助已有的转换规则对数据进行调整，非常简单粗暴，所以风险很高。
    //将 char* 转换为 float*
    char str[] = "http://c.biancheng.net";
    float *p1 = reinterpret_cast<float *>(str);
    cout << "*p1 = " << *p1 << endl;
    //将 int 转换为 int*
    int *p = reinterpret_cast<int *>(100);
    // cout << *p << endl;
    //将 A* 转换为 int*
    p = reinterpret_cast<int *>(new A(25, 96));
    cout << "*p = " << *p << endl;  //的到 *p=25, 应为 A* 转 int*
                                    //,第一个private是int m_a,所以是 25
  }

  cout << "----------dynamic_cast ------------" << endl;
  {
    // dynamic_cast
    // 用于在类的继承层次之间进行类型转换，它既允许向上转型（Upcasting），也允许向下转型（Downcasting）。
    // 向上转型是无条件的，不会进行任何检测，所以都能成功；向下转型的前提必须是安全的，要借助
    // RTTI 进行检测，所有只有一部分能成功。
    Derived *pd1 = new Derived(35, 78);
    Base *pb1 = dynamic_cast<Derived *>(pd1);  // 转换成功 Base必须要有虚方法
    cout << "pd1 = " << pd1 << endl;
    cout << "pb1->get_a() = " << pb1->get_a() << endl;
    pb1->func();  
    delete pd1;

    int n = 100;
    Derived *pd2 = reinterpret_cast<Derived *>(&n);
    Base *pb2 = dynamic_cast<Base *>(pd2);
    cout << "pd2 = " << pd2 << endl;
    // cout << pb2->get_a() << endl;  //内存错误 
    // pb2->func();                   //内存错误
  }
  return 0;
}
