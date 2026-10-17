#include<iostream>
#include<string>
#include<cmath>
using namespace std;



/*
float pi=3.14 ;

double perimeter(float r);
double area(float r);











int main()
{
    float r;
    cout<<"enter r "; cin>>r;
    cout<<"area ="<<area(r)<<endl;
    cout<<"perimeter ="<<perimeter(r)<<endl;


    return 0;
}



double perimeter(float r)
{
    return pi*2*r ;
}

double area(float r)
{
    return pi*r*r ;
}
*/

/*
float m(float x)
{
    return (7*pow(x,3)-5*x*x+2*x+11);
}

float y(float x)
{
    return (m(x*x)+m(5*x))/m(pow(x,0.2*0.5));

}

int main()
{
    for(float i=0;i<=10;i+=0.1)
    {
        cout<<y(i)<<endl;
    }
}

*/


void false_swap(int &x,int &y)
{
    int temp=x;
    x=y;
    y=temp;
}

int main()
{
    int a=15 , b=6;
    false_swap(a,b);
    cout<<"a is "<<a<<" and b is "<<b;
    return 0;
}



/*

0**0**0
*00*00*
0*000*0
00*0*00
000*000


*/
