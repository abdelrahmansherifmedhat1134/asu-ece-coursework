#include<iostream>
#include<vector>
#include<cmath>
using namespace std;


void display_k_largest_elements(int a[], int a_size, int k)
{
    int z=max(a_size,k);
    int temp;
    for(int x=0;x<z-1;x++)
    {
        for(int i=0;i<z;i++)
        {
            if(a[i]<a[i+1])
            {
                temp=a[i+1];
                a[i+1]=a[i];
                a[i]=temp;
            }
        }
    }

    for(int i=0;i<k;i++)cout<<a[i]<<" ";
}


int main()
{
    int n,k;
    cin>>n>>k;
    int z=max(n,k);
    int a[z]={0};
    for(int i=0;i<n;i++)
        cin>>a[i];
    display_k_largest_elements(a,n,k);
  /*  for(int i=0;i<n;i++)
        cout<<a[i];
*/}
