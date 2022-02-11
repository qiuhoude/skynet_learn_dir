#include <iostream>
#include <string>

using namespace std;

void appendTest()
{
    /*
    有了 string 类，我们可以使用+或+=运算符来直接拼接字符串，非常方便，
    再也不需要使用C语言中的 strcat()、strcpy()、malloc() 等函数来拼接字符串了，再也不用担心空间不够会溢出了。
    */
    string s1 = "first ";
    string s2 = "second ";
    char *s3 = "third ";
    char s4[] = "fourth ";
    char ch = '@';
    string s5 = s1 + s2;
    string s6 = s1 + s3;
    string s7 = s1 + s4;
    string s8 = s1 + ch;

    cout << s5 << endl
         << s6 << endl
         << s7 << endl
         << s8 << endl;
}

void lenTest()
{
    string s = "h你好t";

    // s.c_str() 调用c函数是需要转c风格才行
    cout << "s length: " << s.length() << endl;

    for (int i = 0, len = s.length(); i < len; i++)
    {
        cout << s[i] << " ";
    }
    cout << endl;
}

void inserTest()
{
    string s1, s2, s3;
    s1 = s2 = "1234567890";
    s3 = "aaa";
    s1.insert(5, s3);
    cout << s1 << endl;
    s2.insert(5, "bbb");
    cout << s2 << endl;
}

void eraseTest()
{
    string s1, s2, s3;
    s1 = s2 = s3 = "1234567890";
    s2.erase(5);
    s3.erase(5, 3); // pos 表示要删除的子字符串的起始下标，len 表示要删除子字符串的长度
    cout << s1 << endl;
    cout << s2 << endl;
    cout << s3 << endl;
}

void substrTest()
{
    string s1 = "first second third";
    string s2;
    s2 = s1.substr(6, 6);
    cout << s1 << endl;
    cout << s2 << endl;
}

void findTest()
{
    string s1 = "first second third";
    string s2 = "second";
    int index = s1.find(s2, 1);

    if (index < s1.length())
        cout << "Found at index : " << index << endl;
    else
        cout << "Not found" << endl;

    // rfind() 函数则最多查找到第二个参数处，如果到了第二个参数所指定的下标还没有找到子字符串
    //，则返回一个无穷大值4294967295。
    int rindex = s1.rfind(s2, 3);
    if (rindex < s1.length())
        cout << "rfind at rindex : " << rindex << endl;
    else
        cout << "Not found" << endl;

    //    find_first_of() 函数用于查找子字符串和字符串共同具有的字符在字符串中首次出现的位置
    // 本例中 s1 和 s3 共同具有的字符是 ’s’，该字符在 s1 中首次出现的下标是3
    string s3 = "asecond";
    index = s1.find_first_of(s2);
    if (index < s1.length())
        cout << "find_first_of at index : " << index << endl;
    else
        cout << "Not found" << endl;
}

int main()
{
    /*
    string s1;                 // 默认值 ""
    string s2 = "c plus plus"; // 与C风格的字符串不同，string 的结尾没有结束标志'\0'。
    string s3 = s2;
    string s4(5, 's'); // 初始化为由 5 个's'字符组成的字符串，也就是"sssss"
    */
    // lenTest();
    // appendTest();
    // inserTest();
    // eraseTest();
    // substrTest();
    findTest();
    return 0;
}