#include<iostream>
#include<string>
using namespace std;


string one(string x)
{

    for(int i=0;i<x.length();i++)
    {
        if(x[i]=='1')
            x[i]='0';
        else
            x[i]='1';

    }
     return x;
}

string two(string x)
{
    int flag=0 ;
    for(int i=x.length()-1;i>=0;i--)
    {

        if(x[i]=='1'&&flag==0)
        {
            x[i]='1';
            flag=1;
        }
        else if(x[i]=='1'&& flag==1)
            x[i]='0';
        else if(x[i]=='0'&& flag==1)
            x[i]='1';
        else continue;

    }

    return x;
}

/*


int main()
{
    string y ,z, str;
    cin>>str;

    y=one(str);
    z=two(str);
    cout<<y<<endl<<z;


    return 0;
}
*/
