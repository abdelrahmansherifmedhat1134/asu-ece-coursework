#include<iostream>
#include<cmath>
using namespace std ;

/*
int main()
{
    float a ,b,c,x,z,y ;
    cout<<"enter a,b, c : " ;
    cin>>a>>b>>c ;

    z=pow(b,2)-(4*a*c) ;
    if (z>0)
    {
        x=(-b+sqrt(z))/(2*a) ;
        y=(-b-sqrt(z))/(2*a) ;

        cout<<x<<endl ;
        cout<<y<<endl ;
    }
    else{
        cout<<"there are no real solutions " ;
    }

    return 0 ;

}
*/


int main()
{
    int x ;
    cout<<"enter a positive integer number " ;

    cin>>x ;
    for(int i=1;i<x;i++)
    {

        cout<<i<<endl ;
    }



    return 0 ;
}
