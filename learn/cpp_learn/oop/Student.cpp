#include <iostream>

using namespace std;

class Student
{
private:
    char *m_name;
    int m_age;
    float m_score;

public:
    /*static 成员变量的内存既不是在声明类时分配，
也不是在创建对象时分配，而是在（类外）初始化时分配。反过来说，没有在类外初始化的 static 成员变量不能使用。
*/
    static int m_total; //静态成员变量

public:
    char *name;
    int age;
    float score;
    void say()
    {
        cout << name << "的年龄是" << age << "，成绩是" << score << " m_total: " << m_total << endl;
    }
    Student();
    Student(char *name);
    ~Student();

    void setname(char *name);
    void setage(int age);
    void setscore(float score);
    void show();
};
Student::Student()
{
    m_total++;
}
//采用初始化列表 加上
Student::Student(char *name) : m_name(name)
{
    // this 是一个指针，要用->来访问成员变量或成员函数
    this->name = name;
    m_total++;
}

Student::~Student()
{
    cout << "销毁 " << name << endl;
    m_total--;
}

// 成员函数的定义
// 注意，成员变量的初始化顺序与初始化列表中列出的变量的顺序无关，它只与成员变量在类中声明的顺序有关
void Student::setname(char *name)
{
    m_name = name;
}
void Student::setage(int age)
{
    m_age = age;
}
void Student::setscore(float score)
{
    m_score = score;
}
void Student::show()
{
    cout << m_name << " show --------------的年龄是" << m_age << "，成绩是" << m_score << endl;
}
//必须初始化静态成员变量,可以不赋值
int Student::m_total;

int main()
{
    // 在函数内部创建的对象是局部对象，它和局部变量类似，位于栈区，函数执行结束时会调用这些对象的析构函数
    // stu再main结束时就会调解构函数
    Student stu;
    stu.age = 18;
    stu.name = "qiu";
    stu.score = 100;
    stu.say();

    Student *pStr = new Student("hihi");
    pStr->age = 30;
    pStr->score = 100;
    pStr->say();
    delete pStr;

    Student *pstu = new Student;
    pstu->setname("李华");
    pstu->setage(16);
    pstu->setscore(96);
    pstu->show();

    stu.say();
}