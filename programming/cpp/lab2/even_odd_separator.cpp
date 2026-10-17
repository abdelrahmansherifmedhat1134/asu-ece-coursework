#include<iostream>
#include<vector>
using namespace std;




int main()
{
    vector<int> v,odd,even;
    int x;
    for(int i=50;;i++)
    {
        cin>>x;
        if(x<0)break;
        v.push_back(x);
    }
    for(int integer : v)
    {
        if((integer%2)==0)even.push_back(integer);
        else odd.push_back(integer);
    }
    for(int integer :even)
        cout<<integer<<" ";
    cout<<endl;
    for(int integer :odd)
    cout<<integer<<" ";
}


