#include <iostream>
using namespace std;
/*
友元的关系是单向的而不是双向的。如果声明了类 B 是类 A 的友元类，不等于类 A 是类 B 的友元类，类 A 中的成员函数不能访问类 B 中的 private 成员。

友元的关系不能传递。如果类 B 是类 A 的友元类，类 C 是类 B 的友元类，不等于类 C 是类 A 的友元类。
*/
class Address; //提前声明Address类

//声明Student类
class Student
{
public:
    Student(char *name, int age, float score);

public:
    void show(Address *addr);

private:
    char *m_name;
    int m_age;
    float m_score;
};
//声明Address类
class Address
{
private:
    char *m_province; //省份
    char *m_city;     //城市
    char *m_district; //区（市区）
public:
    Address(char *province, char *city, char *district);
    //将Student类中的成员函数show()声明为友元函数, 
    // friend void Student::show(Address *addr);
    friend class Student; //   Student 可以访问address内部所有函数
};
//实现Student类
Student::Student(char *name, int age, float score) : m_name(name), m_age(age), m_score(score) {}

void Student::show(Address *addr)
{   // 可以访问addr中的private成员
    cout << m_name << "的年龄是 " << m_age << "，成绩是 " << m_score << endl;
    cout << "家庭住址：" << addr->m_province << "省" << addr->m_city << "市" << addr->m_district << "区" << endl;
}
//实现Address类
Address::Address(char *province, char *city, char *district)
{
    m_province = province;
    m_city = city;
    m_district = district;
}
int main()
{
    Student stu("小明", 16, 95.5f);
    Address addr("陕西", "西安", "雁塔");
    stu.show(&addr);

    Student *pstu = new Student("李磊", 16, 80.5);
    Address *paddr = new Address("河北", "衡水", "桃城");
    pstu->show(paddr);

    return 0;
}