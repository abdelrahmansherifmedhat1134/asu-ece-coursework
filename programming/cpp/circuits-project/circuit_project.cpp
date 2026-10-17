#include<iostream>
#include<string>
using namespace std;

//x="12.5"
float str_num(string x)
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
    return num+decimal;

}


float sub_parallel(string x)
{
    int i=0;
    float result;
    while(x[i]!='e')
    {


    while(i<x.length() && x[i]>='0' && x[i]<='9')
    {
        i++;
    }




    }


}


int main()
{

    string x="S 1 P 1 1 e 2 e";
    int i=0;
    if(x[i]=='s'||x[i]=='S')
    {

        float result=0,resistance;
        for(int m=0;x[i]!='e')
        {
            resistance=str_num(x[i])
            result=result+
        }
    }

}
