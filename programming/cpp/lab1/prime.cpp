#include<iostream>
using namespace std;



int is_prime(int x)
{
    for(int i=2;i<x;i++)
    {

        if(x%i==0)
        {
            return 0;
        }

    }
    return 1;
}

/*
int main()
{
    int low,high,flag;
    cin>>low>>high;

    for(int i=low;i<=high;i++)
    {
        if(i==0 || i==1)continue;
        if(i==2)cout<<2<<endl;
        else if(is_prime(i))
            cout<<i<<endl;

    }
    return 0;
}
*/
