#include <iostream>
#include <string.h>
#include <cstdlib>
using namespace std;

class Array {
 public:
  Array(int len);
  Array(const Array& arr);
  ~Array();

 public:
  int operator[](int i) const { return m_p[i]; }  //获取元素（读取）
  int& operator[](int i) { return m_p[i]; }       //获取元素（写入）
  Array& operator=(const Array& arr);             //重载赋值运算符
  int length() const { return m_len; }

 private:
  int m_len;
  int* m_p;
};

Array::Array(int len) : m_len(len) {
  this->m_p = (int*)calloc(len, sizeof(int));
}

Array::Array(const Array& arr) {  //拷贝构造函数
  // 添加 const 限制后，可以将 const 对象和非 const 对象传递给形参了，因为非
  // const 类型可以转换为 const 类型。如果没有 const 限制，就不能将 const
  // 对象传递给形参，因为 const 类型不能转换为非 const
  // 类型，这就意味着，不能使用 const 对象来初始化当前对象了
  this->m_len = arr.m_len;
  this->m_p = (int*)calloc(this->m_len, sizeof(int));
  memcpy(this->m_p, arr.m_p, m_len * sizeof(int));
}

// operator=() 的返回值类型为Array
// &，这样不但能够避免在返回数据时调用拷贝构造函数，还能够达到连续赋值的目的。下面的语句就是连续赋值

Array& Array::operator=(const Array& arr) {  //重载赋值运算符
  cout << "call operator=" << endl;
  if (this != &arr) {  // 不是给自己赋值
    cout << "call operator= this!=&arr" << endl;
    this->m_len = arr.m_len;
    free(this->m_p);  //释放原来的内存
    this->m_p = (int*)calloc(this->m_len, sizeof(int));
    memcpy(this->m_p, arr.m_p, m_len * sizeof(int));
  }
  return *this;  // 表示返回当前对象 。
}

Array::~Array() {
  cout << "del " << m_p[0] << endl;
  free(this->m_p);
}

//打印数组元素
void printArray(const Array& arr) {
  int len = arr.length();
  for (int i = 0; i < len; i++) {
    if (i == len - 1) {
      cout << arr[i] << endl;
    } else {
      cout << arr[i] << ", ";
    }
  }
}

int main() {
  Array arr1 = 10; // 其实也调用的转换构造器 Array arr1(10)
  arr1[0] = 1;
  for (int i = 1; i < 10; i++) {
    arr1[i] = i;
  }
  printArray(arr1);

  Array arr2 = arr1;  // 调用了copy构造器
  arr1[0] = 2;
  arr2[3] = 29;
  printArray(arr2);

  Array arr3(5);
  arr3[0] = 3;
  for (int i = 0; i < 5; i++) {
    arr3[i] = i;
  }
  printArray(arr3);

  arr3 = arr1;  //调用operator=()
  printArray(arr3);
  arr3[3] = 234;  //修改arr1的数据不会影响arr2
  arr3[7] = 920;
  printArray(arr3);
  printArray(arr1);
  arr3 = arr3;
  return 0;
}