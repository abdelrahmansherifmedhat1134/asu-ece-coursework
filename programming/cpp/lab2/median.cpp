#include<iostream>
#include<vector>
using namespace std ;


float calc_median(int a[],int a_size)
{
    float sum=0;
    for(int i=0;i<a_size;i++)
        sum+=a[i];
    return sum/a_size ;

}


int main()
{
    int n ;
    cin>>n ;
    int a[n];
    for(int i=0;i<n;i++)
        cin>>a[i];
    cout<<calc_median(a,n);

    return 0;

}
