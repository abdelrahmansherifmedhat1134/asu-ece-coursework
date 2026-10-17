
#include<iostream>
#include<cmath>
#include<string>
using namespace std;


float calc_sum(float x, float y)
{

    return x+y;
}

bool isPrime(int x)
{
    for(int i=2;i<x;i++)
    {
        if(x%i==0 && x!=2 && x!=1)
            return 0;
    }
    return 1 ;
}


bool leap_year(int year)
{
    if(year%4==0 || year%400==0)
    {

        if(year%100==0 && year%400!=0)return 0;
        else return 1;

    }
    return 0;
}

/*
int main()
{
    int year=2000;
    int m=5;
    float x=15.2,y=15.3,z;
    z=calc_sum(x,y);
    if(leap_year(year))
        cout<<"yes leap year";
    else cout<<"not leap year";


}
*/
