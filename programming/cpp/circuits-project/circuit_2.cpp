/*
#include<iostream>
#include<string>
using namespace std;




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


float sub_series(string x ,int &a)
{
    int i=0;
    float result;
    while(x[i]!='e')
    {
        float y=str_num(x.substr(i),i);
        result+=y;
        i++;
    }
    i++;
    a+=i;
}






float sub_parallel(string x,int &a)
{
    int i=0;
    float result=0;
    while(x[i]!='e')
    {
        float y=str_num(x.substr(i),i);

        if(result==0)result=y;
        else result=(y*result)/(y+result);
        i++;
    }
    i++;
    a+=i;

}

//string x="S 1 P 1 1 e 2 e";
int main()
{
    int i=0;
    float result=0;
    string x= "p 3.3 s 1.1 1.1 1.1 e 3.3 e";





    if(x[0]=='s'||x[0]=='S')
    {
    i++;

    while(x[i]!='e')
    {
        float y ;
        if(x[i]=='s') y=sub_series(x.substr(i),i);


        else y=str_num(x.substr(i),i);

    result+=y;
    i++;
    }
    i++;
    cout<<result;
    }



    if(x[0]=='p'||x[0]=='P')
    {
    i++;

    while(x[i]!='e')
    {
        float y ;
        if(x[i]=='s') y=sub_series(x.substr(i),i);

        else if(x[i]=='p') y=sub_parallel(x.substr(i),i);

        else y=str_num(x.substr(i),i);

    if(result==0)result=y;
    else result=(y*result)/(y+result);
    i++;
    }
    i++;
    cout<<result;
    }



}



//main ba3basa
int main()
{
    int i=0;
    float result;
    string x= "s 1.1 1.1 p 2.2 2.2 e 1.1 e";
    while(x[i]!='e')
    {
        float y ;
        if(x[i]=='s') y=sub_series(x.substr(i),i);

        else if(x[i]=='p') y=sub_parallel(x.substr(i),i);

        else y=str_num(x.substr(i),i);

    result+=y;
    cout<<y<< " and "<<i<<endl;
    i++;
    }
    i++;
    cout<<result<<" and "<<i;
}




*/
