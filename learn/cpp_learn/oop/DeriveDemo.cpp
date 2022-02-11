#include <iostream>
#include <string>
using namespace std;

//基类 Pelple
class People
{
public:
    void setname(string name);
    void setage(int age);
    string getname();
    int getage();
    void sethobby(string hobby);
    string gethobby();

protected:
    string m_name;
    int m_age;

private:
    string m_hobby;
};
void People::setname(string name) { m_name = name; }
void People::setage(int age) { m_age = age; }
void People::sethobby(string hobby) { m_hobby = hobby; }
string People::getname() { return m_name; }
int People::getage() { return m_age; }
string People::gethobby() { return m_hobby; }

//派生类 Student
// 继承方式包括 public（公有的）、private（私有的）和 protected（受保护的），
//此项是可选的，如果不写，那么默认为 private。我们将在下节详细讲解这些不同的继承方式。
class Student : public People
{
    //using 只能改变基类中 public 和 protected 成员的访问权限，不能改变 private 成员的访问权限
public:
    void setscore(float score);
    using People::m_name; // 提升m_name 为public

protected:
    float m_score;
};
void Student::setscore(float score) { m_score = score; }

//派生类Pupil
class Pupil : public Student
{
public:
    void setranking(int ranking);
    void display();

private:
    int m_ranking;
};

void Pupil::setranking(int ranking) { m_ranking = ranking; }
void Pupil::display()
{
    cout << m_name << "的年龄是" << m_age << "，考试成绩为" << m_score << "分，班级排名第" << m_ranking << "，TA喜欢" << gethobby() << "。" << endl;
}
int main()
{
    Pupil pup;
    pup.setname("小明");
    pup.setage(15);
    pup.setscore(92.5f);
    pup.setranking(4);
    pup.sethobby("乒乓球");
    pup.display();
    cout << pup.m_name << endl;
    return 0;
}