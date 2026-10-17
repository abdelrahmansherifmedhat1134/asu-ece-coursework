#include<iostream>
#include<string>

//x="12.5"
float str_num(string x,int &a)
{
    float num=0;
    int i=0;
    while(x[i]>='0' && x[i]<='9' && i<x.length())
    {
        num= (num*10)+(x[i]-'0');
        i++;
    }
    float decimal=0;
    int m=1;
    if(x[i]=='.')
    {
        i++;
        while(x[i]>='0' && x[i]<='9' && i<x.length())
        {
            decimal= (decimal*10)+(x[i]-'0');
            i++;
            m*=10;
        }
        decimal=decimal/m;

    }
    a+=i;
    return num+decimal;

}


int main()
{
    string x="s 12.5 15.4 4.1 2 4 e";
    int i=0;
    cout<<"the string "<<x<<endl;
    while(x[i]!='e')
    {
        cout<<"the number"<<str_num(x.substr(i),i)<<" i "<<i<<endl;
        i++;
    }
    return 0;
}
