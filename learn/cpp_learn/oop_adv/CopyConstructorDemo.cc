#include <iostream>
#include <string>

using namespace std;

class Student {
 public:
  Student(string name = "", int age = 0, float score = 0.0f)
      : m_name(name), m_age(age), m_score(score) {}  //普通构造函数
  //拷贝构造函数（声明）
  //拷贝构造函数只有一个参数，它的类型必须是当前类的引用，而且一般都是 const
  //引用
  Student(const Student &stu);

  //一个类可以同时存在两个拷贝构造函数，一个函数的参数为 const
  //引用，另一个函数的参数为非 const 引用
  //   Student(Student &stu);

 public:
  void display();

 private:
  string m_name;
  int m_age;
  float m_score;
};

//拷贝构造函数（定义）
Student::Student(const Student &stu) {
  this->m_name = stu.m_name;
  this->m_age = stu.m_age;
  this->m_score = stu.m_score;

  cout << "Copy constructor was called." << endl;
}

void Student::display() {
  cout << m_name << "的年龄是" << m_age << "，成绩是" << m_score << endl;
}

int main() {
  //如果程序员没有显式地定义拷贝构造函数，那么编译器会自动生成一个默认的拷贝构造函数。
  //这个默认的拷贝构造函数很简单，就是使用“老对象”的成员变量对“新对象”的成员变量进行一一赋值，和上面
  // Student 类的拷贝构造函数非常类似
  
  Student stu1("小明", 16, 90.5);
  Student stu2 = stu1;  //调用拷贝构造函数
  Student stu3(stu1);   //调用拷贝构造函数
  stu1.display();
  stu2.display();
  stu3.display();

  return 0;
}