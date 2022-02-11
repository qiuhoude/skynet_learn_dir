#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
// g++ Hello.cpp -o Hello
void 
func(){
    using namespace std;
    cout << "http://www.google.com" <<endl;
}

int
main(){
     //声明命名空间std ,推荐再函数内部使用
    using namespace std;
   
    cout << "google address" <<endl;
    func();

    
    // int x;
    // float y;
    // endl 代替 \n; 最后l :end of line
    // cout<<"Please input an int number:"<<endl;
    // cin>>x;
    // cout<<"The int number is x= "<<x<<endl;
    // cout<<"Please input a float number:"<<endl;
    // cin>>y;
    // cout<<"The float number is y= "<<y<<endl;   

    char str[30];
    sprintf(str, ":%x",50);
    uint32_t ret = strtoul(str+1, NULL, 16);
    cout<<"ret:"<<ret<<", str:"<< str <<endl;   

    return 0;
}