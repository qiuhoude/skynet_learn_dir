#include <iostream>

/*

流状态对应的标志位
1. badbit
发生了（或许是物理上的）致命性错误，流将不能继续使用。
2. eofbit
输入结束（文件流的物理结束或用户结束了控制台流输入，例如用户按下了 win Ctrl+Z 或
unix Ctrl+D 组合键。
3. failbit
 I/O操作失败，主要原因是非法数据（例如，试图读取数字时遇到字母）。流可以继续使用，但会设置
4. goodbit
一切止常，没有错误发生，也没有输入结束。


我们在处理 fail() 时所使用的
cin.clear()。当流发生错误时，我们可以进行错误恢复。为了恢复错误，我们显式地将流从
fail() 状态转移到其他状态，从而可以继续从中读取字符。clear()
就起到这样的作用——执行 cin.clear() 后，cin 的状态就变为 good()
*/

using namespace std;

//从 ist 中读入整数到 v 中，直到遇到 eof() 或终结符
void fill_vector(istream& ist, vector<int>& v, char terminator) {
  for (int i; ist >> i;) v.push_back(i);
  //正常情况
  if (ist.eof()) return;  //发现到了文件尾，正确，返回
  //发生严重错误，只能退出函数
  if (ist.bad()) {
    error("cin is bad!");  // error是自定义函数，它抛出异常，并给出提示信息
  }
  //发生意外情况
  if (ist.fail()) {  //最好清除混乱，然后汇报问题
    ist.clear();     //清除流状态
    //检测下一个字符是否是终结符
    char c;
    ist >> c;                        //读入一个符号，希望是终结符
    if (c != terminator) {           // 非终结符
      ist.unget();                   //放回该符号
      ist.clear(ios_base::failbit);  //将流状态设置为 fail()
    }
  }
}

//从ist中读入整数到v中，直到遇到eof()或终结符
void fill_vector2(istream& ist, vector<int>& v, char terminator){
    ist.exceptions(ist.exceptions() | ios_base:: badbit);
    for (int i; ist>>i; ) v.push_back(i);
    if (ist.eof()) return;  //发现到了文件尾
    //不是good()，不是bad()，不是eof()，ist的状态一定是fail()
    ist.clear();  //清除流状态
    char c;
    ist>>c;    //读入一个符号，希望是终结符
    if (c != terminator) { //不是终结符号，一定是失败了
        ist.unget();    //也许程序调用者可以使用这个符号
        ist.clear(ios_base::failbit); //将流状态设置为 fail()
    }
}