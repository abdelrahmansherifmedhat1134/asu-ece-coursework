
#include <iostream>
#include <cmath>
using namespace std ;


/*
int main ()
{
    float x , y , z ;
    cout<< "please enter first number: "<<endl ; cin>> x ;
    cout<< "please enter second number: "<<endl ; cin>> y ;
    cout<< "please enter third number: "<<endl ; cin>> z  ;

    if(x>y){
        if(x>z)cout<<"the greatest number is x: "<<x  ;
    }
    else if(y>x){
        if(y>z)cout<<"the greatest number is y: "<<y  ;
    }
    else cout<<"the greatest number is z : " <<z ;


    return 0 ;
}
*/

/*
int main()
{
    int month;
    cout<<"enter a month: "; cin>>month ;

    switch(month)
    {
    case 1:
        cout<<"31 days" ;
        break ;
    case 2:
        cout<<"28 or 29 days" ;
        break ;
    }


    return 0 ;
}
*/


int main()
{
    int x ;
    cout<<"please enter a number: " ; cin>>x ;

    for(int i=2;i<x;i++)
    {
        if(x%i==0)
        {
            cout<<"number is not prime" ;
            break ;
        }


        if(x%i!=0){
            if(i<(x-1)) continue ;
            if(i==(x-1)){
              cout<<"number is prime" ;
              break ;
            }

        }

    }

    return 0 ;
}
